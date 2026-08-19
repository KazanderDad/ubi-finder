
import React, { useState, useEffect } from "react";
import { supabase } from "@/lib/supabaseClient";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";
import { Leaf, Filter, Search, ArrowUpDown, Plus } from "lucide-react";
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
import { Link } from 'react-router-dom'; // Import Link from react-router-dom
import { Switch } from "@/components/ui/switch"


export default function Programs() {
  const [programs, setPrograms] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [filters, setFilters] = useState({
    country: "all",
    state: "all",
    paymentType: "all",
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
  
  // Add state for user data
  const [user, setUser] = useState(null);
  
  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);

  useEffect(() => {
    loadData();
  }, []); // Remove checkUserInfo from initial load

  const loadData = async () => {
    try {
      setLoading(true);
      
      // 1. Direct Supabase call for auth and user details
      const { data: { session } } = await supabase.auth.getSession();
      const currentUser = session?.user;
      
      let userData = null;
      if (currentUser) {
        const { data: profile } = await supabase.from('users').select('*').eq('id', currentUser.id).single();
        userData = {
          id: currentUser.id,
          email: currentUser.email,
          full_name: profile?.full_name || currentUser.user_metadata?.full_name,
          role: profile?.role || 'user'
        };
        setUser(userData);
        
        // 2. Direct Supabase call for user profile
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

      // 3. Direct Supabase call for programs list
      const { data: programsData, error } = await supabase
        .from('programs')
        .select('*');
        
      if (error) throw error;
      
      setPrograms(programsData || []);

      // Set these after we have the programs data
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

  const dismissInfoBox = async () => {
    setShowInfoBox(false);
    
    if (profileId) {
      try {
        const { error } = await supabase
          .from('user_profiles')
          .update({ dismissed_program_info: true })
          .eq('id', profileId);
        if (error) throw error;
      } catch (error) {
        console.error("Error updating profile:", error);
      }
    }
  };

  const clearFilters = () => {
    setFilters({
      country: "all",
      state: "all",
      paymentType: "all",
      status: "all"
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

  const createPageUrl = (pageName) => {
    // Define your page URLs here.  Adjust to your routing setup.
    const base = "/";
    switch (pageName) {
      case "SubmitProgram":
        return "/submit-program";  // Adjust this to your actual route
      default:
        return base;
    }
  };
  
  const filteredPrograms = programs.filter(program => {
    if (!filters.includeUnverified && !program.verified) {
      return false;
    }
    
    if (searchTerm && !program.name.toLowerCase().includes(searchTerm.toLowerCase()) && 
        !program.description.toLowerCase().includes(searchTerm.toLowerCase())) {
      return false;
    }
    
    if (filters.country !== "all" && !program.available_regions.includes(filters.country)) {
      return false;
    }
    
    if (filters.status !== "all" && program.status !== filters.status) {
      return false;
    }
    
    if (filters.paymentType !== "all" && program.payment_method !== filters.paymentType) {
      return false;
    }
    
    return true;
  });

  return (
    <>
      <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-12">
        <div className="max-w-5xl mx-auto">
          <section className="mb-10">
            <div className="text-center mb-8">
              <div className="inline-block p-2 bg-green-100 rounded-full mb-4">
                <Leaf className="w-8 h-8 text-green-700" />
              </div>
              <h1 className="text-3xl font-bold text-green-900">UBI Programs</h1>
              <p className="text-lg text-green-700 mt-2">
                Explore available Universal Basic Income opportunities
              </p>
            </div>

            <div className="flex justify-end mb-6">
              <Link to="/Submit-Program">
                <Button className="bg-green-700 hover:bg-green-800">
                  <Plus className="w-5 h-5 mr-2" />
                  Add missing program
                </Button>
              </Link>
            </div>
            
            <div className="space-y-4">
              <Card className="mb-4">
                <CardHeader className="py-3">
                  <div 
                    className="flex justify-between items-center cursor-pointer"
                    onClick={() => setShowSearch(!showSearch)}
                  >
                    <CardTitle className="flex items-center gap-2">
                      <Search className="w-5 h-5 text-green-700" />
                      Search Programs
                    </CardTitle>
                    <Button variant="ghost" size="sm">
                      {showSearch ? "Hide" : "Show"}
                    </Button>
                  </div>
                </CardHeader>
                {showSearch && (
                  <CardContent>
                    <div className="relative">
                      <Search className="absolute left-3 top-3 h-4 w-4 text-gray-400" />
                      <Input
                        placeholder="Search by program name or description"
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                        className="pl-10"
                      />
                    </div>
                  </CardContent>
                )}
              </Card>

              <Card>
                <CardHeader className="py-3">
                  <div 
                    className="flex justify-between items-center cursor-pointer"
                    onClick={() => setShowFilters(!showFilters)}
                  >
                    <CardTitle className="flex items-center gap-2">
                      <Filter className="w-5 h-5 text-green-700" />
                      Filter Programs
                    </CardTitle>
                    <Button variant="ghost" size="sm">
                      {showFilters ? "Hide" : "Show"}
                    </Button>
                  </div>
                </CardHeader>
                {showFilters && (
                  <CardContent>
                    <div className="space-y-4">
                      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                        {/* Existing filters */}
                        <div>
                          <Label className="text-green-700">Country</Label>
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

                        <div>
                          <Label className="text-green-700">Payment Type</Label>
                          <Select
                            value={filters.paymentType}
                            onValueChange={(value) => setFilters({ ...filters, paymentType: value })}
                          >
                            <SelectTrigger>
                              <SelectValue placeholder="Select payment type" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="all">All Types</SelectItem>
                              <SelectItem value="standard">Standard Only</SelectItem>
                              <SelectItem value="digital">Digital Only</SelectItem>
                            </SelectContent>
                          </Select>
                        </div>

                        <div>
                          <Label className="text-green-700">Status</Label>
                          <Select
                            value={filters.status}
                            onValueChange={(value) => setFilters({ ...filters, status: value })}
                          >
                            <SelectTrigger>
                              <SelectValue placeholder="Select status" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="all">All Statuses</SelectItem>
                              {availableStatuses.map(status => (
                                <SelectItem key={status} value={status}>
                                  {status === "all" ? "All Statuses" : 
                                    status.charAt(0).toUpperCase() + status.slice(1)}
                                </SelectItem>
                              ))}
                            </SelectContent>
                          </Select>
                        </div>

                        <div>
                          <Label className="text-green-700">Sort By</Label>
                          <div className="flex space-x-2">
                            <Select
                              value={sortConfig.field}
                              onValueChange={(value) => handleSort(value)}
                            >
                              <SelectTrigger className="flex-1">
                                <SelectValue placeholder="Sort by" />
                              </SelectTrigger>
                              <SelectContent>
                                <SelectItem value="name">Alphabetically</SelectItem>
                                <SelectItem value="amount">Monthly Payout</SelectItem>
                                <SelectItem value="date">Date Added</SelectItem>
                              </SelectContent>
                            </Select>
                            <Button
                              variant="outline"
                              size="icon"
                              onClick={() => setSortConfig({
                                ...sortConfig,
                                direction: sortConfig.direction === 'asc' ? 'desc' : 'asc'
                              })}
                              className="h-10 w-10"
                            >
                              <ArrowUpDown className={`h-4 w-4 transform ${sortConfig.direction === 'desc' ? 'rotate-180' : ''}`} />
                            </Button>
                          </div>
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
                        <Label htmlFor="include-unverified">
                          Include non-reviewed programs
                        </Label>
                      </div>
                    </div>
                  </CardContent>
                )}
              </Card>
            </div>
          </section>

          {/* Programs List */}
          <Card className="shadow-lg">
            <CardHeader>
              <CardTitle>Available Programs</CardTitle>
              <CardDescription>
                {filteredPrograms.length} programs found matching your criteria
              </CardDescription>
            </CardHeader>
            <CardContent>
              <ProgramList 
                programs={filteredPrograms}
                filters={filters}
                favoritePrograms={favoritePrograms}
                onToggleFavorite={toggleFavorite}
                userEmail={user?.email}
                isAdmin={user?.role === 'admin'}
              />
            </CardContent>
          </Card>
        </div>
      </div>
      
    </>
  );
}

