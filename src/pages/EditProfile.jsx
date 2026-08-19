





import { supabase } from "@/lib/supabaseClient";
import React, { useState, useEffect } from "react";
import BankAccountForm from "../components/banking/BankAccountForm";
import CryptoWalletForm from "../components/banking/CryptoWalletForm";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Switch } from "@/components/ui/switch";
import { UploadFile } from "@/integrations/Core";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Avatar, AvatarImage, AvatarFallback } from "@/components/ui/avatar";
import { useToast } from "@/components/ui/use-toast";
import { Separator } from "@/components/ui/separator";
import { ChevronLeft, Save, Leaf, Loader2, UploadCloud, Trash2, Plus, CreditCard, Wallet } from "lucide-react";
import { useNavigate } from "react-router-dom";
import { createPageUrl } from "@/utils";
import { Badge } from "@/components/ui/badge";


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
  "Japan",
  "South Korea",
  "Sweden",
  "Ireland",
];

const US_STATES = [
  "Alabama",
  "Alaska",
  "Arizona",
  "Arkansas",
  "California",
  "Colorado",
  "Connecticut",
  "Delaware",
  "Florida",
  "Georgia",
  "Hawaii",
  "Idaho",
  "Illinois",
  "Indiana",
  "Iowa",
  "Kansas",
  "Kentucky",
  "Louisiana",
  "Maine",
  "Maryland",
  "Massachusetts",
  "Michigan",
  "Minnesota",
  "Mississippi",
  "Missouri",
  "Montana",
  "Nebraska",
  "Nevada",
  "New Hampshire",
  "New Jersey",
  "New Mexico",
  "New York",
  "North Carolina",
  "North Dakota",
  "Ohio",
  "Oklahoma",
  "Oregon",
  "Pennsylvania",
  "Rhode Island",
  "South Carolina",
  "South Dakota",
  "Tennessee",
  "Texas",
  "Utah",
  "Vermont",
  "Virginia",
  "Washington",
  "West Virginia",
  "Wisconsin",
  "Wyoming",
  "District of Columbia"
];

const CANADIAN_PROVINCES = [
  "Alberta",
  "British Columbia",
  "Manitoba",
  "New Brunswick",
  "Newfoundland and Labrador",
  "Northwest Territories",
  "Nova Scotia",
  "Nunavut",
  "Ontario",
  "Prince Edward Island",
  "Quebec",
  "Saskatchewan",
  "Yukon"
];

// Default avatar image to use when user has no profile picture
const DEFAULT_AVATAR = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScfYIGxbXeB6QQNQ6juhTxDVvfc1850IBMtQ&s";

// Generic avatars options - updated to illustrated avatars with better proportions
const GENERIC_AVATARS = [
  DEFAULT_AVATAR,
  "https://api.dicebear.com/7.x/personas/svg?seed=John&backgroundColor=b6e3f4",
  "https://api.dicebear.com/7.x/personas/svg?seed=Jane&backgroundColor=c0aede",
  "https://api.dicebear.com/7.x/personas/svg?seed=Alex&backgroundColor=d1d4f9",
  "https://api.dicebear.com/7.x/personas/svg?seed=Sam&backgroundColor=ffdfbf",
  "https://api.dicebear.com/7.x/personas/svg?seed=Morgan&backgroundColor=ffd5dc",
  "https://api.dicebear.com/7.x/personas/svg?seed=Taylor&backgroundColor=c1e1c5"
];

const BLOCKCHAINS = [
  { label: "Bitcoin", value: "bitcoin" },
  { label: "Ethereum", value: "ethereum" },
  { label: "Binance Smart Chain", value: "binance-smart-chain" },
  { label: "Polygon", value: "polygon" },
  { label: "Solana", value: "solana" },
  { label: "Avalanche", value: "avalanche" },
  { label: "Cardano", value: "cardano" },
  { label: "Ripple (XRP)", value: "ripple" },
  { label: "Litecoin", value: "litecoin" },
  { label: "Dogecoin", value: "dogecoin" },
];

