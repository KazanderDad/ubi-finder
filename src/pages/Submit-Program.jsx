





import { supabase } from "@/lib/supabaseClient";
import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import { Separator } from "@/components/ui/separator";
import { ChevronLeft, Save, Plus, X, LockKeyhole } from "lucide-react";
const COUNTRIES = [
  "Global",
  "Worldwide",
  "United States",
  "Canada",
  "United Kingdom",
  "Australia",
  "New Zealand",
  "Germany",
  "France",
  "Spain",
  "Italy",
  "Ireland",
  "Sweden",
  "Netherlands",
  "Switzerland",
  "Japan",
  "South Korea",
  "Brazil",
  "Mexico",
  "Colombia",
  "South Africa",
  "Kenya",
  "India"
];

const US_STATES = [
  "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", 
  "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", 
  "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", 
  "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", 
  "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", 
  "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", 
  "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming",
  "District of Columbia"
];

const CANADIAN_PROVINCES = [
  "Alberta", "British Columbia", "Manitoba", "New Brunswick", "Newfoundland and Labrador",
  "Northwest Territories", "Nova Scotia", "Nunavut", "Ontario", "Prince Edward Island",
  "Quebec", "Saskatchewan", "Yukon"
];

const STANDARD_CURRENCIES = ["USD", "EUR", "GBP", "CAD", "AUD", "JPY", "BTC", "ETH"];

