import React, { useState, useEffect } from "react";
import { supabase } from "@/lib/supabaseClient";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";
import { 
  Leaf, 
  Filter, 
  Search, 
  ArrowUpDown, 
  Plus, 
  Map as MapIcon, 
  List as ListIcon, 
  Coins, 
  Gift, 
  CheckCircle2, 
  Layers,
  Sparkles,
  Lock,
  FileText,
  UserCheck
} from "lucide-react";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Label } from "@/components/ui/label";
import ProgramList from "../components/dashboard/ProgramList";
import ProgramsMap from "../components/ProgramsMap";
import { Link } from 'react-router-dom';
import { Switch } from "@/components/ui/switch";
import PageHeader from "@/components/ui/page-header";
import { Skeleton } from "@/components/ui/skeleton";
import { Helmet } from "react-helmet-async";
import { evaluateEligibility, isProfileComplete } from "@/lib/matchingEngine";

export default function Programs() {
  const [programs, setPrograms] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [viewMode, setViewMode] = useState("list"); // 'list' | 'map'
  const [filters, setFilters] = useState({
    country: "all",
    state: "all",
    paymentType: "all",
    distributionType: "all",
    payoutRail: "all",
    fundingSource: "all",
    involvementLevel: "all",
    status: "all",
    includeUnverified: false
  });
  const [favoritePrograms, setFavoritePrograms] = useState([]);
  const [userProfile, setUserProfile] = useState(null);
  const [availableCountries, setAvailableCountries] = useState(['all']);
  const [sortField, setSortField] = useState('best_fit'); // 'best_fit' | 'name' | 'amount'
  const [showSearch, setShowSearch] = useState(false);
  const [showFilters, setShowFilters] = useState(false);
  const [user, setUser] = useState(null);
  
  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      setLoading(true);
      
      const { data: { session } } = await supabase.auth.getSession();
      const currentUser = session?.user;
      
      let effectiveProfile = null;

      if (currentUser) {
        let profile = null;
        try {
          const { data } = await supabase.from('users').select('*').eq('id', currentUser.id).maybeSingle();
          profile = data;
        } catch (e) {
          console.warn("Users lookup notice:", e);
        }

        setUser({
          id: currentUser.id,
          email: currentUser.email,
          full_name: profile?.full_name || currentUser.user_metadata?.full_name || currentUser.email?.split('@')[0],
          role: profile?.role || 'user'
        });
        
        let foundProfiles = null;
        let profileId = currentUser.user_metadata?.profile_id || localStorage.getItem("user_profile_id");
        if (profileId) {
          try {
            const { data } = await supabase.from('user_profiles').select('*').eq('id', profileId).limit(1);
            if (data && data.length > 0) foundProfiles = data;
          } catch (e) {
            console.warn("Profile ID lookup notice:", e);
          }
        }

        if (!foundProfiles && currentUser.id) {
          try {
            const { data } = await supabase
              .from('user_profiles')
              .select('*')
              .eq('created_by_id', currentUser.id)
              .order('created_date', { ascending: false });
            if (data && data.length > 0) foundProfiles = data;
          } catch (e) {
            console.warn("created_by_id lookup notice:", e);
          }
        }
          
        if (foundProfiles && foundProfiles.length > 0) {
          effectiveProfile = foundProfiles[0];
          setUserProfile(effectiveProfile);
        }
      }

      // Check localStorage for user_profile_data or pendingProfile if no profile from DB
      if (!effectiveProfile) {
        const stored = localStorage.getItem("user_profile_data") || localStorage.getItem("pendingProfile");
        if (stored) {
          try {
            const parsed = JSON.parse(stored);
            if (parsed && (parsed.country || parsed.income_range || parsed.state || parsed.municipality)) {
              effectiveProfile = parsed;
              setUserProfile(effectiveProfile);
            }
          } catch (e) {
            console.warn("Could not parse stored profile:", e);
          }
        }
      }

      const { data: programsData, error } = await supabase
        .from('programs')
        .select('*')
        .neq('internal_status', 'deleted');
        
      if (error) throw error;
      
      const activePrograms = (programsData || []).filter(p => p.internal_status !== 'deleted');
      setPrograms(activePrograms);

      if (activePrograms.length > 0) {
        setAvailableCountries(['all', ...[...new Set(activePrograms.flatMap(p => p.available_regions || []))].sort()]);
      }
      
      setLoading(false);
    } catch (error) {
      console.error("Error loading data:", error);
      setLoading(false);
    }
  };

  const toggleFavorite = (programId) => {
    const newFavorites = favoritePrograms.includes(programId)
      ? favoritePrograms.filter(id => id !== programId)
      : [...favoritePrograms, programId];
    
    setFavoritePrograms(newFavorites);
    localStorage.setItem('favoritePrograms', JSON.stringify(newFavorites));
  };

  const clearFilters = () => {
    setFilters({
      country: "all",
      state: "all",
      paymentType: "all",
      distributionType: "all",
      payoutRail: "all",
      fundingSource: "all",
      involvementLevel: "all",
      status: "all",
      includeUnverified: false
    });
    setSearchTerm("");
    setSortField(hasCompletedProfile ? 'best_fit' : 'name');
  };

  // Determine user authorization & profile completion states
  const isAuthorized = !!user;
  const hasCompletedProfile = Boolean(userProfile && (isProfileComplete(userProfile) || userProfile.country));

  // 1. Evaluate & Attach Match Scores to Programs
  const scoredPrograms = programs.map(program => {
    if (hasCompletedProfile) {
      const matchResult = evaluateEligibility(program, userProfile);
      return {
        ...program,
        matchScore: matchResult.score,
        matchResult
      };
    }
    return {
      ...program,
      matchScore: undefined,
      matchResult: null
    };
  });

  // 2. Filter Programs
  const filteredPrograms = scoredPrograms.filter(program => {
    if (program.internal_status === 'deleted') {
      return false;
    }

    if (!filters.includeUnverified && !program.verified) {
      return false;
    }
    
    if (searchTerm && !program.name.toLowerCase().includes(searchTerm.toLowerCase()) && 
        !program.description.toLowerCase().includes(searchTerm.toLowerCase())) {
      return false;
    }
    
    if (filters.country !== "all" && !program.available_regions?.includes(filters.country)) {
      return false;
    }
    
    if (filters.status !== "all" && program.status !== filters.status) {
      return false;
    }
    
    if (filters.paymentType !== "all" && program.payment_method !== filters.paymentType) {
      return false;
    }

    // Capability 4 Facet Filtering
    if (filters.distributionType !== "all" && program.distribution_type !== filters.distributionType) {
      return false;
    }

    if (filters.payoutRail !== "all" && program.payout_rail !== filters.payoutRail) {
      return false;
    }

    if (filters.fundingSource !== "all" && program.funding_source !== filters.fundingSource) {
      return false;
    }

    // Involvement Level Filter
    if (filters.involvementLevel !== "all" && (program.involvement_level || 'external_self_apply') !== filters.involvementLevel) {
      return false;
    }
    
    return true;
  });

  // 3. Sort Programs (Default to Best Fit when profile data exists)
  const sortedPrograms = [...filteredPrograms].sort((a, b) => {
    if (sortField === 'best_fit' && hasCompletedProfile) {
      const scoreA = a.matchScore ?? 0;
      const scoreB = b.matchScore ?? 0;
      if (scoreB !== scoreA) {
        return scoreB - scoreA; // Highest score first
      }
      // Secondary sort: Monthly Amount USD descending
      const amountA = Number(a.monthly_amount_usd || 0);
      const amountB = Number(b.monthly_amount_usd || 0);
      return amountB - amountA;
    }

    if (sortField === 'amount') {
      const amountA = Number(a.monthly_amount_usd || 0);
      const amountB = Number(b.monthly_amount_usd || 0);
      return amountB - amountA;
    }

    // Default alphabetical by name
    return a.name.localeCompare(b.name);
  });

  return (
    <>
      <Helmet>
        <title>Browse All UBI Programs, Daily Claims & Lotteries | UBI Finder</title>
        <meta name="description" content="Search verified guaranteed basic income pilots, Web3 daily claim protocols, and community raffles with our interactive map and rail filters." />
      </Helmet>

      <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-12">
        <div className="max-w-5xl mx-auto space-y-6">
          
          <PageHeader 
            icon={Leaf}
            title="Global UBI Programs Directory"
            subtitle="Explore active municipal pilots, Web3 daily claim protocols, and community-funded basic income distributions worldwide."
          />

          {/* Top Controls: Quick Filter Pills, View Switcher & Submit Action */}
          <div className="flex flex-col sm:flex-row items-center justify-between gap-4">
            {/* Quick Filter Pills */}
            <div className="flex flex-wrap items-center gap-2">
              <button
                onClick={() => setFilters(prev => ({ ...prev, distributionType: "all" }))}
                className={`px-3 py-1.5 rounded-full text-xs font-semibold transition-all ${
                  filters.distributionType === "all"
                    ? "bg-green-700 text-white shadow-sm"
                    : "bg-white text-gray-600 hover:bg-green-50 border border-gray-200"
                }`}
              >
                All Programs
              </button>
              <button
                onClick={() => setFilters(prev => ({ ...prev, distributionType: "guaranteed_recurrent" }))}
                className={`px-3 py-1.5 rounded-full text-xs font-semibold transition-all flex items-center gap-1.5 ${
                  filters.distributionType === "guaranteed_recurrent"
                    ? "bg-emerald-700 text-white shadow-sm"
                    : "bg-white text-emerald-800 hover:bg-emerald-50 border border-emerald-200"
                }`}
              >
                <CheckCircle2 className="w-3.5 h-3.5" />
                Guaranteed Monthly
              </button>
              <button
                onClick={() => setFilters(prev => ({ ...prev, distributionType: "daily_claim_protocol" }))}
                className={`px-3 py-1.5 rounded-full text-xs font-semibold transition-all flex items-center gap-1.5 ${
                  filters.distributionType === "daily_claim_protocol"
                    ? "bg-purple-700 text-white shadow-sm"
                    : "bg-white text-purple-800 hover:bg-purple-50 border border-purple-200"
                }`}
              >
                <Coins className="w-3.5 h-3.5" />
                Daily Claim Protocols
              </button>
              <button
                onClick={() => setFilters(prev => ({ ...prev, distributionType: "lottery_raffle" }))}
                className={`px-3 py-1.5 rounded-full text-xs font-semibold transition-all flex items-center gap-1.5 ${
                  filters.distributionType === "lottery_raffle"
                    ? "bg-amber-600 text-white shadow-sm"
                    : "bg-white text-amber-800 hover:bg-amber-50 border border-amber-200"
                }`}
              >
                <Gift className="w-3.5 h-3.5" />
                Lotteries & Raffles
              </button>
            </div>

            {/* View Mode Switcher (List vs Map) & Submit Button */}
            <div className="flex items-center gap-3">
              <div className="bg-gray-100 p-1 rounded-xl flex items-center border border-gray-200">
                <button
                  onClick={() => setViewMode("list")}
                  className={`px-3 py-1.5 rounded-lg text-xs font-semibold flex items-center gap-1.5 transition-all ${
                    viewMode === "list" 
                      ? "bg-white text-green-950 shadow-sm" 
                      : "text-gray-600 hover:text-gray-900"
                  }`}
                >
                  <ListIcon className="w-3.5 h-3.5" />
                  List View
                </button>
                <button
                  onClick={() => setViewMode("map")}
                  className={`px-3 py-1.5 rounded-lg text-xs font-semibold flex items-center gap-1.5 transition-all ${
                    viewMode === "map" 
                      ? "bg-white text-green-950 shadow-sm" 
                      : "text-gray-600 hover:text-gray-900"
                  }`}
                >
                  <MapIcon className="w-3.5 h-3.5" />
                  Map View
                </button>
              </div>

              <Link to={user ? "/Submit-Program" : "/login?view=signup&redirectTo=/Submit-Program"}>
                <Button className="bg-green-700 hover:bg-green-800 text-xs shadow-sm h-9">
                  <Plus className="w-4 h-4 mr-1" />
                  Submit Program
                </Button>
              </Link>
            </div>
          </div>

          {/* Quick Filter Involvement Pills */}
          <div className="flex items-center gap-2 overflow-x-auto pb-1 text-xs">
            <button
              type="button"
              onClick={() => setFilters(prev => ({ ...prev, involvementLevel: 'all' }))}
              className={`px-3 py-1.5 rounded-full font-semibold border transition-all whitespace-nowrap ${
                filters.involvementLevel === 'all'
                  ? 'bg-green-800 text-white border-green-800 shadow-sm'
                  : 'bg-white text-gray-700 border-gray-200 hover:bg-gray-50'
              }`}
            >
              All Projects ({programs.length})
            </button>
            <button
              type="button"
              onClick={() => setFilters(prev => ({ ...prev, involvementLevel: 'managed_application' }))}
              className={`px-3 py-1.5 rounded-full font-semibold border transition-all whitespace-nowrap flex items-center gap-1.5 ${
                filters.involvementLevel === 'managed_application'
                  ? 'bg-emerald-800 text-white border-emerald-800 shadow-sm'
                  : 'bg-emerald-50/70 text-emerald-900 border-emerald-200 hover:bg-emerald-100'
              }`}
            >
              🛡️ Managed Applications
            </button>
            <button
              type="button"
              onClick={() => setFilters(prev => ({ ...prev, involvementLevel: 'automated_claim' }))}
              className={`px-3 py-1.5 rounded-full font-semibold border transition-all whitespace-nowrap flex items-center gap-1.5 ${
                filters.involvementLevel === 'automated_claim'
                  ? 'bg-purple-800 text-white border-purple-800 shadow-sm'
                  : 'bg-purple-50/70 text-purple-900 border-purple-200 hover:bg-purple-100'
              }`}
            >
              🟣 Automated Claim Protocols
            </button>
            <button
              type="button"
              onClick={() => setFilters(prev => ({ ...prev, involvementLevel: 'external_self_apply' }))}
              className={`px-3 py-1.5 rounded-full font-semibold border transition-all whitespace-nowrap flex items-center gap-1.5 ${
                filters.involvementLevel === 'external_self_apply'
                  ? 'bg-blue-800 text-white border-blue-800 shadow-sm'
                  : 'bg-blue-50/70 text-blue-900 border-blue-200 hover:bg-blue-100'
              }`}
            >
              🌐 External Self-Apply
            </button>
          </div>

          {/* ========================================================================= */}
          {/* USER STATUS / PERSONALIZATION CALLOUT BANNERS */}
          {/* ========================================================================= */}
          
          {/* Condition 1: Non-Authorized Users (Prompt to Log In) */}
          {!isAuthorized && (
            <Card className="border-emerald-200 bg-gradient-to-r from-emerald-50 via-teal-50 to-green-50 shadow-sm overflow-hidden animate-in fade-in duration-200">
              <CardContent className="p-5 flex flex-col sm:flex-row items-center justify-between gap-4">
                <div className="flex items-center gap-3.5 text-center sm:text-left">
                  <div className="w-10 h-10 rounded-full bg-emerald-100 border border-emerald-300 flex items-center justify-center flex-shrink-0 text-emerald-800 shadow-inner">
                    <Lock className="w-5 h-5" />
                  </div>
                  <div>
                    <h4 className="text-sm font-bold text-emerald-950">
                      Please log in to get a personalized view of these UBI programs.
                    </h4>
                    <p className="text-xs text-emerald-700 mt-0.5">
                      Sign in or create an account to unlock tailored eligibility matching, best-fit ranking, and advanced filter facets.
                    </p>
                  </div>
                </div>
                <Link to="/login" className="flex-shrink-0">
                  <Button className="bg-emerald-700 hover:bg-emerald-800 text-white font-semibold text-xs h-9 shadow-sm px-4">
                    Log In / Sign Up &rarr;
                  </Button>
                </Link>
              </CardContent>
            </Card>
          )}

          {/* Condition 2: Authenticated Users Without a Completed Profile (Prompt to Fill Out Form) */}
          {isAuthorized && !hasCompletedProfile && (
            <Card className="border-amber-200 bg-gradient-to-r from-amber-50 via-yellow-50 to-orange-50 shadow-sm overflow-hidden animate-in fade-in duration-200">
              <CardContent className="p-5 flex flex-col sm:flex-row items-center justify-between gap-4">
                <div className="flex items-center gap-3.5 text-center sm:text-left">
                  <div className="w-10 h-10 rounded-full bg-amber-100 border border-amber-300 flex items-center justify-center flex-shrink-0 text-amber-800 shadow-inner">
                    <FileText className="w-5 h-5" />
                  </div>
                  <div>
                    <h4 className="text-sm font-bold text-amber-950">
                      Fill out our form for a personalized view
                    </h4>
                    <p className="text-xs text-amber-800 mt-0.5">
                      Tell us your location, household size, and income to automatically sort programs based on best fit.
                    </p>
                  </div>
                </div>
                <Link to="/My-Report" className="flex-shrink-0">
                  <Button className="bg-amber-600 hover:bg-amber-700 text-white font-semibold text-xs h-9 shadow-sm px-4">
                    Fill Out Eligibility Form &rarr;
                  </Button>
                </Link>
              </CardContent>
            </Card>
          )}

          {/* Condition 3: Form Data Exists (Active Personalized View & Best Fit Indicator) */}
          {hasCompletedProfile && (
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 bg-emerald-50/90 border border-emerald-200 rounded-xl px-4 py-3 text-xs text-emerald-900 shadow-sm animate-in fade-in duration-200">
              <div className="flex items-center gap-2.5">
                <div className="w-6 h-6 rounded-full bg-emerald-600 text-white flex items-center justify-center flex-shrink-0">
                  <Sparkles className="w-3.5 h-3.5" />
                </div>
                <div>
                  <span className="font-bold text-emerald-950">Personalized View Active: </span>
                  <span>
                    Sorted based on best fit for your profile in {userProfile.municipality ? `${userProfile.municipality}, ` : ''}{userProfile.state ? `${userProfile.state}, ` : ''}{userProfile.country || 'your location'}.
                  </span>
                </div>
              </div>
              <div className="flex items-center gap-2 self-end sm:self-auto flex-shrink-0">
                <Link to="/My-Report" className="text-emerald-800 hover:text-emerald-950 font-bold underline whitespace-nowrap">
                  View Full Report &rarr;
                </Link>
              </div>
            </div>
          )}
            
          {/* Search Keyword Box (Always Available) */}
          <div className="space-y-3">
            <Card className="shadow-sm border-gray-200">
              <CardHeader className="py-3">
                <div 
                  className="flex justify-between items-center cursor-pointer"
                  onClick={() => setShowSearch(!showSearch)}
                >
                  <CardTitle className="flex items-center gap-2 text-sm text-green-900 font-bold">
                    <Search className="w-4 h-4 text-green-700" />
                    Search Keyword
                  </CardTitle>
                  <Button variant="ghost" size="sm" className="text-xs">
                    {showSearch ? "Hide" : "Show"}
                  </Button>
                </div>
              </CardHeader>
              {showSearch && (
                <CardContent className="pt-0">
                  <div className="relative">
                    <Search className="absolute left-3 top-3 h-4 w-4 text-gray-400" />
                    <Input
                      placeholder="Search by program name, city, or organization..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10"
                    />
                  </div>
                </CardContent>
              )}
            </Card>

            {/* Advanced Facet Filters (ONLY shown for authorized users) */}
            {isAuthorized && (
              <Card className="shadow-sm border-gray-200">
                <CardHeader className="py-3">
                  <div 
                    className="flex justify-between items-center cursor-pointer"
                    onClick={() => setShowFilters(!showFilters)}
                  >
                    <CardTitle className="flex items-center gap-2 text-sm text-green-900 font-bold">
                      <Filter className="w-4 h-4 text-green-700" />
                      Advanced Facet Filters
                    </CardTitle>
                    <Button variant="ghost" size="sm" className="text-xs">
                      {showFilters ? "Hide" : "Show Filters"}
                    </Button>
                  </div>
                </CardHeader>
                {showFilters && (
                  <CardContent className="pt-0">
                    <div className="space-y-4">
                      <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-4 text-xs">
                        
                        {/* Involvement Level */}
                        <div>
                          <Label className="text-green-900 font-semibold mb-1 block">Involvement Level</Label>
                          <Select
                            value={filters.involvementLevel}
                            onValueChange={(value) => setFilters({ ...filters, involvementLevel: value })}
                          >
                            <SelectTrigger>
                              <SelectValue placeholder="Involvement level" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="all">All Types</SelectItem>
                              <SelectItem value="managed_application">🛡️ Managed Applications</SelectItem>
                              <SelectItem value="automated_claim">🟣 Automated Claim Protocols</SelectItem>
                              <SelectItem value="external_self_apply">🌐 External Self-Apply</SelectItem>
                            </SelectContent>
                          </Select>
                        </div>

                        {/* Country */}
                        <div>
                          <Label className="text-green-900 font-semibold mb-1 block">Country</Label>
                          <Select
                            value={filters.country}
                            onValueChange={(value) => setFilters({ ...filters, country: value })}
                          >
                            <SelectTrigger>
                              <SelectValue placeholder="Select country" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="all">All Countries</SelectItem>
                              {availableCountries.map(country => (
                                <SelectItem key={country} value={country}>
                                  {country === "all" ? "All Countries" : 
                                    country.charAt(0).toUpperCase() + country.slice(1)}
                                </SelectItem>
                              ))}
                            </SelectContent>
                          </Select>
                        </div>

                        {/* Capability 4: Distribution Model */}
                        <div>
                          <Label className="text-green-900 font-semibold mb-1 block">Distribution Model</Label>
                          <Select
                            value={filters.distributionType}
                            onValueChange={(value) => setFilters({ ...filters, distributionType: value })}
                          >
                            <SelectTrigger>
                              <SelectValue placeholder="Distribution model" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="all">All Models</SelectItem>
                              <SelectItem value="guaranteed_recurrent">Guaranteed Monthly</SelectItem>
                              <SelectItem value="daily_claim_protocol">Daily Claim Protocol</SelectItem>
                              <SelectItem value="lottery_raffle">Lottery / Raffle</SelectItem>
                            </SelectContent>
                          </Select>
                        </div>

                        {/* Capability 4: Payout Rail */}
                        <div>
                          <Label className="text-green-900 font-semibold mb-1 block">Payout Delivery Rail</Label>
                          <Select
                            value={filters.payoutRail}
                            onValueChange={(value) => setFilters({ ...filters, payoutRail: value })}
                          >
                            <SelectTrigger>
                              <SelectValue placeholder="Delivery rail" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="all">All Delivery Rails</SelectItem>
                              <SelectItem value="direct_deposit">Bank Direct Deposit / ACH</SelectItem>
                              <SelectItem value="prepaid_card">Prepaid Visa / Mastercard</SelectItem>
                              <SelectItem value="crypto_wallet">Crypto / Smart Contract</SelectItem>
                              <SelectItem value="mobile_money">Mobile Money (M-Pesa)</SelectItem>
                            </SelectContent>
                          </Select>
                        </div>

                        {/* Capability 4: Funding Source */}
                        <div>
                          <Label className="text-green-900 font-semibold mb-1 block">Funding Source</Label>
                          <Select
                            value={filters.fundingSource}
                            onValueChange={(value) => setFilters({ ...filters, fundingSource: value })}
                          >
                            <SelectTrigger>
                              <SelectValue placeholder="Funding source" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="all">All Funding Sources</SelectItem>
                              <SelectItem value="municipal_government">Municipal / City Government</SelectItem>
                              <SelectItem value="state_federal">State / Federal Budget</SelectItem>
                              <SelectItem value="philanthropic_grant">Philanthropic Grant</SelectItem>
                              <SelectItem value="protocol_yield">Protocol Treasury / Yield</SelectItem>
                              <SelectItem value="community_crowdfund">Community Crowdfunded</SelectItem>
                            </SelectContent>
                          </Select>
                        </div>

                      </div>

                      <Separator />

                      <div className="flex items-center space-x-2">
                        <Switch
                          id="include-unverified"
                          checked={filters.includeUnverified}
                          onCheckedChange={(checked) => 
                            setFilters(prev => ({ ...prev, includeUnverified: checked }))
                          }
                        />
                        <Label htmlFor="include-unverified" className="text-xs text-gray-700 cursor-pointer">
                          Include unverified / community-submitted programs
                        </Label>
                      </div>
                    </div>
                  </CardContent>
                )}
              </Card>
            )}
          </div>

          {/* Main Content Area: Map View vs List View */}
          {viewMode === "map" ? (
            <Card className="shadow-lg border-green-100 bg-white/95 overflow-hidden">
              <CardHeader className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 pb-4">
                <div>
                  <CardTitle className="text-2xl text-green-950 font-bold flex items-center gap-2">
                    <MapIcon className="w-5 h-5 text-green-700" />
                    Interactive Program Explorer
                  </CardTitle>
                  <CardDescription className="text-sm text-gray-500 mt-1">
                    Showing <span className="font-semibold text-green-800">{sortedPrograms.length}</span> mapped initiatives across the globe. Click any marker for instant payout details.
                  </CardDescription>
                </div>
              </CardHeader>
              <CardContent className="p-0 sm:p-6 sm:pt-0">
                <ProgramsMap programs={sortedPrograms} />
              </CardContent>
            </Card>
          ) : (
            <Card className="shadow-lg border-green-100 bg-white/95">
              <CardHeader className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4">
                <div>
                  <CardTitle className="text-2xl text-green-950 font-bold">Available Programs</CardTitle>
                  <CardDescription className="text-sm text-gray-500 mt-1">
                    Showing <span className="font-semibold text-green-800">{sortedPrograms.length}</span> of {programs.length} verified programs
                    {hasCompletedProfile && (
                      <span className="text-emerald-700 font-medium ml-1">
                        • Ranked by Best Fit
                      </span>
                    )}
                  </CardDescription>
                </div>

                {/* Sort selector & Clear button */}
                <div className="flex items-center gap-2 self-start sm:self-auto">
                  <div className="flex items-center gap-1.5 text-xs text-gray-600">
                    <ArrowUpDown className="w-3.5 h-3.5 text-gray-400" />
                    <span className="font-semibold">Sort:</span>
                    <Select value={sortField} onValueChange={setSortField}>
                      <SelectTrigger className="h-8 text-xs w-40 bg-white">
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        {hasCompletedProfile && (
                          <SelectItem value="best_fit">✨ Best Fit Score</SelectItem>
                        )}
                        <SelectItem value="name">Alphabetical (A-Z)</SelectItem>
                        <SelectItem value="amount">Highest Monthly Amount</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>

                  {(searchTerm || filters.country !== "all" || filters.distributionType !== "all" || filters.payoutRail !== "all" || filters.fundingSource !== "all" || filters.includeUnverified) && (
                    <Button 
                      variant="ghost" 
                      size="sm" 
                      onClick={clearFilters}
                      className="text-xs text-green-700 hover:text-green-800 hover:bg-green-50 h-8"
                    >
                      Clear Filters
                    </Button>
                  )}
                </div>
              </CardHeader>
              <CardContent>
                {loading ? (
                  <div className="space-y-4">
                    {[1, 2, 3, 4].map(i => (
                      <div key={i} className="p-6 bg-white rounded-xl border border-gray-100 shadow-sm animate-pulse space-y-4">
                        <div className="flex justify-between items-start">
                          <div className="space-y-2 w-2/3">
                            <div className="h-5 bg-gray-200 rounded w-1/2" />
                            <div className="h-4 bg-gray-100 rounded w-1/3" />
                          </div>
                          <div className="h-10 bg-green-50 rounded-xl w-32" />
                        </div>
                        <div className="flex gap-2">
                          <div className="h-6 bg-gray-100 rounded-full w-24" />
                          <div className="h-6 bg-gray-100 rounded-full w-28" />
                        </div>
                        <div className="h-10 bg-gray-50 rounded w-full" />
                      </div>
                    ))}
                  </div>
                ) : (
                  <ProgramList 
                    programs={sortedPrograms}
                    filters={filters}
                    favoritePrograms={favoritePrograms}
                    onToggleFavorite={toggleFavorite}
                    userEmail={user?.email}
                    isAdmin={user?.role === 'admin' || user?.role === 'owner'}
                    onClearFilters={clearFilters}
                  />
                )}
              </CardContent>
            </Card>
          )}

        </div>
      </div>
    </>
  );
}
