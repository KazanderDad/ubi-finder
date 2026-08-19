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
  Sparkles
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
    status: "all",
    includeUnverified: false
  });
  const [favoritePrograms, setFavoritePrograms] = useState([]);
  const [showInfoBox, setShowInfoBox] = useState(true);
  const [userProfile, setUserProfile] = useState(null);
  const [profileId, setProfileId] = useState(null);
  const [availableCountries, setAvailableCountries] = useState(['all']);
  const [availableStatuses, setAvailableStatuses] = useState(['all']);
  const [sortConfig, setSortConfig] = useState({
    field: 'name',
    direction: 'asc'
  });
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
      
      if (currentUser) {
        const { data: profile } = await supabase.from('users').select('*').eq('id', currentUser.id).single();
        setUser({
          id: currentUser.id,
          email: currentUser.email,
          full_name: profile?.full_name || currentUser.user_metadata?.full_name,
          role: profile?.role || 'user'
        });
        
        const { data: profiles } = await supabase
          .from('user_profiles')
          .select('*')
          .eq('created_by_id', currentUser.id);
          
        if (profiles && profiles.length > 0) {
          setUserProfile(profiles[0]);
          setProfileId(profiles[0].id);
          setShowInfoBox(!profiles[0].dismissed_program_info);
        }
      }

      const { data: programsData, error } = await supabase
        .from('programs')
        .select('*');
        
      if (error) throw error;
      
      setPrograms(programsData || []);

      if (programsData) {
        setAvailableCountries(['all', ...[...new Set(programsData.flatMap(p => p.available_regions || []))].sort()]);
        setAvailableStatuses(['all', ...[...new Set(programsData.map(p => p.status))].sort()]);
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
      status: "all",
      includeUnverified: false
    });
    setSearchTerm("");
    setSortConfig({
      field: 'name',
      direction: 'asc'
    });
  };

  const handleSort = (field) => {
    setSortConfig({
      field,
      direction: sortConfig.field === field && sortConfig.direction === 'asc' ? 'desc' : 'asc'
    });
  };

  const filteredPrograms = programs.filter(program => {
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
    
    return true;
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
            {/* Quick Filter Pills (Capability 4) */}
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

              <Link to="/Submit-Program">
                <Button className="bg-green-700 hover:bg-green-800 text-xs shadow-sm h-9">
                  <Plus className="w-4 h-4 mr-1" />
                  Submit Program
                </Button>
              </Link>
            </div>
          </div>
            
          {/* Search & Filter Collapsibles */}
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
                    Showing <span className="font-semibold text-green-800">{filteredPrograms.length}</span> mapped initiatives across the globe. Click any marker for instant payout details.
                  </CardDescription>
                </div>
              </CardHeader>
              <CardContent className="p-0 sm:p-6 sm:pt-0">
                <ProgramsMap programs={filteredPrograms} />
              </CardContent>
            </Card>
          ) : (
            <Card className="shadow-lg border-green-100 bg-white/95">
              <CardHeader className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 pb-4">
                <div>
                  <CardTitle className="text-2xl text-green-950 font-bold">Available Programs</CardTitle>
                  <CardDescription className="text-sm text-gray-500 mt-1">
                    Showing <span className="font-semibold text-green-800">{filteredPrograms.length}</span> of {programs.length} verified programs
                  </CardDescription>
                </div>
                {(searchTerm || filters.country !== "all" || filters.distributionType !== "all" || filters.payoutRail !== "all" || filters.fundingSource !== "all" || filters.includeUnverified) && (
                  <Button 
                    variant="ghost" 
                    size="sm" 
                    onClick={clearFilters}
                    className="text-xs text-green-700 hover:text-green-800 hover:bg-green-50 self-start sm:self-auto"
                  >
                    Clear All Filters
                  </Button>
                )}
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
                    programs={filteredPrograms}
                    filters={filters}
                    favoritePrograms={favoritePrograms}
                    onToggleFavorite={toggleFavorite}
                    userEmail={user?.email}
                    isAdmin={user?.role === 'admin'}
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