export default function SubmitProgramPage() {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [user, setUser] = useState(null);
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [loginAlertOpen, setLoginAlertOpen] = useState(false);
  const [submissionSuccess, setSubmissionSuccess] = useState(false);
  const [isOtherCurrency, setIsOtherCurrency] = useState(false);
  
  const [formData, setFormData] = useState({
    name: "",
    organization: "",
    description: "",
    gender_requirement: null,
    monthly_amount_usd: "",
    currency: "USD",
    available_regions: [],
    required_states: [],
    payment_method: "standard",
    amount_description: "",
    max_household_income_usd: null,
    eligibility: "",
    status: "active_open",
    website: "",
    verified: false
  });

  const [selectedCountry, setSelectedCountry] = useState("");
  const [selectedState, setSelectedState] = useState("");
  const [regions, setRegions] = useState([]);
  const [requiredStates, setRequiredStates] = useState([]);

  useEffect(() => {
    window.scrollTo(0, 0);
    checkAuth();
  }, []);

  const checkAuth = async () => {
    try {
      const userData = (await supabase.auth.getUser()).data.user;
      setUser(userData);
      setIsAuthenticated(true);
      setLoading(false);
      // Only load program ID if user is authenticated
      loadNextProgramId();
    } catch (error) {
      setUser(null);
      setIsAuthenticated(false);
      setLoading(false);
      // Show login dialog automatically if not authenticated
      handleLogin();
    }
  };

  const handleLogin = async () => {
    try {
      navigate("/login?view=signup&redirectTo=/Submit-Program");
    } catch (error) {
      console.error("Login failed:", error);
      navigate("/Programs");
    }
  };

  const loadNextProgramId = async () => {
    try {
      const programs = (await supabase.from('programs').select('*')).data;
      const maxId = programs.length > 0 
        ? Math.max(...programs.map(p => p.program_id || 0))
        : 0;
      setFormData(prev => ({
        ...prev,
        program_id: maxId + 1
      }));
    } catch (error) {
      console.error("Error loading programs:", error);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (!isAuthenticated) {
      setLoginAlertOpen(true);
      return;
    }

    try {
      setLoading(true);
      const userData = (await supabase.auth.getUser()).data.user;
      
      // Get user's profile first
      const profiles = (await supabase.from('user_profiles').select('*').match({ created_by: userData.email })).data;
      if (!profiles.length) {
        throw new Error("User profile not found");
      }
      const userProfile = profiles[0];
      
      // Ensure program_id is a number and not null
      if (!formData.program_id || isNaN(formData.program_id)) {
        const programs = (await supabase.from('programs').select('*')).data;
        const maxId = programs.length > 0 
          ? Math.max(...programs.map(p => p.program_id || 0))
          : 0;
        formData.program_id = maxId + 1;
      }
      
      // Convert to integer for saving
      const programId = parseInt(formData.program_id);
      const sanitizedMonthlyAmount = formData.monthly_amount_usd !== "" && !isNaN(Number(formData.monthly_amount_usd))
        ? Number(formData.monthly_amount_usd)
        : 0;
      
      // Create the program
      (await supabase.from('programs').insert([{
        ...formData,
        program_id: programId,
        monthly_amount_usd: sanitizedMonthlyAmount,
        submitter_email: userData.email,
        verified: false,
        status: 'pending_approval'
      }]).select().single()).data;

      // Create program manager record with owner role and user profile ID
      (await supabase.from('program_managers').insert([{
        program_id: programId,
        user_email: userData.email,
        user_profile_id: userProfile.id, // Add this line
        role: "owner",
        added_date: new Date().toISOString()
      }]).select().single()).data;

      setSubmissionSuccess(true);
      setTimeout(() => {
        navigate("/Programs");
      }, 2000);
    } catch (error) {
      console.error("Error submitting program:", error);
      // Show error to user
      toast({
        title: "Error submitting program",
        description: "Please make sure you have created a profile before submitting a program.",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (field, value) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
  };

  const handleSelectRegion = (country) => {
    if (!country) return;
    if (!regions.includes(country)) {
      const newRegions = [...regions, country];
      setRegions(newRegions);
      setFormData(prev => ({
        ...prev,
        available_regions: newRegions
      }));
    }
    setSelectedCountry("");
  };

  const addRegion = () => {
    if (selectedCountry) {
      handleSelectRegion(selectedCountry);
    }
  };

  const removeRegion = (region) => {
    const newRegions = regions.filter(r => r !== region);
    setRegions(newRegions);
    setFormData(prev => ({
      ...prev,
      available_regions: newRegions
    }));
  };
  
  const handleSelectState = (state) => {
    if (!state) return;
    if (!requiredStates.includes(state)) {
      const newStates = [...requiredStates, state];
      setRequiredStates(newStates);
      setFormData(prev => ({
        ...prev,
        required_states: newStates
      }));
    }
    setSelectedState("");
  };

  const addState = () => {
    if (selectedState) {
      handleSelectState(selectedState);
    }
  };

  const removeState = (state) => {
    const newStates = requiredStates.filter(s => s !== state);
    setRequiredStates(newStates);
    setFormData(prev => ({
      ...prev,
      required_states: newStates
    }));
  };
  
  // Check if any of the selected regions are USA or Canada
  const showStatesSelector = regions.some(r => r === "United States" || r === "Canada");
  
  // Get appropriate states/provinces options based on selected regions
  const getStateOptions = () => {
    if (regions.includes("United States") && regions.includes("Canada")) {
      return [...US_STATES, ...CANADIAN_PROVINCES];
    } else if (regions.includes("United States")) {
      return US_STATES;
    } else if (regions.includes("Canada")) {
      return CANADIAN_PROVINCES;
    }
    return [];
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 flex items-center justify-center">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-700"></div>
      </div>
    );
  }

  if (!isAuthenticated) {
    return (
      <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-12">
        <div className="max-w-md mx-auto text-center">
          <Card className="shadow-lg border-emerald-100">
            <CardHeader>
              <CardTitle className="text-xl text-emerald-950 font-bold">Account Required</CardTitle>
              <CardDescription>
                Please sign up or log in to submit a new UBI program
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <p className="text-gray-600 text-sm">
                To ensure the quality and accuracy of our database, we require contributors to create a free account before submitting new programs.
              </p>
              <Button 
                onClick={handleLogin}
                className="w-full bg-emerald-700 hover:bg-emerald-800 text-white font-bold py-5"
              >
                <LockKeyhole className="w-4 h-4 mr-2" />
                Sign Up to Submit a Program
              </Button>
              <div className="pt-2 text-xs text-gray-500">
                Already have an account?{" "}
                <button
                  onClick={() => navigate("/login?redirectTo=/Submit-Program")}
                  className="text-emerald-700 font-bold hover:underline cursor-pointer"
                >
                  Sign in here
                </button>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-12">
      <div className="max-w-3xl mx-auto">
        <div className="flex justify-between items-center mb-6">
          <Button 
            variant="ghost" 
            className="text-green-700"
            onClick={() => navigate("/Programs")}
          >
            <ChevronLeft className="w-5 h-5 mr-1" />
            Back to Programs
          </Button>
        </div>

        <Card className="shadow-lg">
          <CardHeader>
            <CardTitle className="text-2xl text-green-800">Submit New UBI Program</CardTitle>
            <CardDescription>
              Help us grow our database by submitting a new UBI program. All submissions will be reviewed for accuracy before posting. Please review the Programs listing first to  avoid lisiting duplicate entries. 
            </CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSubmit} className="space-y-6">
              <div className="space-y-4">
                <div>
                  <Label>Program Name</Label>
                  <Input
                    required
                    value={formData.name}
                    onChange={(e) => handleChange("name", e.target.value)}
                    placeholder="Enter program name"
                  />
                </div>

                <div>
                  <Label>Organization</Label>
                  <Input
                    required
                    value={formData.organization}
                    onChange={(e) => handleChange("organization", e.target.value)}
                    placeholder="Organization running the program"
                  />
                </div>

                <div>
                  <Label>Website</Label>
                  <Input
                    type="url"
                    required
                    value={formData.website}
                    onChange={(e) => handleChange("website", e.target.value)}
                    placeholder="https://..."
                  />
                </div>

                <div>
                  <Label>Description</Label>
                  <Textarea
                    required
                    value={formData.description}
                    onChange={(e) => handleChange("description", e.target.value)}
                    placeholder="Detailed description of the program"
                    className="h-32"
                  />
                </div>

                <div>
                  <Label>UBI Payout Terms, Amount and Description</Label>
                  <Input
                    required
                    value={formData.amount_description}
                    onChange={(e) => handleChange("amount_description", e.target.value)}
                    placeholder="e.g., $500 monthly for 12 months"
                  />
                </div>

                <div>
                  <Label>Monthly Equivalent Value in USD</Label>
                  <Input
                    type="number"
                    required
                    min="0"
                    step="any"
                    value={formData.monthly_amount_usd}
                    onChange={(e) => handleChange("monthly_amount_usd", e.target.value)}
                    placeholder="e.g. 500"
                  />
                </div>

                <div>
                  <Label>Currency</Label>
                  <Select
                    value={STANDARD_CURRENCIES.includes(formData.currency) ? formData.currency : (isOtherCurrency || formData.currency ? "OTHER" : "USD")}
                    onValueChange={(value) => {
                      if (value === "OTHER") {
                        setIsOtherCurrency(true);
                        handleChange("currency", "");
                      } else {
                        setIsOtherCurrency(false);
                        handleChange("currency", value);
                      }
                    }}
                    required
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Select currency" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="USD">USD - US Dollar</SelectItem>
                      <SelectItem value="EUR">EUR - Euro</SelectItem>
                      <SelectItem value="GBP">GBP - British Pound</SelectItem>
                      <SelectItem value="CAD">CAD - Canadian Dollar</SelectItem>
                      <SelectItem value="AUD">AUD - Australian Dollar</SelectItem>
                      <SelectItem value="JPY">JPY - Japanese Yen</SelectItem>
                      <SelectItem value="BTC">BTC - Bitcoin</SelectItem>
                      <SelectItem value="ETH">ETH - Ethereum</SelectItem>
                      <SelectItem value="OTHER">Other (Specify custom currency)</SelectItem>
                    </SelectContent>
                  </Select>

                  {(isOtherCurrency || (formData.currency && !STANDARD_CURRENCIES.includes(formData.currency))) && (
                    <div className="mt-2 animate-in fade-in duration-150">
                      <Input
                        type="text"
                        placeholder="Enter currency code or symbol (e.g. SEK, NZD, G$, SOL)"
                        value={formData.currency === "OTHER" ? "" : formData.currency}
                        onChange={(e) => handleChange("currency", e.target.value.toUpperCase())}
                        required
                        className="bg-gray-50/90 font-medium"
                      />
                      <p className="text-xs text-gray-500 mt-1">
                        Please specify the 3-letter currency code or token symbol.
                      </p>
                    </div>
                  )}
                </div>

                <div>
                  <Label>Payment Method</Label>
                  <Select
                    value={formData.payment_method}
                    onValueChange={(value) => handleChange("payment_method", value)}
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Select payment method" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="standard">Standard (Bank Transfer)</SelectItem>
                      <SelectItem value="digital">Digital (Crypto/Digital Wallet)</SelectItem>
                    </SelectContent>
                  </Select>
                </div>

                <div>
                  <Label>Program Status</Label>
                  <Select
                    value={formData.status}
                    onValueChange={(value) => handleChange("status", value)}
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Select status" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="active_open">Active, open for applications</SelectItem>
                      <SelectItem value="active_closed">Active, applications closed</SelectItem>
                      <SelectItem value="upcoming">Upcoming</SelectItem>
                      <SelectItem value="closed">Closed</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>

              <Separator className="my-6" />
              
              <div>
                <h3 className="text-lg font-semibold text-green-800 mb-4">Eligibility Requirements</h3>
                <div className="space-y-6">
                  <div>
                    <Label>Is There a Maximum Household Income? (USD equivalent, optional)</Label>
                    <Input
                      type="number"
                      min="0"
                      value={formData.max_household_income_usd || ""}
                      onChange={(e) => handleChange("max_household_income_usd", e.target.value ? parseFloat(e.target.value) : null)}
                      placeholder="Leave empty if no limit"
                    />
                  </div>
                  
                  <div>
                    <Label>Gender Requirement</Label>
                    <Select
                      value={formData.gender_requirement || ""}
                      onValueChange={(value) => handleChange("gender_requirement", value === "" ? null : value)}
                    >
                      <SelectTrigger>
                        <SelectValue placeholder="Select gender requirement" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value={null}>Not applicable</SelectItem>
                        <SelectItem value="female">Female only</SelectItem>
                        <SelectItem value="male">Male only</SelectItem>
                        <SelectItem value="other">other gender-related requirement (please describe below)</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>

                  <div>
                    <Label>Available Regions (select one or multiple countries)</Label>
                    <div className="flex gap-2 mb-2">
                      <Select
                        value={selectedCountry}
                        onValueChange={handleSelectRegion}
                      >
                        <SelectTrigger className="flex-1">
                          <SelectValue placeholder="Add country / region..." />
                        </SelectTrigger>
                        <SelectContent>
                          {COUNTRIES.map(country => (
                            <SelectItem key={country} value={country}>
                              {regions.includes(country) ? `✓ ${country}` : country}
                            </SelectItem>
                          ))}
                        </SelectContent>
                      </Select>
                      <Button type="button" onClick={addRegion} className="cursor-pointer">
                        <Plus className="w-4 h-4 mr-1" /> Add
                      </Button>
                    </div>
                    {regions.length > 0 && (
                      <div className="flex flex-wrap gap-2 p-2.5 bg-gray-50/80 rounded-xl border border-gray-100">
                        {regions.map(region => (
                          <div
                            key={region}
                            className="bg-green-100 text-green-800 text-xs font-semibold px-3 py-1.5 rounded-full flex items-center gap-1.5 shadow-xs"
                          >
                            <span>{region}</span>
                            <button
                              type="button"
                              onClick={() => removeRegion(region)}
                              className="hover:text-red-700 rounded-full hover:bg-green-200/60 p-0.5 transition-colors cursor-pointer"
                              title={`Remove ${region}`}
                            >
                              <X className="w-3.5 h-3.5" />
                            </button>
                          </div>
                        ))}
                      </div>
                    )}
                  </div>

                  {showStatesSelector && (
                    <div>
                      <Label>Required States/Provinces</Label>
                      <div className="flex gap-2 mb-2">
                        <Select
                          value={selectedState}
                          onValueChange={handleSelectState}
                        >
                          <SelectTrigger className="flex-1">
                            <SelectValue placeholder="Add state / province..." />
                          </SelectTrigger>
                          <SelectContent>
                            {getStateOptions().map(state => (
                              <SelectItem key={state} value={state}>
                                {requiredStates.includes(state) ? `✓ ${state}` : state}
                              </SelectItem>
                            ))}
                          </SelectContent>
                        </Select>
                        <Button type="button" onClick={addState} className="cursor-pointer">
                          <Plus className="w-4 h-4 mr-1" /> Add
                        </Button>
                      </div>
                      {requiredStates.length > 0 && (
                        <div className="flex flex-wrap gap-2 p-2.5 bg-gray-50/80 rounded-xl border border-gray-100">
                          {requiredStates.map(state => (
                            <div
                              key={state}
                              className="bg-blue-100 text-blue-800 text-xs font-semibold px-3 py-1.5 rounded-full flex items-center gap-1.5 shadow-xs"
                            >
                              <span>{state}</span>
                              <button
                                type="button"
                                onClick={() => removeState(state)}
                                className="hover:text-red-700 rounded-full hover:bg-blue-200/60 p-0.5 transition-colors cursor-pointer"
                                title={`Remove ${state}`}
                              >
                                <X className="w-3.5 h-3.5" />
                              </button>
                            </div>
                          ))}
                        </div>
                      )}
                    </div>
                  )}

                  <div>
                    <Label>Other Detailed Requirements</Label>
                    <Textarea
                      required
                      value={formData.eligibility}
                      onChange={(e) => handleChange("eligibility", e.target.value)}
                      placeholder="Additional eligibility requirements not covered above"
                      className="h-32"
                    />
                  </div>
                </div>
              </div>

              <Separator />

              <div className="flex justify-end gap-4">
                <Button
                  type="button"
                  variant="outline"
                  onClick={() => navigate("/Programs")}
                >
                  Cancel
                </Button>
                <Button 
                  type="submit"
                  className="bg-green-700 hover:bg-green-800"
                  disabled={loading}
                >
                  {loading ? (
                    <div className="flex items-center">
                      <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2" />
                      Submitting...
                    </div>
                  ) : (
                    <>
                      <Save className="w-4 h-4 mr-2" />
                      Submit Program
                    </>
                  )}
                </Button>
              </div>
            </form>
          </CardContent>
        </Card>

        <AlertDialog open={loginAlertOpen} onOpenChange={setLoginAlertOpen}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>Login Required</AlertDialogTitle>
              <AlertDialogDescription>
                Please log in to submit a new program. This helps us maintain quality and track submissions.
              </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogCancel>Cancel</AlertDialogCancel>
              <AlertDialogAction onClick={() => User.login()}>
                Log In
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>

        <AlertDialog open={submissionSuccess} onOpenChange={setSubmissionSuccess}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>Success!</AlertDialogTitle>
              <AlertDialogDescription>
                Thank you for submitting a new program. Our team will review it shortly.
              </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogAction onClick={() => navigate("/Programs")}>
                Back to Programs
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </div>
  );
}