// Country to currency mapping
const COUNTRY_CURRENCY = {
  "United States": "USD",
  "Canada": "CAD",
  "United Kingdom": "GBP",
  "Australia": "AUD",
  "New Zealand": "NZD",
  "Germany": "EUR",
  "France": "EUR",
  "Spain": "EUR",
  "Italy": "EUR",
  "Japan": "JPY",
  "South Korea": "KRW",
  "Sweden": "SEK",
  "Ireland": "EUR"
};

// Default to USD if country not found
const getCurrencyForCountry = (country) => {
  return COUNTRY_CURRENCY[country] || "USD";
};

export default function EditProfile() {
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [user, setUser] = useState(null);
  const [profileId, setProfileId] = useState(null);
  const { toast } = useToast();
  const [formData, setFormData] = useState({
    name: "",
    gender: "",
    country: "",
    state: "",
    accepts_digital_currency: false,
    accepts_foreign_currency: false,
    household_size: 1,
    income_range: "",
    profile_picture: "",
    min_monthly_payment: 0,
    currency: "USD",
    is_public: false
  });
  
  // Add state for bank accounts and crypto wallets
  const [bankAccounts, setBankAccounts] = useState([]);
  const [cryptoWallets, setCryptoWallets] = useState([]);
  const [bankFormOpen, setBankFormOpen] = useState(false);
  const [cryptoFormOpen, setCryptoFormOpen] = useState(false);
  const [savingAccount, setSavingAccount] = useState(false);
  const [savingWallet, setSavingWallet] = useState(false);
  
  const navigate = useNavigate();

  // Add missing variables for state/province options
  const needsState = formData.country === "United States" || formData.country === "Canada";
  const stateOptions = formData.country === "United States" ? US_STATES : 
                      formData.country === "Canada" ? CANADIAN_PROVINCES : [];

  useEffect(() => {
    loadUserData();
  }, []);

  const loadUserData = async () => {
    try {
      const userData = (await supabase.auth.getUser()).data.user;
      setUser(userData);

      const profiles = (await supabase.from('user_profiles').select('*').match({ created_by: userData.email })).data;
      if (profiles.length > 0) {
        const profile = profiles[0];
        setProfileId(profile.id);
        setFormData({
          name: profile.name || "",
          gender: profile.gender || "",
          country: profile.country || "",
          state: profile.state || "",
          accepts_digital_currency: profile.accepts_digital_currency || false,
          accepts_foreign_currency: profile.accepts_foreign_currency || false,
          is_public: profile.is_public || false,
          household_size: profile.household_size || 1,
          income_range: profile.income_range || "",
          profile_picture: profile.profile_picture || DEFAULT_AVATAR,
          min_monthly_payment: profile.min_monthly_payment || 0,
          currency: profile.currency || getCurrencyForCountry(profile.country) || "USD"
        });
        
        // Load bank accounts and crypto wallets
        const accounts = (await supabase.from('bank_accounts').select('*').match({ user_profile_id: profile.id })).data;
        const wallets = (await supabase.from('crypto_wallets').select('*').match({ user_profile_id: profile.id })).data;
        setBankAccounts(accounts);
        setCryptoWallets(wallets);
      } else {
        // Initialize with default avatar if no profile exists
        setFormData(prev => ({
          ...prev,
          profile_picture: DEFAULT_AVATAR,
          currency: getCurrencyForCountry(prev.country) || "USD"
        }));
      }

      setLoading(false);
    } catch (error) {
      console.error("Error loading user data:", error);
      navigate(createPageUrl("Home"));
    }
  };

  const handleChange = (field, value) => {
    console.log(`Changing field ${field} to:`, value); // Debug log
    setFormData(prev => {
      const newData = {
        ...prev,
        [field]: value
      };
      
      // Automatically set currency when country changes
      if (field === "country" && value) {
        newData.currency = getCurrencyForCountry(value);
      }
      
      return newData;
    });
  };

  const handleSavePicture = async () => {
    try {
      if (!profileId) return;
      
      (await supabase.from('user_profiles').update({
        profile_picture: formData.profile_picture
      }).eq('id', profileId).select().single()).data;
      
      toast({
        title: "Profile picture updated",
        description: "Your profile picture has been successfully updated.",
        variant: "success",
      });
    } catch (error) {
      console.error("Error saving profile picture:", error);
      toast({
        title: "Update failed",
        description: "There was a problem updating your profile picture.",
        variant: "destructive",
      });
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setSaving(true);
    
    try {
      // Remove profile_picture from the save operation
      const dataToSave = {
        name: formData.name,
        gender: formData.gender,
        country: formData.country,
        state: formData.state,
        accepts_digital_currency: formData.accepts_digital_currency,
        accepts_foreign_currency: formData.accepts_foreign_currency,
        household_size: formData.household_size,
        income_range: formData.income_range,
        min_monthly_payment: formData.min_monthly_payment,
        currency: formData.currency,
        is_public: formData.is_public
      };
      
      if (profileId) {
        (await supabase.from('user_profiles').update(dataToSave).eq('id', profileId).select().single()).data;
      } else {
        (await supabase.from('user_profiles').insert([dataToSave]).select().single()).data;
      }
      
      toast({
        title: "Profile updated",
        description: "Your profile has been successfully updated.",
        variant: "success",
      });
      
      navigate(createPageUrl("Profile"));
    } catch (error) {
      console.error("Error saving profile:", error);
      toast({
        title: "Update failed",
        description: "There was a problem updating your profile.",
        variant: "destructive",
      });
    } finally {
      setSaving(false);
    }
  };

  // Add state for edit modals
  const [editingAccount, setEditingAccount] = useState(null);
  const [editingWallet, setEditingWallet] = useState(null);
  const [editModalOpen, setEditModalOpen] = useState(false);
  const [walletEditModalOpen, setWalletEditModalOpen] = useState(false);

  // Add missing file upload handler
  const handleFileUpload = async (e) => {
    const file = e.target.files[0];
    if (!file) return;

    try {
      setUploading(true);
      const { file_url } = await UploadFile({ file });
      handleChange("profile_picture", file_url);
      
      toast({
        title: "Image uploaded",
        description: "Your profile picture has been uploaded.",
        variant: "success",
      });
    } catch (error) {
      console.error("Error uploading file:", error);
      toast({
        title: "Upload failed",
        description: "There was a problem uploading your image.",
        variant: "destructive",
      });
    } finally {
      setUploading(false);
    }
  };

  // Add missing bank account handler
  const handleAddBankAccount = async (accountData) => {
    try {
      setSavingAccount(true);
      (await supabase.from('bank_accounts').insert([{
        ...accountData,
        user_profile_id: profileId
      }]).select().single()).data;
      
      // Refresh bank accounts list
      const accounts = (await supabase.from('bank_accounts').select('*').match({ user_profile_id: profileId })).data;
      setBankAccounts(accounts);
      
      setBankFormOpen(false);
      toast({
        title: "Account added",
        description: "Your bank account has been successfully added.",
        variant: "success",
      });
    } catch (error) {
      console.error("Error adding bank account:", error);
      toast({
        title: "Failed to add account",
        description: "There was a problem adding your bank account.",
        variant: "destructive",
      });
    } finally {
      setSavingAccount(false);
    }
  };

  // Add missing crypto wallet handler
  const handleAddCryptoWallet = async (walletData) => {
    try {
      setSavingWallet(true);
      (await supabase.from('crypto_wallets').insert([{
        ...walletData,
        user_profile_id: profileId
      }]).select().single()).data;
      
      // Refresh crypto wallets list
      const wallets = (await supabase.from('crypto_wallets').select('*').match({ user_profile_id: profileId })).data;
      setCryptoWallets(wallets);
      
      setCryptoFormOpen(false);
      toast({
        title: "Wallet added",
        description: "Your crypto wallet has been successfully added.",
        variant: "success",
      });
    } catch (error) {
      console.error("Error adding crypto wallet:", error);
      toast({
        title: "Failed to add wallet",
        description: "There was a problem adding your crypto wallet.",
        variant: "destructive",
      });
    } finally {
      setSavingWallet(false);
    }
  };

  // Add handlers for account/wallet updates
  const handleAccountUpdate = async (updatedData) => {
    try {
      (await supabase.from('bank_accounts').update(updatedData).eq('id', editingAccount.id).select().single()).data;
      const updatedAccounts = bankAccounts.map(acc => 
        acc.id === editingAccount.id ? { ...acc, ...updatedData } : acc
      );
      setBankAccounts(updatedAccounts);
      setEditModalOpen(false);
      setEditingAccount(null);
      
      toast({
        title: "Account updated",
        description: "Your bank account has been successfully updated.",
        variant: "success",
      });
    } catch (error) {
      console.error("Error updating bank account:", error);
      toast({
        title: "Update failed",
        description: "There was a problem updating your bank account.",
        variant: "destructive",
      });
    }
  };

  const handleWalletUpdate = async (updatedData) => {
    try {
      (await supabase.from('crypto_wallets').update(updatedData).eq('id', editingWallet.id).select().single()).data;
      const updatedWallets = cryptoWallets.map(wallet => 
        wallet.id === editingWallet.id ? { ...wallet, ...updatedData } : wallet
      );
      setCryptoWallets(updatedWallets);
      setWalletEditModalOpen(false);
      setEditingWallet(null);
      
      toast({
        title: "Wallet updated",
        description: "Your crypto wallet has been successfully updated.",
        variant: "success",
      });
    } catch (error) {
      console.error("Error updating crypto wallet:", error);
      toast({
        title: "Update failed",
        description: "There was a problem updating your crypto wallet.",
        variant: "destructive",
      });
    }
  };
  
  const handleDeleteBankAccount = async (accountId) => {
    try {
      (await supabase.from('bank_accounts').delete().eq('id', accountId));
      setBankAccounts(prev => prev.filter(account => account.id !== accountId));
      
      toast({
        title: "Account removed",
        description: "Your bank account has been successfully removed.",
        variant: "success",
      });
    } catch (error) {
      console.error("Error removing bank account:", error);
      toast({
        title: "Failed to remove account",
        description: "There was a problem removing your bank account.",
        variant: "destructive",
      });
    }
  };
  
  const handleDeleteCryptoWallet = async (walletId) => {
    try {
      (await supabase.from('crypto_wallets').delete().eq('id', walletId));
      setCryptoWallets(prev => prev.filter(wallet => wallet.id !== walletId));
      
      toast({
        title: "Wallet removed",
        description: "Your crypto wallet has been successfully removed.",
        variant: "success",
      });
    } catch (error) {
      console.error("Error removing crypto wallet:", error);
      toast({
        title: "Failed to remove wallet",
        description: "There was a problem removing your crypto wallet.",
        variant: "destructive",
      });
    }
  };
  
  const handleSetPrimaryBankAccount = async (accountId) => {
    try {
      // Update all accounts to not be primary
      await Promise.all(
        bankAccounts
          .filter(account => account.is_primary)
          .map(account => BankAccount.update(account.id, { is_primary: false }))
      );
      
      // Set the selected account as primary
      (await supabase.from('bank_accounts').update({ is_primary: true }).eq('id', accountId).select().single()).data;
      
      // Update the local state
      setBankAccounts(prev => 
        prev.map(account => ({
          ...account,
          is_primary: account.id === accountId
        }))
      );
      
      toast({
        title: "Primary account updated",
        description: "Your primary bank account has been updated.",
        variant: "success",
      });
    } catch (error) {
      console.error("Error updating primary bank account:", error);
      toast({
        title: "Failed to update",
        description: "There was a problem updating your primary bank account.",
        variant: "destructive",
      });
    }
  };
  
  const handleSetPrimaryCryptoWallet = async (walletId) => {
    try {
      // Update all wallets to not be primary
      await Promise.all(
        cryptoWallets
          .filter(wallet => wallet.is_primary)
          .map(wallet => CryptoWallet.update(wallet.id, { is_primary: false }))
      );
      
      // Set the selected wallet as primary
      (await supabase.from('crypto_wallets').update({ is_primary: true }).eq('id', walletId).select().single()).data;
      
      // Update the local state
      setCryptoWallets(prev => 
        prev.map(wallet => ({
          ...wallet,
          is_primary: wallet.id === walletId
        }))
      );
      
      toast({
        title: "Primary wallet updated",
        description: "Your primary crypto wallet has been updated.",
        variant: "success",
      });
    } catch (error) {
      console.error("Error updating primary crypto wallet:", error);
      toast({
        title: "Failed to update",
        description: "There was a problem updating your primary crypto wallet.",
        variant: "destructive",
      });
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-700"></div>
      </div>
    );
  }

  return (
    <>
      <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-8">
        {/* Header */}
        <div className="flex justify-between items-center mb-6">
          <Button 
            variant="ghost" 
            className="text-green-700"
            onClick={() => navigate(createPageUrl("Profile"))}
          >
            <ChevronLeft className="w-5 h-5 mr-1" />
            Back to Profile
          </Button>
        </div>
        
        <div className="text-center mb-8">
          <div className="inline-block p-2 bg-green-100 rounded-full mb-4">
            <Leaf className="w-8 h-8 text-green-700" />
          </div>
          <h1 className="text-2xl font-bold text-green-900">Edit Profile</h1>
          <p className="text-green-700 mt-2">Update your information and preferences</p>
        </div>
        
        <Separator className="my-6" />
        
        {/* Profile Picture Card */}
        <Card className="shadow-lg mb-8">
          <CardHeader>
            <CardTitle>Profile Picture</CardTitle>
            <CardDescription>Choose a profile picture or upload your own</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="flex flex-col items-center mb-6">
              <Avatar className="h-24 w-24 mb-4 border-4 border-white shadow-lg">
                <AvatarImage src={formData.profile_picture || DEFAULT_AVATAR} alt="Profile picture" />
                <AvatarFallback className="bg-green-100 text-green-700 text-2xl">
                  {user?.full_name?.split(" ").map(n => n[0]).join("").toUpperCase()}
                </AvatarFallback>
              </Avatar>
              <h3 className="text-lg font-medium">{user.full_name}</h3>
            </div>
            
            <div className="space-y-6">
              <div>
                <h4 className="text-sm font-medium mb-3">Choose a generic avatar</h4>
                <RadioGroup 
                  value={formData.profile_picture}
                  onValueChange={(value) => {
                    console.log("Selected new avatar:", value); // Debug log
                    handleChange("profile_picture", value);
                  }}
                  className="flex flex-wrap gap-4"
                >
                  {GENERIC_AVATARS.map((avatar, index) => (
                    <div key={index} className="flex items-center space-x-2">
                      <RadioGroupItem
                        value={avatar}
                        id={`avatar-${index}`}
                        className="sr-only"
                      />
                      <label
                        htmlFor={`avatar-${index}`}
                        className={`cursor-pointer rounded-full border-2 p-1 transition-all ${
                          formData.profile_picture === avatar 
                            ? "border-green-600 shadow-md" 
                            : "border-transparent hover:border-green-200"
                        }`}
                      >
                        <Avatar className="h-16 w-16">
                          <AvatarImage src={avatar} />
                        </Avatar>
                      </label>
                    </div>
                  ))}
                </RadioGroup>
              </div>
              
              <Separator />
              
              <div>
                <h4 className="text-sm font-medium mb-3">Or upload your own</h4>
                <div className="flex items-center gap-4">
                  <label
                    htmlFor="picture-upload"
                    className={`flex flex-col items-center justify-center w-full h-32 border-2 border-dashed rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100 ${
                      uploading ? "opacity-50" : ""
                    }`}
                  >
                    <div className="flex flex-col items-center justify-center pt-5 pb-6">
                      {uploading ? (
                        <Loader2 className="w-8 h-8 text-green-600 animate-spin" />
                      ) : (
                        <>
                          <UploadCloud className="w-8 h-8 text-green-600 mb-2" />
                          <p className="mb-2 text-sm text-gray-500">
                            <span className="font-semibold">Click to upload</span> or drag and drop
                          </p>
                          <p className="text-xs text-gray-500">PNG, JPG (MAX. 5MB)</p>
                        </>
                      )}
                    </div>
                    <input 
                      id="picture-upload" 
                      type="file" 
                      accept="image/png, image/jpeg" 
                      className="hidden"
                      onChange={handleFileUpload}
                      disabled={uploading}
                    />
                  </label>
                </div>
              </div>
              
              {/* Add Save Picture button */}
              <div className="flex justify-end mt-4">
                <Button 
                  onClick={handleSavePicture}
                  className="bg-green-700 hover:bg-green-800"
                >
                  <Save className="w-4 h-4 mr-2" />
                  Save Picture
                </Button>
              </div>
            </div>
          </CardContent>
        </Card>
        
        {/* Edit Form */}
        <Card className="shadow-lg mb-8">
          <CardHeader>
            <CardTitle>My Profile</CardTitle>
            <CardDescription>Update your personal information and preferences</CardDescription>
          </CardHeader>
          <CardContent className="p-6">
            <form onSubmit={handleSubmit} className="space-y-6">
              <div>
                <Label htmlFor="name">Full Name</Label>
                <Input
                  id="name"
                  value={formData.name}
                  onChange={(e) => handleChange("name", e.target.value)}
                  required
                />
              </div>
              
              <div>
                <Label htmlFor="country">Country</Label>
                <Select
                  value={formData.country}
                  onValueChange={(value) => handleChange("country", value)}
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Select country" />
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

              {needsState && (
                <div>
                  <Label htmlFor="state">State/Province</Label>
                  <Select
                    value={formData.state}
                    onValueChange={(value) => handleChange("state", value)}
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Select state/province" />
                    </SelectTrigger>
                    <SelectContent>
                      {stateOptions.map(state => (
                        <SelectItem key={state} value={state}>
                          {state}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
              )}
              

              <div>
                <Label htmlFor="gender">Gender</Label>
                <Select
                  value={formData.gender}
                  onValueChange={(value) => handleChange("gender", value)}
                  required
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Select gender" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="female">Female</SelectItem>
                    <SelectItem value="male">Male</SelectItem>
                    <SelectItem value="abstain">Abstain from gender-specific programs</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div>
                <Label htmlFor="currency">Currency</Label>
                <Select
                  value={formData.currency}
                  onValueChange={(value) => handleChange("currency", value)}
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
                  </SelectContent>
                </Select>
                <p className="text-sm text-gray-500 mt-1">
                  Automatically set based on your country, but can be changed
                </p>
              </div>
              


              <div>
                <Label htmlFor="household">Household Size</Label>
                <Select
                  value={formData.household_size.toString()}
                  onValueChange={(value) => handleChange("household_size", parseInt(value))}
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Select household size" />
                  </SelectTrigger>
                  <SelectContent>
                    {[1, 2, 3, 4, 5, 6, 7, 8].map(size => (
                      <SelectItem key={size} value={size.toString()}>
                        {size} {size === 1 ? 'person' : 'people'}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div>
                <Label htmlFor="income">Annual Household Income</Label>
                <Select
                  value={formData.income_range}
                  onValueChange={(value) => handleChange("income_range", value)}
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Select income range" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="0-20k">$0 - $20,000</SelectItem>
                    <SelectItem value="20k-40k">$20,001 - $40,000</SelectItem>
                    <SelectItem value="40k-60k">$40,001 - $60,000</SelectItem>
                    <SelectItem value="60k+">$60,001+</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-4">
                <Label>Privacy Settings</Label>
                <div className="flex items-center justify-between">
                  <div className="space-y-0.5">
                    <p className="text-sm font-medium">Public Profile</p>
                    <p className="text-sm text-gray-500">
                      Allow other users to view your profile and connect with you
                    </p>
                  </div>
                  <Switch
                    checked={formData.is_public}
                    onCheckedChange={(checked) => handleChange("is_public", checked)}
                  />
                </div>
              </div>

              <Separator />

              <div className="space-y-4">
                <Label>Payment Preferences</Label>
                
                <div className="flex items-center justify-between">
                  <div className="space-y-0.5">
                    <p className="text-sm font-medium">Accept Foreign Currency</p>
                    <p className="text-sm text-gray-500">
                      Willing to receive payments in foreign currencies
                    </p>
                  </div>
                  <Switch
                    checked={formData.accepts_foreign_currency}
                    onCheckedChange={(checked) => handleChange("accepts_foreign_currency", checked)}
                  />
                </div>
                
                <div className="flex items-center justify-between">
                  <div className="space-y-0.5">
                    <p className="text-sm font-medium">Accept Digital Currency</p>
                    <p className="text-sm text-gray-500">
                      Willing to receive digital payments
                    </p>
                  </div>
                  <Switch
                    checked={formData.accepts_digital_currency}
                    onCheckedChange={(checked) => handleChange("accepts_digital_currency", checked)}
                  />
                </div>
                
              </div>

              <Button 
                type="submit"
                className="w-full bg-green-700 hover:bg-green-800"
                disabled={saving}
              >
                {saving ? (
                  <>
                    <div className="animate-spin mr-2 h-4 w-4 border-2 border-b-0 border-r-0 border-white rounded-full"></div>
                    Saving...
                  </>
                ) : (
                  <>
                    <Save className="w-4 h-4 mr-2" />
                    Save Profile
                  </>
                )}
              </Button>
            </form>
          </CardContent>
        </Card>
        
        {/* Bank Accounts Section */}
        <Card className="shadow-lg mb-8">
          <CardHeader>
            <CardTitle className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <CreditCard className="h-5 w-5 text-green-700" />
                My Bank Accounts
              </div>
              <Button 
                onClick={() => setBankFormOpen(true)}
                variant="outline" 
                size="sm"
                className="border-green-600 text-green-700 hover:bg-green-50"
              >
                <Plus className="h-4 w-4 mr-2" />
                Add Account
              </Button>
            </CardTitle>
            <CardDescription>Manage your bank accounts for receiving UBI payments</CardDescription>
          </CardHeader>
          <CardContent>
            {bankAccounts.length === 0 ? (
              <div className="text-center py-8">
                <p className="text-gray-500 mb-4">No bank accounts added yet</p>
                <Button 
                  onClick={() => setBankFormOpen(true)}
                  variant="outline"
                  className="border-green-600 text-green-700 hover:bg-green-50"
                >
                  <Plus className="h-4 w-4 mr-2" />
                  Add Your First Bank Account
                </Button>
              </div>
            ) : (
              <div className="space-y-4">
                {bankAccounts.map(account => (
                  <div 
                    key={account.id} 
                    className={`p-4 border rounded-lg ${account.is_primary ? 'border-green-600 bg-green-50' : ''} cursor-pointer hover:shadow-md transition-all`}
                    onClick={() => {
                      setEditingAccount(account);
                      setEditModalOpen(true);
                    }}
                  >
                    <div className="flex justify-between items-start">
                      <div>
                        <div className="flex items-center">
                          <h3 className="font-medium text-green-900">{account.bank_name}</h3>
                          {account.is_primary && (
                            <Badge className="ml-2 bg-green-600">Primary</Badge>
                          )}
                        </div>
                        <p className="text-sm text-gray-600">
                          {account.account_holder_name} &middot; {account.country}
                        </p>
                        <p className="text-sm text-gray-600 mt-1">
                          Account: ••••{account.account_number.slice(-4)}
                        </p>
                      </div>
                      <div className="flex gap-2">
                        {!account.is_primary && (
                          <Button
                            variant="ghost"
                            size="sm"
                            onClick={() => handleSetPrimaryBankAccount(account.id)}
                            className="text-green-700 hover:text-green-800 hover:bg-green-50"
                          >
                            Set Primary
                          </Button>
                        )}
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => handleDeleteBankAccount(account.id)}
                          className="text-red-600 hover:text-red-700 hover:bg-red-50"
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>
        
        {/* Crypto Wallets Section */}
        <Card className="shadow-lg mb-8">
          <CardHeader>
            <CardTitle className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <Wallet className="h-5 w-5 text-green-700" />
                My Crypto Wallets
              </div>
              <Button 
                onClick={() => setCryptoFormOpen(true)}
                variant="outline" 
                size="sm"
                className="border-green-600 text-green-700 hover:bg-green-50"
              >
                <Plus className="h-4 w-4 mr-2" />
                Add Wallet
              </Button>
            </CardTitle>
            <CardDescription>Manage your cryptocurrency wallets for receiving UBI payments</CardDescription>
          </CardHeader>
          <CardContent>
            {cryptoWallets.length === 0 ? (
              <div className="text-center py-8">
                <p className="text-gray-500 mb-4">No crypto wallets added yet</p>
                <Button 
                  onClick={() => setCryptoFormOpen(true)}
                  variant="outline"
                  className="border-green-600 text-green-700 hover:bg-green-50"
                >
                  <Plus className="h-4 w-4 mr-2" />
                  Add Your First Crypto Wallet
                </Button>
              </div>
            ) : (
              <div className="space-y-4">
                {cryptoWallets.map(wallet => {
                  const blockchainName = wallet.blockchain === "other" 
                    ? wallet.other_blockchain 
                    : BLOCKCHAINS.find(b => b.value === wallet.blockchain)?.label || wallet.blockchain;
                    
                  return (
                    <div 
                      key={wallet.id} 
                      className={`p-4 border rounded-lg ${wallet.is_primary ? 'border-green-600 bg-green-50' : ''} cursor-pointer hover:shadow-md transition-all`}
                      onClick={() => {
                        setEditingWallet(wallet);
                        setWalletEditModalOpen(true);
                      }}
                    >
                      <div className="flex justify-between items-start">
                        <div>
                          <div className="flex items-center">
                            <h3 className="font-medium text-green-900">
                              {wallet.wallet_name || blockchainName}
                            </h3>
                            {wallet.is_primary && (
                              <Badge className="ml-2 bg-green-600">Primary</Badge>
                            )}
                          </div>
                          {!wallet.wallet_name && (
                            <p className="text-sm text-gray-600">
                              {blockchainName}
                            </p>
                          )}
                          <p className="text-sm text-gray-600 mt-1 font-mono">
                            {wallet.public_key.length > 16 
                              ? `${wallet.public_key.slice(0, 8)}...${wallet.public_key.slice(-8)}`
                              : wallet.public_key
                            }
                          </p>
                        </div>
                        <div className="flex gap-2">
                          {!wallet.is_primary && (
                            <Button
                              variant="ghost"
                              size="sm"
                              onClick={() => handleSetPrimaryCryptoWallet(wallet.id)}
                              className="text-green-700 hover:text-green-800 hover:bg-green-50"
                            >
                              Set Primary
                            </Button>
                          )}
                          <Button
                            variant="ghost"
                            size="sm"
                            onClick={() => handleDeleteCryptoWallet(wallet.id)}
                            className="text-red-600 hover:text-red-700 hover:bg-red-50"
                          >
                            <Trash2 className="h-4 w-4" />
                          </Button>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            )}
          </CardContent>
        </Card>
        
        {/* Add Edit Modals */}
        <BankAccountForm 
          open={editModalOpen}
          onClose={() => {
            setEditModalOpen(false);
            setEditingAccount(null);
          }}
          onSubmit={handleAccountUpdate}
          initialData={editingAccount}
          userCountry={formData.country}
          userFullName={formData.name}
          isEditing={true}
        />
        
        <CryptoWalletForm 
          open={walletEditModalOpen}
          onClose={() => {
            setWalletEditModalOpen(false);
            setEditingWallet(null);
          }}
          onSubmit={handleWalletUpdate}
          initialData={editingWallet}
          isEditing={true}
        />
        
        {/* Forms */}
        <BankAccountForm 
          open={bankFormOpen}
          onClose={() => setBankFormOpen(false)}
          onSubmit={handleAddBankAccount}
          userCountry={formData.country}
          userFullName={formData.name}
          loading={savingAccount}
        />
        
        <CryptoWalletForm 
          open={cryptoFormOpen}
          onClose={() => setCryptoFormOpen(false)}
          onSubmit={handleAddCryptoWallet}
          loading={savingWallet}
        />
      </div>
      
    </>
  );
}

