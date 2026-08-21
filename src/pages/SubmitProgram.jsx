




import { supabase } from "@/lib/supabaseClient";
import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
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
  CardFooter,
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
import { createPageUrl } from "@/utils";
import { Separator } from "@/components/ui/separator";
import { ChevronLeft, Save, Plus, X, Leaf, AlertTriangle } from "lucide-react";

const COUNTRIES = [
  "United States",
  "Canada",
  "United Kingdom",
  "Germany",
  "France",
  "Spain",
  "Italy",
  "Australia",
  "Japan",
  "Brazil",
  "South Africa",
  "Kenya",
  "India"
];

export default function SubmitProgram() {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const [user, setUser] = useState(null);
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [loginAlertOpen, setLoginAlertOpen] = useState(false);
  const [submissionSuccess, setSubmissionSuccess] = useState(false);
  
  const [formData, setFormData] = useState({
    name: "",
    organization: "",
    description: "",
    gender_requirement: null,
    monthly_amount_usd: 0,
    available_regions: [],
    required_states: [],
    payment_method: "standard",
    accepts_foreign_currency: false,
    amount_description: "",
    max_household_income_usd: null,
    eligibility: "",
    status: "active",
    website: "",
    verified: false
  });
  
  const [selectedCountry, setSelectedCountry] = useState("");
  const [regions, setRegions] = useState([]);
  const [newRegion, setNewRegion] = useState("");
  
  useEffect(() => {
    checkAuth();
    loadNextProgramId();
  }, []);
  
  const checkAuth = async () => {
    try {
      const userData = (await supabase.auth.getUser()).data.user;
      setUser(userData);
      setIsAuthenticated(true);
    } catch (error) {
      setUser(null);
      setIsAuthenticated(false);
    }
  };
  
  const loadNextProgramId = async () => {
    try {
      const programs = (await supabase.from('programs').select('*')).data;
      // Find the maximum program_id and add 1
      const maxId = programs.length > 0 
        ? Math.max(...programs.map(p => p.program_id))
        : 0;
      setFormData(prev => ({
        ...prev,
        program_id: maxId + 1
      }));
    } catch (error) {
      console.error("Error loading programs:", error);
    }
  };

  const handleChange = (field, value) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
  };
  
  const addRegion = () => {
    if (selectedCountry && !regions.includes(selectedCountry)) {
      setRegions([...regions, selectedCountry]);
      setFormData(prev => ({
        ...prev,
        available_regions: [...prev.available_regions, selectedCountry]
      }));
      setSelectedCountry("");
    }
  };
  
  const addCustomRegion = () => {
    if (newRegion && !regions.includes(newRegion)) {
      setRegions([...regions, newRegion]);
      setFormData(prev => ({
        ...prev,
        available_regions: [...prev.available_regions, newRegion]
      }));
      setNewRegion("");
    }
  };
  
  const removeRegion = (region) => {
    setRegions(regions.filter(r => r !== region));
    setFormData(prev => ({
      ...prev,
      available_regions: prev.available_regions.filter(r => r !== region)
    }));
  };
  
  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (!isAuthenticated) {
      setLoginAlertOpen(true);
      return;
    }
    
    setLoading(true);
    
    try {
      // Include the submitter's email
      (await supabase.from('programs').insert([{
        ...formData,
        submitter_email: user.email,
        status: 'pending_approval'
      }]).select().single()).data;
      
      setSubmissionSuccess(true);
      setTimeout(() => {
        navigate(createPageUrl("Programs"));
      }, 2000);
    } catch (error) {
      console.error("Error submitting program:", error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-12">
      <div className="max-w-3xl mx-auto">
        <div className="flex justify-between items-center mb-6">
          <Button 
            variant="ghost" 
            className="text-green-700"
            onClick={() => navigate(createPageUrl("Programs"))}
          >
            <ChevronLeft className="w-5 h-5 mr-1" />
            Back to Programs
          </Button>
        </div>
        
        <div className="text-center mb-8">
          <div className="inline-block p-2 bg-green-100 rounded-full mb-4">
            <Leaf className="w-8 h-8 text-green-700" />
          </div>
          <h1 className="text-2xl font-bold text-green-900">Submit a UBI Program</h1>
          <p className="text-green-700 mt-2">
            Help us grow our database by adding a program that's not listed
          </p>
        </div>
        
        <Card className="shadow-lg mb-8">
          <CardHeader>
            <CardTitle>Program Details</CardTitle>
            <CardDescription>
              Please provide as much information as possible about the UBI program
            </CardDescription>
          </CardHeader>
          
          <form onSubmit={handleSubmit}>
            <CardContent className="space-y-6">
              <div className="space-y-4">
                <div>
                  <Label htmlFor="name">Program Name *</Label>
                  <Input
                    id="name"
                    required
                    value={formData.name}
                    onChange={(e) => handleChange("name", e.target.value)}
                  />
                </div>
                
                <div>
                  <Label htmlFor="organization">Organization Name *</Label>
                  <Input
                    id="organization"
                    required
                    value={formData.organization}
                    onChange={(e) => handleChange("organization", e.target.value)}
                  />
                </div>
                
                <div>
                  <Label htmlFor="website">Program Website *</Label>
                  <Input
                    id="website"
                    type="url"
                    required
                    value={formData.website}
                    onChange={(e) => handleChange("website", e.target.value)}
                    placeholder="https://"
                  />
                </div>
                
                <div>
                  <Label htmlFor="description">Program Description *</Label>
                  <Textarea
                    id="description"
                    required
                    value={formData.description}
                    onChange={(e) => handleChange("description", e.target.value)}
                    className="min-h-[100px]"
                  />
                </div>
                
                <Separator />
                
                <div>
                  <Label htmlFor="status">Program Status *</Label>
                  <Select
                    value={formData.status}
                    onValueChange={(value) => handleChange("status", value)}
                    required
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Select status" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="active">Active (Currently accepting applications)</SelectItem>
                      <SelectItem value="upcoming">Upcoming (Not yet launched)</SelectItem>
                      <SelectItem value="closed">Closed (No longer accepting applications)</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <Label htmlFor="monthly_amount">Monthly Amount (USD) *</Label>
                    <Input
                      id="monthly_amount"
                      type="number"
                      min="0"
                      step="0.01"
                      required
                      value={formData.monthly_amount_usd}
                      onChange={(e) => handleChange("monthly_amount_usd", parseFloat(e.target.value))}
                    />
                  </div>
                  
                  <div>
                    <Label htmlFor="max_income">Maximum Income Requirement (USD)</Label>
                    <Input
                      id="max_income"
                      type="number"
                      min="0"
                      placeholder="Optional"
                      value={formData.max_household_income_usd || ''}
                      onChange={(e) => handleChange("max_household_income_usd", 
                        e.target.value ? parseFloat(e.target.value) : null
                      )}
                    />
                  </div>
                </div>
                
                <div>
                  <Label htmlFor="amount_description">Payment Description *</Label>
                  <Input
                    id="amount_description"
                    required
                    placeholder="e.g., $500 paid monthly for 12 months"
                    value={formData.amount_description}
                    onChange={(e) => handleChange("amount_description", e.target.value)}
                  />
                </div>
                
                <div>
                  <Label htmlFor="payment_method">Payment Method *</Label>
                  <Select
                    value={formData.payment_method}
                    onValueChange={(value) => handleChange("payment_method", value)}
                    required
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Select payment method" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="standard">Standard (Bank transfer, check)</SelectItem>
                      <SelectItem value="digital">Digital (Cryptocurrency)</SelectItem>
                      <SelectItem value="both">Both Options Available</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                
                <div className="flex items-center justify-between">
                  <div className="space-y-0.5">
                    <Label>Accepts Foreign Currency</Label>
                    <p className="text-sm text-gray-500">
                      Can make payments in currencies other than local currency
                    </p>
                  </div>
                  <Switch
                    checked={formData.accepts_foreign_currency}
                    onCheckedChange={(value) => handleChange("accepts_foreign_currency", value)}
                  />
                </div>
                
                <Separator />
                
                <div>
                  <Label>Geographic Eligibility *</Label>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-2">
                    <div>
                      <Select
                        value={selectedCountry}
                        onValueChange={setSelectedCountry}
                      >
                        <SelectTrigger>
                          <SelectValue placeholder="Select a country" />
                        </SelectTrigger>
                        <SelectContent>
                          {COUNTRIES.map(country => (
                            <SelectItem key={country} value={country}>
                              {country}
                            </SelectItem>
                          ))}
                        </SelectContent>
                      </Select>
                    </div>
                    
                    <Button 
                      type="button" 
                      variant="outline"
                      onClick={addRegion}
                      disabled={!selectedCountry}
                    >
                      <Plus className="w-4 h-4 mr-2" />
                      Add Country
                    </Button>
                  </div>
                  
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
                    <Input
                      placeholder="Or type a custom region..."
                      value={newRegion}
                      onChange={(e) => setNewRegion(e.target.value)}
                    />
                    
                    <Button 
                      type="button" 
                      variant="outline"
                      onClick={addCustomRegion}
                      disabled={!newRegion}
                    >
                      <Plus className="w-4 h-4 mr-2" />
                      Add Custom Region
                    </Button>
                  </div>
                  
                  {regions.length > 0 ? (
                    <div className="flex flex-wrap gap-2 mt-4">
                      {regions.map(region => (
                        <div 
                          key={region} 
                          className="bg-green-100 text-green-800 px-3 py-1 rounded-full flex items-center gap-2"
                        >
                          {region}
                          <button
                            type="button"
                            onClick={() => removeRegion(region)}
                            className="hover:bg-green-200 rounded-full p-1"
                          >
                            <X className="h-3 w-3" />
                          </button>
                        </div>
                      ))}
                    </div>
                  ) : (
                    <p className="text-sm text-amber-600 mt-2 flex items-center">
                      <AlertTriangle className="w-4 h-4 mr-1" />
                      Please add at least one region where this program is available
                    </p>
                  )}
                  
                  <p className="text-sm text-gray-500 mt-2">
                    For worldwide programs, add "Worldwide" as a custom region.
                  </p>
                </div>
                
                <div>
                  <Label htmlFor="gender_requirement">Gender Requirement</Label>
                  <Select
                    value={formData.gender_requirement || ""}
                    onValueChange={(value) => handleChange("gender_requirement", value || null)}
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Select gender requirement" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value={null}>No specific requirement</SelectItem>
                      <SelectItem value="female">Female only</SelectItem>
                      <SelectItem value="male">Male only</SelectItem>
                      <SelectItem value="other">other gender-related requirement (please describe below)</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                
                <div>
                  <Label htmlFor="eligibility">Eligibility Requirements</Label>
                  <Textarea
                    id="eligibility"
                    value={formData.eligibility}
                    onChange={(e) => handleChange("eligibility", e.target.value)}
                    placeholder="e.g., Must be over 18, resident of the region, income below threshold..."
                    className="min-h-[100px]"
                  />
                </div>
              </div>
            </CardContent>
            
            <CardFooter className="flex justify-between">
              <Button 
                type="button" 
                variant="outline"
                onClick={() => navigate(createPageUrl("Programs"))}
              >
                Cancel
              </Button>
              <Button 
                type="submit"
                className="bg-green-700 hover:bg-green-800"
                disabled={loading || regions.length === 0}
              >
                {loading ? (
                  <>
                    <div className="animate-spin mr-2 h-4 w-4 border-2 border-b-0 border-r-0 border-white rounded-full"></div>
                    Submitting...
                  </>
                ) : (
                  <>
                    <Save className="w-4 h-4 mr-2" />
                    Submit Program
                  </>
                )}
              </Button>
            </CardFooter>
          </form>
        </Card>
        
        {/* Success Alert */}
        <AlertDialog open={submissionSuccess}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>Program Submitted</AlertDialogTitle>
              <AlertDialogDescription>
                Thank you for adding this program! Our team will review the submission before it appears in the main program listings.
              </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogAction>OK</AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
        
        {/* Login Alert */}
        <AlertDialog open={loginAlertOpen} onOpenChange={setLoginAlertOpen}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>Login Required</AlertDialogTitle>
              <AlertDialogDescription>
                You need to be logged in to submit a program. Would you like to log in now?
              </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogCancel>Cancel</AlertDialogCancel>
              <AlertDialogAction onClick={() => User.login()}>Log In</AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </div>
  );
}

