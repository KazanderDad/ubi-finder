import { supabase } from "@/lib/supabaseClient";
import { notifyAdminsOfNewSubmission } from "@/lib/adminNotifications";
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
import { Checkbox } from "@/components/ui/checkbox";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Separator } from "@/components/ui/separator";
import { 
  ChevronLeft, 
  Save, 
  Plus, 
  X, 
  LockKeyhole, 
  Link2, 
  Globe, 
  Search, 
  CheckCircle2, 
  AlertCircle, 
  Info, 
  Sparkles, 
  UserCheck 
} from "lucide-react";

const COUNTRIES = [
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
  const [submitting, setSubmitting] = useState(false);
  const [, setUser] = useState(null);
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [loginAlertOpen, setLoginAlertOpen] = useState(false);
  const [submissionSuccess, setSubmissionSuccess] = useState(false);
  
  // Confirmation gate: User must acknowledge checking the database before editing form
  const [hasSearchedConfirmation, setHasSearchedConfirmation] = useState(false);
  const [acknowledgmentChecked, setAcknowledgmentChecked] = useState(false);

  // Custom field toggles
  const [isOtherCurrency, setIsOtherCurrency] = useState(false);
  const [isOtherPaymentMethod, setIsOtherPaymentMethod] = useState(false);
  const [isOtherStatus, setIsOtherStatus] = useState(false);
  const [isGlobal, setIsGlobal] = useState(false);

  // Additional link URLs (papers, news, studies)
  const [additionalLinks, setAdditionalLinks] = useState([]);
  
  const [formData, setFormData] = useState({
    program_id: 0,
    name: "",
    organization: "",
    submission_role: "know_of", // "know_of" | "involved"
    description: "",
    gender_requirement: "",
    min_age: null,
    max_age: null,
    monthly_amount_usd: "",
    currency: "USD",
    available_regions: [],
    required_states: [],
    payment_method: "standard",
    custom_payment_method: "",
    amount_description: "",
    max_household_income_usd: null,
    eligibility: "",
    status: "active_open",
    custom_status: "",
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
      const userData = (await supabase.auth.getUser()).data?.user;
      if (userData) {
        setUser(userData);
        setIsAuthenticated(true);
        loadNextProgramId();
      } else {
        setUser(null);
        setIsAuthenticated(false);
      }
    } catch (error) {
      console.error("Auth check failed:", error);
      setUser(null);
      setIsAuthenticated(false);
    } finally {
      setLoading(false);
    }
  };

  const handleLogin = () => {
    navigate("/login?view=signup&redirectTo=/Submit-Program");
  };

  const loadNextProgramId = async () => {
    try {
      const { data: programs } = await supabase.from('programs').select('program_id');
      const maxId = programs && programs.length > 0 
        ? Math.max(...programs.map(p => p.program_id || 0))
        : 0;
      setFormData(prev => ({
        ...prev,
        program_id: maxId + 1
      }));
    } catch (error) {
      console.error("Error loading program ID:", error);
    }
  };

  const handleChange = (field, value) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
  };

  // Additional link handlers
  const handleAddLink = () => {
    setAdditionalLinks(prev => [...prev, ""]);
  };

  const handleUpdateLink = (index, value) => {
    setAdditionalLinks(prev => {
      const updated = [...prev];
      updated[index] = value;
      return updated;
    });
  };

  const handleRemoveLink = (index) => {
    setAdditionalLinks(prev => prev.filter((_, i) => i !== index));
  };

  // Region handlers
  const handleToggleGlobal = (checked) => {
    setIsGlobal(checked);
    if (checked) {
      setRegions(["Global"]);
      setRequiredStates([]);
      setFormData(prev => ({
        ...prev,
        available_regions: ["Global"],
        required_states: []
      }));
    } else {
      setRegions([]);
      setFormData(prev => ({
        ...prev,
        available_regions: []
      }));
    }
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
  
  const showStatesSelector = !isGlobal && regions.some(r => r === "United States" || r === "Canada");
  
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

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (!isAuthenticated) {
      setLoginAlertOpen(true);
      return;
    }

    try {
      setSubmitting(true);
      const userData = (await supabase.auth.getUser()).data?.user;
      if (!userData) {
        setLoginAlertOpen(true);
        return;
      }
      
      // Look up profile safely
      let userProfileId = userData.user_metadata?.profile_id || localStorage.getItem("user_profile_id");
      if (!userProfileId && userData.id) {
        const { data: profs } = await supabase.from('user_profiles').select('id').eq('created_by_id', userData.id);
        if (profs && profs.length > 0) userProfileId = profs[0].id;
      }
      
      // Ensure program_id is a number and not null
      let programId = formData.program_id;
      if (!programId || isNaN(programId)) {
        const { data: programs } = await supabase.from('programs').select('program_id');
        const maxId = programs && programs.length > 0 
          ? Math.max(...programs.map(p => p.program_id || 0))
          : 0;
        programId = maxId + 1;
      }
      programId = Number.parseInt(String(programId), 10);

      const sanitizedMonthlyAmount = formData.monthly_amount_usd !== "" && !isNaN(Number(formData.monthly_amount_usd))
        ? Number(formData.monthly_amount_usd)
        : 0;
      
      const finalRegions = isGlobal ? ["Global"] : (regions.length > 0 ? regions : ["Global"]);

      // Combine sources / links
      const allSources = [formData.website, ...additionalLinks.map(l => l.trim())].filter(Boolean);

      // Payment method & status formatting
      const finalPaymentMethod = isOtherPaymentMethod && formData.custom_payment_method
        ? `other: ${formData.custom_payment_method}`
        : formData.payment_method;

      const finalStatus = isOtherStatus && formData.custom_status
        ? `other: ${formData.custom_status}`
        : formData.status;

      // Gender requirement: null if empty or none
      const finalGender = (formData.gender_requirement === "" || formData.gender_requirement === "none" || !formData.gender_requirement)
        ? null
        : formData.gender_requirement;

      // Insert program
      await supabase.from('programs').insert([{
        name: formData.name,
        organization: formData.organization,
        description: formData.description,
        gender_requirement: finalGender,
        min_age: formData.min_age !== "" && formData.min_age !== null && !isNaN(Number(formData.min_age)) ? parseInt(formData.min_age, 10) : null,
        max_age: formData.max_age !== "" && formData.max_age !== null && !isNaN(Number(formData.max_age)) ? parseInt(formData.max_age, 10) : null,
        monthly_amount_usd: sanitizedMonthlyAmount,
        currency: formData.currency || "USD",
        available_regions: finalRegions,
        required_states: isGlobal ? [] : requiredStates,
        payment_method: finalPaymentMethod,
        amount_description: formData.amount_description,
        max_household_income_usd: formData.max_household_income_usd,
        eligibility: formData.eligibility,
        status: finalStatus,
        website: formData.website,
        sources: allSources,
        program_id: programId,
        submitter_email: userData.email,
        verified: false
      }]);

      // Create program manager record if possible
      if (userProfileId) {
        await supabase.from('program_managers').insert([{
          program_id: programId,
          user_email: userData.email,
          user_profile_id: userProfileId,
          role: "owner",
          added_date: new Date().toISOString()
        }]);
      }

      // Notify platform admins & owners of the new submission
      notifyAdminsOfNewSubmission({
        program_id: programId,
        name: formData.name,
        organization: formData.organization,
        submitter_email: userData.email,
        amount_description: formData.amount_description,
        monthly_amount_usd: sanitizedMonthlyAmount,
        available_regions: finalRegions,
        website: formData.website,
      }).catch(err => console.warn("Admin notification non-blocking error:", err));

      setSubmissionSuccess(true);
      setTimeout(() => {
        navigate("/Programs");
      }, 2000);
    } catch (error) {
      console.error("Error submitting program:", error);
      alert("There was an issue submitting your program. Please try again.");
    } finally {
      setSubmitting(false);
    }
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
                className="w-full bg-emerald-700 hover:bg-emerald-800 text-white font-bold py-5 cursor-pointer"
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
            className="text-green-700 cursor-pointer"
            onClick={() => navigate("/Programs")}
          >
            <ChevronLeft className="w-5 h-5 mr-1" />
            Back to Programs
          </Button>
        </div>

        {!hasSearchedConfirmation ? (
          /* Pre-Submission Database Search Confirmation Screen */
          <Card className="shadow-lg border-emerald-200 bg-white">
            <CardHeader className="bg-gradient-to-r from-emerald-50 via-teal-50 to-green-50 border-b border-emerald-100/80 pb-6">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-2xl bg-emerald-100 border border-emerald-300 flex items-center justify-center text-emerald-800 shadow-inner">
                  <Search className="w-5 h-5" />
                </div>
                <div>
                  <CardTitle className="text-xl text-green-950 font-bold">
                    Check Database Before Submitting
                  </CardTitle>
                  <CardDescription className="text-xs text-emerald-800 mt-0.5">
                    Help us prevent duplicate entries in our global catalog.
                  </CardDescription>
                </div>
              </div>
            </CardHeader>
            <CardContent className="p-6 sm:p-8 space-y-6">
              <div className="p-4 bg-gray-50/90 rounded-2xl border border-gray-200/70 space-y-3">
                <div className="flex items-start gap-3">
                  <Info className="w-5 h-5 text-emerald-700 flex-shrink-0 mt-0.5" />
                  <div className="text-xs text-gray-700 space-y-2 leading-relaxed">
                    <p>
                      UBI Finder currently tracks over <strong>270+ basic income initiatives</strong> across 30+ countries, incorporating research data from the Stanford Basic Income Lab and ongoing community contributions.
                    </p>
                    <p>
                      Please verify that the program you want to add is not already listed in our directory. If your program is already listed but requires updates or corrections, you can manage or report details from its listing page.
                    </p>
                  </div>
                </div>

                <div className="pt-2 flex justify-start">
                  <Button
                    type="button"
                    variant="outline"
                    onClick={() => navigate("/Programs")}
                    className="border-emerald-600 text-emerald-800 hover:bg-emerald-50 text-xs font-semibold h-8 cursor-pointer"
                  >
                    <Search className="w-3.5 h-3.5 mr-1.5 text-emerald-700" />
                    Search the Programs Directory &rarr;
                  </Button>
                </div>
              </div>

              {/* Acknowledgment Checkbox */}
              <div className="p-4 bg-emerald-50/60 rounded-2xl border border-emerald-200/80">
                <label className="flex items-start gap-3 cursor-pointer select-none">
                  <Checkbox
                    id="search-acknowledgment"
                    checked={acknowledgmentChecked}
                    onCheckedChange={(checked) => setAcknowledgmentChecked(!!checked)}
                    className="mt-0.5 data-[state=checked]:bg-emerald-700 data-[state=checked]:border-emerald-700"
                  />
                  <div className="space-y-1">
                    <span className="text-xs sm:text-sm font-bold text-gray-900 leading-snug block">
                      I have searched through the database and didn't find my program
                    </span>
                    <span className="text-[11px] text-gray-500 block leading-tight">
                      Confirming this ensures our catalog remains clean, accurate, and duplicate-free.
                    </span>
                  </div>
                </label>
              </div>

              <div className="flex justify-end gap-3 pt-2">
                <Button
                  type="button"
                  onClick={() => setHasSearchedConfirmation(true)}
                  disabled={!acknowledgmentChecked}
                  className="bg-emerald-700 hover:bg-emerald-800 text-white font-bold text-xs px-6 h-10 shadow-sm cursor-pointer disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  Continue to Submission Form &rarr;
                </Button>
              </div>
            </CardContent>
          </Card>
        ) : (
          /* Main Submission Form (Unlocked after acknowledgment) */
          <Card className="shadow-lg border-green-100">
            <CardHeader>
              <CardTitle className="text-2xl text-green-800 font-extrabold">Submit New UBI Program</CardTitle>
              <CardDescription className="text-xs sm:text-sm text-gray-600 leading-relaxed mt-1">
                Help us grow our database by submitting a new UBI program. All submissions will be reviewed for accuracy before posting. Many fields are optional, we encourage you to populate what you know and to not guess if you don't have the answer.
              </CardDescription>
            </CardHeader>
            <CardContent>
              <form onSubmit={handleSubmit} className="space-y-6">
                <div className="space-y-4">
                  
                  {/* Connection / Submitter Role Radio Options */}
                  <div className="p-4 bg-emerald-50/50 rounded-2xl border border-emerald-100/80 space-y-3">
                    <Label className="text-xs sm:text-sm font-bold text-emerald-950 flex items-center gap-2">
                      <UserCheck className="w-4 h-4 text-emerald-700" />
                      What is your connection to this program?
                    </Label>
                    <RadioGroup
                      value={formData.submission_role}
                      onValueChange={(val) => handleChange("submission_role", val)}
                      className="grid grid-cols-1 sm:grid-cols-2 gap-2.5 pt-1"
                    >
                      <div 
                        onClick={() => handleChange("submission_role", "know_of")}
                        className={`flex items-center space-x-3 p-3 rounded-xl border transition-all cursor-pointer ${
                          formData.submission_role === "know_of"
                            ? "bg-white border-emerald-600 shadow-xs ring-1 ring-emerald-600"
                            : "bg-white/60 border-gray-200 hover:bg-white"
                        }`}
                      >
                        <RadioGroupItem value="know_of" id="role-know-of" />
                        <Label htmlFor="role-know-of" className="text-xs font-semibold text-gray-800 cursor-pointer">
                          I'm submitting a program I know of
                        </Label>
                      </div>

                      <div 
                        onClick={() => handleChange("submission_role", "involved")}
                        className={`flex items-center space-x-3 p-3 rounded-xl border transition-all cursor-pointer ${
                          formData.submission_role === "involved"
                            ? "bg-white border-emerald-600 shadow-xs ring-1 ring-emerald-600"
                            : "bg-white/60 border-gray-200 hover:bg-white"
                        }`}
                      >
                        <RadioGroupItem value="involved" id="role-involved" />
                        <Label htmlFor="role-involved" className="text-xs font-semibold text-gray-800 cursor-pointer">
                          I'm submitting a program that I'm involved with
                        </Label>
                      </div>
                    </RadioGroup>
                  </div>

                  <div>
                    <Label className="font-semibold">Program Name</Label>
                    <Input
                      required
                      value={formData.name}
                      onChange={(e) => handleChange("name", e.target.value)}
                      placeholder="Enter program name"
                    />
                  </div>

                  <div>
                    <Label className="font-semibold">Organization</Label>
                    <Input
                      required
                      value={formData.organization}
                      onChange={(e) => handleChange("organization", e.target.value)}
                      placeholder="Organization or municipal entity running the program"
                    />
                  </div>

                {/* Primary Website & Additional Links */}
                <div className="space-y-3 p-4 bg-gray-50/80 rounded-2xl border border-gray-200/70">
                  <div>
                    <div className="flex items-center justify-between mb-1">
                      <Label className="font-semibold flex items-center gap-1.5 text-gray-900">
                        <Link2 className="w-4 h-4 text-green-700" />
                        Official Website / Primary Application Link
                      </Label>
                      <Button
                        type="button"
                        variant="outline"
                        size="sm"
                        onClick={handleAddLink}
                        className="h-7 text-xs border-green-600 text-green-700 hover:bg-green-50 font-semibold cursor-pointer"
                      >
                        <Plus className="w-3.5 h-3.5 mr-1" /> Add another link
                      </Button>
                    </div>
                    <Input
                      type="url"
                      required
                      value={formData.website}
                      onChange={(e) => handleChange("website", e.target.value)}
                      placeholder="https://..."
                      className="bg-white"
                    />
                  </div>

                  {additionalLinks.map((link, idx) => (
                    <div key={idx} className="flex items-center gap-2 animate-in fade-in duration-150">
                      <Input
                        type="url"
                        value={link}
                        onChange={(e) => handleUpdateLink(idx, e.target.value)}
                        placeholder={`https://... (Research paper, news article, or study #${idx + 1})`}
                        className="bg-white text-xs"
                      />
                      <Button
                        type="button"
                        variant="ghost"
                        size="icon"
                        onClick={() => handleRemoveLink(idx)}
                        className="h-9 w-9 text-gray-400 hover:text-red-600 hover:bg-red-50 flex-shrink-0 cursor-pointer"
                        title="Remove link"
                      >
                        <X className="w-4 h-4" />
                      </Button>
                    </div>
                  ))}

                  <p className="text-xs text-gray-500 leading-relaxed">
                    💡 <em>Encouraged:</em> Add links to research papers, whitepapers, press releases, evaluation studies, or news articles covering this program.
                  </p>
                </div>

                <div>
                  <Label className="font-semibold">Description</Label>
                  <Textarea
                    required
                    value={formData.description}
                    onChange={(e) => handleChange("description", e.target.value)}
                    placeholder="Detailed description of the program, objectives, and target population"
                    className="h-28"
                  />
                </div>

                <div>
                  <Label className="font-semibold">UBI Payout Terms, Amount and Description</Label>
                  <Input
                    required
                    value={formData.amount_description}
                    onChange={(e) => handleChange("amount_description", e.target.value)}
                    placeholder="e.g., $500 monthly for 12 months, or 10 G$ daily tokens"
                  />
                </div>

                {/* Currency Selector (with OTHER custom option) */}
                <div>
                  <Label className="font-semibold">Currency</Label>
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
                    <SelectTrigger className="bg-white">
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
                        placeholder="Enter currency code or symbol (e.g. SEK, NZD, G$, SOL, WLD)"
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

                {/* Monthly Equivalent Value in USD (Moved below Currency) */}
                <div>
                  <Label className="font-semibold">Monthly Equivalent Value in USD</Label>
                  <Input
                    type="number"
                    required
                    min="0"
                    step="any"
                    value={formData.monthly_amount_usd}
                    onChange={(e) => handleChange("monthly_amount_usd", e.target.value)}
                    placeholder="e.g. 500"
                  />
                  <p className="text-xs text-gray-500 mt-1">
                    Used to calculate the total estimated monthly cash floor in applicant portfolios.
                  </p>
                </div>

                {/* Payment Method (with OTHER option) */}
                <div>
                  <Label className="font-semibold">Payment Method</Label>
                  <Select
                    value={isOtherPaymentMethod ? "other" : formData.payment_method}
                    onValueChange={(value) => {
                      if (value === "other") {
                        setIsOtherPaymentMethod(true);
                      } else {
                        setIsOtherPaymentMethod(false);
                        handleChange("payment_method", value);
                        handleChange("custom_payment_method", "");
                      }
                    }}
                  >
                    <SelectTrigger className="bg-white">
                      <SelectValue placeholder="Select payment method" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="standard">Standard (Bank Transfer / Direct Deposit / Check)</SelectItem>
                      <SelectItem value="digital">Digital (Crypto / Web3 Wallet / Token Protocol)</SelectItem>
                      <SelectItem value="other">Other (please specify below)</SelectItem>
                    </SelectContent>
                  </Select>

                  {isOtherPaymentMethod && (
                    <div className="mt-2 animate-in fade-in duration-150">
                      <Input
                        type="text"
                        placeholder="Please specify payment method (e.g. Prepaid Debit Card, Mobile Money, Cash in hand)"
                        value={formData.custom_payment_method || ""}
                        onChange={(e) => handleChange("custom_payment_method", e.target.value)}
                        required
                        className="bg-gray-50/90 font-medium"
                      />
                    </div>
                  )}
                </div>

                {/* Program Status (with OTHER option) */}
                <div>
                  <Label className="font-semibold">Program Status</Label>
                  <Select
                    value={isOtherStatus ? "other" : formData.status}
                    onValueChange={(value) => {
                      if (value === "other") {
                        setIsOtherStatus(true);
                      } else {
                        setIsOtherStatus(false);
                        handleChange("status", value);
                        handleChange("custom_status", "");
                      }
                    }}
                  >
                    <SelectTrigger className="bg-white">
                      <SelectValue placeholder="Select status" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="active_open">Active, open for applications</SelectItem>
                      <SelectItem value="active_closed">Active, applications closed</SelectItem>
                      <SelectItem value="upcoming">Upcoming / Planned pilot</SelectItem>
                      <SelectItem value="closed">Closed / Completed</SelectItem>
                      <SelectItem value="other">Other (please specify below)</SelectItem>
                    </SelectContent>
                  </Select>

                  {isOtherStatus && (
                    <div className="mt-2 animate-in fade-in duration-150">
                      <Input
                        type="text"
                        placeholder="Please specify program status (e.g. In Review, Pilot Phase 2, Suspended)"
                        value={formData.custom_status || ""}
                        onChange={(e) => handleChange("custom_status", e.target.value)}
                        required
                        className="bg-gray-50/90 font-medium"
                      />
                    </div>
                  )}
                </div>
              </div>

              <Separator className="my-6" />
              
              <div>
                <h3 className="text-lg font-bold text-green-800 mb-4">Eligibility Requirements</h3>
                <div className="space-y-6">
                  <div>
                    <Label className="font-semibold">Is There a Maximum Household Income? (USD equivalent, optional)</Label>
                    <Input
                      type="number"
                      min="0"
                      value={formData.max_household_income_usd || ""}
                      onChange={(e) => handleChange("max_household_income_usd", e.target.value ? parseFloat(e.target.value) : null)}
                      placeholder="Leave empty if no income limit / unconditional"
                    />
                  </div>
                  
                  {/* Gender Requirement (Optional / Universal by default) */}
                  <div>
                    <Label className="font-semibold">Gender Requirement (optional)</Label>
                    <Select
                      value={formData.gender_requirement || "none"}
                      onValueChange={(value) => handleChange("gender_requirement", value === "none" ? "" : value)}
                    >
                      <SelectTrigger className="bg-white">
                        <SelectValue placeholder="No gender requirement (Universal)" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="none">No gender requirement (Universal / Open to all)</SelectItem>
                        <SelectItem value="female">Female only / Women-focused</SelectItem>
                        <SelectItem value="male">Male only</SelectItem>
                        <SelectItem value="other">other gender-related requirement (please describe below)</SelectItem>
                      </SelectContent>
                    </Select>
                    <p className="text-xs text-gray-500 mt-1">
                      You can leave this empty or select "No gender requirement" for universal programs.
                    </p>
                  </div>

                  {/* Age Limits (Optional) */}
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                      <Label className="font-semibold">Minimum Age (optional)</Label>
                      <Input
                        type="number"
                        min="0"
                        max="120"
                        value={formData.min_age || ""}
                        onChange={(e) => handleChange("min_age", e.target.value ? parseInt(e.target.value, 10) : null)}
                        placeholder="e.g. 18 (leave empty if none)"
                      />
                    </div>
                    <div>
                      <Label className="font-semibold">Maximum Age (optional)</Label>
                      <Input
                        type="number"
                        min="0"
                        max="120"
                        value={formData.max_age || ""}
                        onChange={(e) => handleChange("max_age", e.target.value ? parseInt(e.target.value, 10) : null)}
                        placeholder="e.g. 29 (leave empty if none)"
                      />
                    </div>
                  </div>

                  {/* Available Regions with Separate Global Checkmark */}
                  <div>
                    <Label className="font-semibold mb-2 block">Available Regions</Label>
                    
                    {/* Global Checkbox */}
                    <div className="flex items-start space-x-3 p-3.5 bg-green-50/80 rounded-xl border border-green-200 mb-3">
                      <input
                        type="checkbox"
                        id="isGlobalCheckbox"
                        checked={isGlobal}
                        onChange={(e) => handleToggleGlobal(e.target.checked)}
                        className="mt-1 h-4 w-4 rounded border-gray-300 text-green-600 focus:ring-green-500 cursor-pointer"
                      />
                      <label htmlFor="isGlobalCheckbox" className="text-sm font-medium text-green-950 cursor-pointer select-none">
                        <span className="font-bold flex items-center gap-1.5">
                          <Globe className="w-4 h-4 text-green-700" />
                          Globally Available / Worldwide (Open to all countries)
                        </span>
                        <span className="text-xs text-green-800 block mt-0.5 font-normal">
                          Check this box if anyone worldwide can participate regardless of country or residency.
                        </span>
                      </label>
                    </div>

                    {!isGlobal && (
                      <div className="space-y-2 animate-in fade-in duration-150">
                        <div className="flex gap-2">
                          <Select
                            value={selectedCountry}
                            onValueChange={handleSelectRegion}
                            disabled={isGlobal}
                          >
                            <SelectTrigger className="flex-1 bg-white">
                              <SelectValue placeholder="Select country to add..." />
                            </SelectTrigger>
                            <SelectContent>
                              {COUNTRIES.map(country => (
                                <SelectItem key={country} value={country}>
                                  {regions.includes(country) ? `✓ ${country}` : country}
                                </SelectItem>
                              ))}
                            </SelectContent>
                          </Select>
                          <Button 
                            type="button" 
                            onClick={addRegion} 
                            disabled={isGlobal || !selectedCountry}
                            className="cursor-pointer"
                          >
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
                    )}
                  </div>

                  {showStatesSelector && (
                    <div>
                      <Label className="font-semibold">Required States/Provinces</Label>
                      <div className="flex gap-2 mb-2">
                        <Select
                          value={selectedState}
                          onValueChange={handleSelectState}
                        >
                          <SelectTrigger className="flex-1 bg-white">
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
                    <Label className="font-semibold">Other Detailed Requirements</Label>
                    <Textarea
                      value={formData.eligibility}
                      onChange={(e) => handleChange("eligibility", e.target.value)}
                      placeholder="Additional eligibility criteria, age limits, residency rules, or enrollment requirements"
                      className="h-28"
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
                  className="cursor-pointer"
                >
                  Cancel
                </Button>
                <Button 
                  type="submit"
                  className="bg-green-700 hover:bg-green-800 cursor-pointer font-bold"
                  disabled={submitting}
                >
                  {submitting ? (
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
        )}

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
              <AlertDialogAction onClick={handleLogin}>
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
