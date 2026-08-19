





import { supabase } from "@/lib/supabaseClient";
import React, { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import {
  User as UserIcon,
  Star,
  ClipboardList,
  FileText,
  Calendar,
  Tag,
  Edit,
  AlertTriangle,
} from "lucide-react";
import { format, parseISO } from "date-fns";

import DashboardProfile from "../components/dashboard/DashboardProfile";
import ApplicationsList from "../components/dashboard/ApplicationsList";


import MatchingPrograms from "../components/dashboard/MatchingPrograms";
import { useNavigate, Link } from "react-router-dom";
import { createPageUrl } from "@/utils";


export default function Dashboard() {
  const navigate = useNavigate();
  const [user, setUser] = useState(null);
  const [userProfile, setUserProfile] = useState(null);
  const [programs, setPrograms] = useState([]);
  const [loading, setLoading] = useState(true);
  const [filters, setFilters] = useState({
    country: "all",
    state: "all",
    paymentType: "all",
    status: "all"
  });
  const [favoritePrograms, setFavoritePrograms] = useState([]);
  const [blogPosts, setBlogPosts] = useState([]);
  const [applications, setApplications] = useState([]);

  useEffect(() => {
    loadData();
  }, []);

  const toggleFavorite = async (programId) => {
    try {
      if (!user) return;
      
      // Get user profile
      const profiles = (await supabase.from('user_profiles').select('*').match({ created_by: user.email })).data;
      if (profiles.length === 0) return;
      const userProfileId = profiles[0].id;
      
      // Check if record already exists
      const existingRecords = (await supabase.from('program_managers').select('*').match({ 
        user_email: user.email,
        program_id: programId,
        is_favorite: true
      })).data;
      
      if (existingRecords.length > 0) {
        // Remove from favorites
        (await supabase.from('program_managers').delete().eq('id', existingRecords[0].id));
        setFavoritePrograms(favoritePrograms.filter(id => id !== programId));
      } else {
        // Add to favorites
        (await supabase.from('program_managers').insert([{
          program_id: programId,
          user_email: user.email,
          user_profile_id: userProfileId,
          role: "viewer",
          is_favorite: true,
          added_date: new Date().toISOString()
        }]).select().single()).data;
        setFavoritePrograms([...favoritePrograms, programId]);
      }
    } catch (error) {
      console.error("Error toggling favorite:", error);
    }
  };

  // Update loadData function to load favorites from ProgramManager
  const loadData = async () => {
    try {
      const userData = (await supabase.auth.getUser()).data.user;
      setUser(userData);

      const pendingProfile = localStorage.getItem("pendingProfile");
      if (pendingProfile) {
        try {
          const data = JSON.parse(pendingProfile);
          (await supabase.from('user_profiles').insert([data]).select().single()).data;
          localStorage.removeItem("pendingProfile");
        } catch (e) {
          console.error("Error creating pending profile", e);
        }
      }

      const profiles = (await supabase.from('user_profiles').select('*').match({ created_by: userData.email })).data;
      if (profiles.length > 0) {
        setUserProfile(profiles[0]);
      }

      const allPrograms = (await supabase.from('programs').select('*')).data;
      setPrograms(allPrograms);

      // Load blog posts
      const allPosts = (await supabase.from('blog_posts').select('*')).data;
      setBlogPosts(allPosts);

      // Load user's applications
      if (profiles.length > 0) {
        const userApplications = (await supabase.from('applications').select('*').match({ 
          user_email: userData.email 
        })).data;
        setApplications(userApplications);
      }

      // Load favorites from ProgramManager
      const favorites = (await supabase.from('program_managers').select('*').match({ 
        user_email: userData.email,
        is_favorite: true
      })).data;
      const favoriteIds = favorites.map(f => f.program_id);
      setFavoritePrograms(favoriteIds);

      setLoading(false);
    } catch (error) {
      console.error("Error loading dashboard data:", error);
    }
  };

  // Get matching program IDs based on user profile
  const getMatchingProgramIds = () => {
    if (!userProfile) return [];
    
    return programs
      .filter(program => {
        // Use the same matching logic as in MatchingPrograms component
        const getIncomeRange = (range) => {
          switch (range) {
            case "0-20k": return 20000;
            case "20k-40k": return 40000;
            case "40k-60k": return 60000;
            case "60k+": return Infinity;
            default: return Infinity;
          }
        };

        if (program.max_household_income_usd && 
            getIncomeRange(userProfile.income_range) > program.max_household_income_usd) {
          return false;
        }

        if (program.gender_requirement && program.gender_requirement !== userProfile.gender) {
          return false;
        }

        if (userProfile.min_monthly_payment && 
            program.monthly_amount_usd < userProfile.min_monthly_payment) {
          return false;
        }

        if (program.available_regions.length > 0) {
          if (!program.available_regions.includes(userProfile.country)) {
            return false;
          }
          
          if (program.required_states && program.required_states.length > 0) {
            if (!program.required_states.includes(userProfile.state)) {
              return false;
            }
          }
        }

        if (program.payment_method === "digital" && !userProfile.accepts_digital_currency) {
          return false;
        }

        return true;
      })
      .map(program => program.program_id);
  };

  // Format date safely
  const formatDate = (dateString) => {
    try {
      if (!dateString) return "Unknown date";
      const date = parseISO(dateString);
      return format(date, 'MMM d, yyyy');
    } catch (error) {
      console.error("Error formatting date:", error);
      return "Unknown date";
    }
  };

  // Get relevant blog posts
  const getRelevantBlogPosts = () => {
    const matchingProgramIds = getMatchingProgramIds();
    return blogPosts.filter(post => {
      if (!post.related_programs) return false;
      return post.related_programs.some(programId => 
        matchingProgramIds.includes(parseInt(programId))
      );
    });
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-700"></div>
      </div>
    );
  }

  // Updated to use the exact format matching the page filename
  const handlePostClick = (postId) => {
    navigate(createPageUrl("BlogPost"), { 
      state: { postId, from: 'dashboard' }
    });
  };

  const getProgramsForPost = (post) => {
    if (!post.related_programs) return [];
    return post.related_programs
      .map(programId => programs.find(p => p.program_id === parseInt(programId)))
      .filter(Boolean); // Remove any undefined values
  };

  return (
    <>
      <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-8">
        <div className="max-w-[90rem] mx-auto">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {/* Left Column - Profile & Applications */}
            <div className="space-y-8 md:col-span-1">
              {/* Profile Card */}
              <DashboardProfile user={user} profile={userProfile} />

              {/* Applications Card */}
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <ClipboardList className="w-5 h-5 text-green-700" />
                    My Applications
                  </CardTitle>
                  <CardDescription className="text-amber-600 flex items-center gap-2">
                    <AlertTriangle className="w-4 h-4" />
                    Application tracking coming soon
                  </CardDescription>
                </CardHeader>
                <CardContent>
                  <ApplicationsList applications={applications} />
                </CardContent>
              </Card>
            </div>

            {/* Middle Column - Available Programs */}
            <div className="md:col-span-1">
              <Card>
                <CardHeader>
                  <div className="flex justify-between items-start">
                    <div>
                      <CardTitle className="flex items-center gap-2">
                        <Star className="w-5 h-5 text-green-700" />
                        My Available UBI Programs
                      </CardTitle>
                      <CardDescription>
                        Selection based on your profile information plus all programs which you marked as favorites
                      </CardDescription>
                    </div>
                    <Link to={createPageUrl("EditProfile")}>
                      <Button
                        variant="outline"
                        className="border-green-600 text-green-700 hover:bg-green-50"
                        size="sm"
                      >
                        <Edit className="w-4 h-4 mr-2" />
                        Edit Profile
                      </Button>
                    </Link>
                  </div>
                </CardHeader>
                <CardContent>
                  <MatchingPrograms 
                    programs={programs}
                    profile={userProfile}
                    favoritePrograms={favoritePrograms}
                    onToggleFavorite={toggleFavorite}
                    applications={applications}
                  />
                </CardContent>
              </Card>
            </div>

            {/* Right Column - News & Updates */}
            <div className="md:col-span-2 lg:col-span-1">
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center justify-between">
                    <div className="flex items-center gap-2">
                      <FileText className="w-5 h-5 text-green-700" />
                      News & Updates
                    </div>
                  </CardTitle>
                  <CardDescription>
                    Latest news about your eligible UBI programs
                  </CardDescription>
                </CardHeader>
                <CardContent>
                  <div className="space-y-6">
                    {getRelevantBlogPosts().map(post => (
                      <div 
                        key={post.id}
                        className="p-4 border rounded-lg hover:shadow-md transition-all duration-300 transform hover:-translate-y-1 bg-white cursor-pointer"
                        onClick={() => handlePostClick(post.id)}
                      >
                        {post.image_url && (
                          <img 
                            src={post.image_url} 
                            alt={post.title}
                            className="w-full h-48 object-cover rounded-lg mb-4"
                          />
                        )}
                        <div className="flex flex-wrap items-center gap-4 text-sm text-gray-600 mb-2">
                          <div className="flex items-center gap-1">
                            <Calendar className="w-4 h-4" />
                            {formatDate(post.posted_date)}
                          </div>
                          <div className="flex items-center gap-1">
                            <UserIcon className="w-4 h-4" />
                            {post.author}
                          </div>
                        </div>
                        <h3 className="text-xl font-semibold text-green-900 mb-2">
                          {post.title}
                        </h3>
                        <p className="text-gray-600 mb-4">{post.summary}</p>
                        
                        {/* Program Pills */}
                        {post.related_programs && post.related_programs.length > 0 && (
                          <div className="flex flex-wrap gap-2 mb-4">
                            {getProgramsForPost(post).map(program => (
                              <Badge key={program.program_id} variant="outline">
                                {program.name}
                              </Badge>
                            ))}
                          </div>
                        )}

                        {post.tags && post.tags.length > 0 && (
                          <div className="flex items-center gap-2">
                            <Tag className="w-4 h-4 text-gray-500" />
                            <div className="flex flex-wrap gap-2">
                              {post.tags.map(tag => (
                                <Badge 
                                  key={tag} 
                                  variant="secondary"
                                  className="bg-gray-100"
                                >
                                  {tag}
                                </Badge>
                              ))}
                            </div>
                          </div>
                        )}
                      </div>
                    ))}

                    {getRelevantBlogPosts().length === 0 && (
                      <div className="text-center py-8">
                        <FileText className="h-12 w-12 text-gray-300 mx-auto mb-4" />
                        <h3 className="text-lg font-medium text-gray-700 mb-1">No updates yet</h3>
                        <p className="text-gray-500">
                          Check back later for news about your eligible programs
                        </p>
                      </div>
                    )}
                  </div>
                </CardContent>
              </Card>
            </div>
          </div>
        </div>
      </div>
      
    </>
  );
}

