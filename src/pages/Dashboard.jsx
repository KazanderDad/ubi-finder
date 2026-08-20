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
  CheckCircle2,
  Circle,
  Bell,
  Sparkles,
  ArrowRight,
  Heart
} from "lucide-react";
import { format, parseISO } from "date-fns";

import DashboardProfile from "../components/dashboard/DashboardProfile";
import ApplicationsList from "../components/dashboard/ApplicationsList";
import MatchingPrograms from "../components/dashboard/MatchingPrograms";
import { useNavigate, Link } from "react-router-dom";
import { createPageUrl } from "@/utils";
import { syncMatchSnapshotAndDetectDeltas } from "@/lib/matchDeltaService";

export default function Dashboard() {
  const navigate = useNavigate();
  const [user, setUser] = useState(null);
  const [userProfile, setUserProfile] = useState(null);
  const [programs, setPrograms] = useState([]);
  const [loading, setLoading] = useState(true);
  const [favoritePrograms, setFavoritePrograms] = useState([]);
  const [blogPosts, setBlogPosts] = useState([]);
  const [applications, setApplications] = useState([]);
  const [alertsEnabled, setAlertsEnabled] = useState(true);
  const [matchDeltas, setMatchDeltas] = useState([]);

  useEffect(() => {
    loadData();
  }, []);

  const toggleFavorite = async (programId) => {
    try {
      if (!user) return;
      
      const profiles = (await supabase.from('user_profiles').select('*').match({ created_by: user.email })).data;
      if (profiles.length === 0) return;
      const userProfileId = profiles[0].id;
      
      const existingRecords = (await supabase.from('program_managers').select('*').match({ 
        user_email: user.email,
        program_id: programId,
        is_favorite: true
      })).data;
      
      if (existingRecords.length > 0) {
        (await supabase.from('program_managers').delete().eq('id', existingRecords[0].id));
        setFavoritePrograms(favoritePrograms.filter(id => id !== programId));
      } else {
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

  const loadData = async () => {
    try {
      const userData = (await supabase.auth.getUser()).data.user;
      if (!userData) {
        navigate("/login");
        return;
      }
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

      let currentProf = null;
      const profiles = (await supabase.from('user_profiles').select('*').match({ created_by: userData.email })).data;
      if (profiles && profiles.length > 0) {
        currentProf = profiles[0];
        setUserProfile(currentProf);
      }

      const allPrograms = (await supabase.from('programs').select('*').neq('internal_status', 'deleted')).data;
      const activePrograms = (allPrograms || []).filter(p => p.internal_status !== 'deleted');
      setPrograms(activePrograms);

      // Run dynamic snapshot delta comparison
      if (activePrograms.length > 0) {
        const deltaRes = await syncMatchSnapshotAndDetectDeltas(userData, currentProf, activePrograms);
        if (deltaRes?.deltas) {
          setMatchDeltas(deltaRes.deltas);
        }
      }

      const allPosts = (await supabase.from('blog_posts').select('*')).data;
      setBlogPosts(allPosts || []);

      if (userData?.email) {
        const userApplications = (await supabase.from('applications').select('*').match({ 
          user_email: userData.email 
        })).data;
        setApplications(userApplications || []);
      }

      const favorites = (await supabase.from('program_managers').select('*').match({ 
        user_email: userData.email,
        is_favorite: true
      })).data;
      const favoriteIds = (favorites || []).map(f => f.program_id);
      setFavoritePrograms(favoriteIds);

      setLoading(false);
    } catch (error) {
      console.error("Error loading dashboard data:", error);
      setLoading(false);
    }
  };

  const getMatchingProgramIds = () => {
    if (!userProfile) return [];
    return programs
      .filter(program => {
        if (program.internal_status === 'deleted') return false;
        if (program.gender_requirement && program.gender_requirement !== userProfile.gender) return false;
        if (program.available_regions && program.available_regions.length > 0) {
          const inRegion = program.available_regions.includes(userProfile.country) || 
                           program.available_regions.includes("Global") || 
                           program.available_regions.includes("Worldwide");
          if (!inRegion) return false;
        }
        return true;
      })
      .map(program => program.program_id);
  };

  const formatDate = (dateString) => {
    try {
      if (!dateString) return "";
      const date = parseISO(dateString);
      return format(date, 'MMM d, yyyy');
    } catch (error) {
      return "";
    }
  };

  const getRelevantBlogPosts = () => {
    const matchingProgramIds = getMatchingProgramIds();
    return blogPosts.filter(post => {
      if (!post.related_programs) return true;
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

  const handlePostClick = (postId) => {
    navigate(createPageUrl("BlogPost"), { 
      state: { postId, from: 'dashboard' }
    });
  };

  const getProgramsForPost = (post) => {
    if (!post.related_programs) return [];
    return post.related_programs
      .map(programId => programs.find(p => p.program_id === parseInt(programId)))
      .filter(Boolean);
  };

  // 5a. Onboarding Checklist Calculation
  const isProfileComplete = !!userProfile?.country && !!userProfile?.income_range;
  const hasSavedFavorites = favoritePrograms.length >= 3;
  const hasExploredCommunity = true;

  const checklistItems = [
    { label: "Account verified & authenticated", completed: true },
    { label: "Complete eligibility profile details", completed: isProfileComplete, link: "/EditProfile", action: "Edit Profile" },
    { label: `Save at least 3 favorite programs (${favoritePrograms.length}/3)`, completed: hasSavedFavorites, link: "/Programs", action: "Browse" },
    { label: "Explore community questions & discussions", completed: hasExploredCommunity, link: "/Community", action: "Visit Hub" },
  ];

  const completedCount = checklistItems.filter(item => item.completed).length;
  const progressPercent = Math.round((completedCount / checklistItems.length) * 100);

  return (
    <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-8">
      <div className="max-w-[90rem] mx-auto space-y-8">
        
        {/* Welcome Header */}
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 bg-white/90 backdrop-blur-sm p-6 rounded-2xl border border-green-100 shadow-sm">
          <div>
            <h1 className="text-2xl md:text-3xl font-extrabold text-green-950">
              Welcome back, {userProfile?.name || user?.email?.split('@')[0] || "Friend"} 👋
            </h1>
            <p className="text-sm text-gray-600 mt-1">
              Your centralized dashboard for Universal Basic Income matches, applications, and updates.
            </p>
          </div>
          <div className="flex items-center gap-3 flex-wrap">
            <Link to="/My-Report">
              <Button className="bg-emerald-800 hover:bg-emerald-900 text-white font-bold text-xs shadow-sm flex items-center gap-1.5">
                <Sparkles className="w-3.5 h-3.5 text-yellow-300" />
                View Personalized Report
              </Button>
            </Link>
            <Link to="/Programs">
              <Button variant="outline" className="border-green-700 text-green-700 hover:bg-green-50 font-medium text-xs shadow-sm">
                Browse All Programs &rarr;
              </Button>
            </Link>
          </div>
        </div>

        {/* Dynamic Match Delta Notification Banner */}
        {matchDeltas.length > 0 && (
          <div className="p-4 bg-emerald-50 border border-emerald-200 rounded-2xl flex items-start gap-3 shadow-sm animate-in fade-in">
            <Bell className="w-5 h-5 text-emerald-700 mt-0.5 flex-shrink-0" />
            <div className="flex-1 text-xs text-emerald-950">
              <span className="font-bold text-sm block mb-1">
                Recent Updates to Your Matching Programs ({matchDeltas.length})
              </span>
              <ul className="list-disc pl-4 space-y-1 text-emerald-900">
                {matchDeltas.map((d, idx) => (
                  <li key={idx}><strong>{d.programName}:</strong> {d.message}</li>
                ))}
              </ul>
            </div>
            <Link to="/My-Report">
              <Button size="sm" variant="outline" className="border-emerald-700 text-emerald-900 text-[11px] h-7">
                Review Report
              </Button>
            </Link>
          </div>
        )}

        {/* 5a. Onboarding Checklist & 5d. Alerts row */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* 5a: Onboarding Checklist Card */}
          <Card className="lg:col-span-2 shadow-md border-green-100 bg-white/95 backdrop-blur-sm">
            <CardHeader className="pb-3">
              <div className="flex items-center justify-between">
                <CardTitle className="text-base font-bold text-green-950 flex items-center gap-2">
                  <Sparkles className="w-4 h-4 text-green-600" />
                  Your Getting Started Checklist
                </CardTitle>
                <span className="text-xs font-semibold text-green-800 bg-green-50 px-2.5 py-1 rounded-full border border-green-200">
                  {completedCount} of {checklistItems.length} Complete ({progressPercent}%)
                </span>
              </div>
              <div className="w-full bg-gray-100 h-2 rounded-full mt-2 overflow-hidden">
                <div 
                  className="bg-green-600 h-full rounded-full transition-all duration-500"
                  style={{ width: `${progressPercent}%` }}
                />
              </div>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 pt-1">
                {checklistItems.map((item, index) => (
                  <div 
                    key={index}
                    className={`p-3 rounded-xl border flex items-center justify-between gap-3 text-xs ${
                      item.completed 
                        ? 'bg-green-50/60 border-green-200 text-green-900' 
                        : 'bg-gray-50 border-gray-200 text-gray-700'
                    }`}
                  >
                    <div className="flex items-center gap-2.5">
                      {item.completed ? (
                        <CheckCircle2 className="w-4 h-4 text-green-600 flex-shrink-0" />
                      ) : (
                        <Circle className="w-4 h-4 text-gray-400 flex-shrink-0" />
                      )}
                      <span className={item.completed ? "font-medium" : "text-gray-600"}>
                        {item.label}
                      </span>
                    </div>
                    {!item.completed && item.link && (
                      <Link to={item.link} className="text-green-700 font-semibold hover:underline flex-shrink-0">
                        {item.action} &rarr;
                      </Link>
                    )}
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>

          {/* 5d: Program Alerts Opt-in Card */}
          <Card className="shadow-md border-green-100 bg-emerald-900 text-white flex flex-col justify-between">
            <CardHeader className="pb-2">
              <div className="flex items-center gap-2 text-emerald-300">
                <Bell className="w-4 h-4" />
                <span className="text-xs uppercase font-bold tracking-wider">Opportunity Alerts</span>
              </div>
              <CardTitle className="text-lg font-bold text-white mt-1">
                Instant Match Notifications
              </CardTitle>
              <CardDescription className="text-emerald-200 text-xs mt-1 leading-relaxed">
                Receive instant email alerts whenever a new UBI or guaranteed income pilot opens in {userProfile?.country || "your region"}.
              </CardDescription>
            </CardHeader>
            <CardContent className="pt-2">
              <div className="p-3 bg-emerald-800/80 rounded-xl border border-emerald-700/80 flex items-center justify-between text-xs">
                <span className="font-medium text-emerald-100">
                  {alertsEnabled ? "🟢 Alerts Active" : "⚪ Alerts Paused"}
                </span>
                <button 
                  onClick={() => setAlertsEnabled(!alertsEnabled)}
                  className="text-xs font-semibold text-emerald-300 hover:text-white underline"
                >
                  {alertsEnabled ? "Pause Alerts" : "Enable Alerts"}
                </button>
              </div>
            </CardContent>
          </Card>
        </div>

        {/* 3-Column Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          
          {/* Left Column - Profile & Applications */}
          <div className="space-y-8 md:col-span-1">
            <DashboardProfile user={user} profile={userProfile} />

            {/* Applications Card */}
            <Card className="shadow-md border-green-100 bg-white/95">
              <CardHeader className="pb-3">
                <CardTitle className="flex items-center gap-2 text-base font-bold text-green-950">
                  <ClipboardList className="w-5 h-5 text-green-700" />
                  My Applications
                </CardTitle>
                <CardDescription className="text-xs text-gray-500">
                  Track the submission status of your basic income programs
                </CardDescription>
              </CardHeader>
              <CardContent>
                <ApplicationsList applications={applications} />
              </CardContent>
            </Card>
          </div>

          {/* Middle Column - Available Matching Programs */}
          <div className="md:col-span-1">
            <Card className="shadow-md border-green-100 bg-white/95">
              <CardHeader className="pb-3">
                <div className="flex justify-between items-start">
                  <div>
                    <CardTitle className="flex items-center gap-2 text-base font-bold text-green-950">
                      <Star className="w-5 h-5 text-green-700" />
                      Matching UBI Programs
                    </CardTitle>
                    <CardDescription className="text-xs text-gray-500 mt-0.5">
                      Tailored to your location, demographics & favorites
                    </CardDescription>
                  </div>
                  <Link to={createPageUrl("EditProfile")}>
                    <Button
                      variant="outline"
                      className="border-green-600 text-green-700 hover:bg-green-50 text-xs h-8"
                      size="sm"
                    >
                      <Edit className="w-3.5 h-3.5 mr-1.5" />
                      Edit Filters
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
            <Card className="shadow-md border-green-100 bg-white/95">
              <CardHeader className="pb-3">
                <CardTitle className="flex items-center justify-between text-base font-bold text-green-950">
                  <div className="flex items-center gap-2">
                    <FileText className="w-5 h-5 text-green-700" />
                    Relevant Updates
                  </div>
                </CardTitle>
                <CardDescription className="text-xs text-gray-500">
                  Latest insights and news about your matched programs
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {getRelevantBlogPosts().slice(0, 4).map(post => (
                    <div 
                      key={post.id}
                      className="p-3.5 rounded-xl border border-gray-100 hover:border-green-300 hover:shadow-sm transition-all bg-white cursor-pointer"
                      onClick={() => handlePostClick(post.id)}
                    >
                      {post.image_url && (
                        <img 
                          src={post.image_url} 
                          alt={post.title}
                          className="w-full h-32 object-cover rounded-lg mb-3"
                        />
                      )}
                      <h4 className="text-sm font-bold text-green-950 mb-1 hover:text-green-700 transition-colors line-clamp-2">
                        {post.title}
                      </h4>
                      <p className="text-xs text-gray-600 line-clamp-2 mb-2">{post.summary}</p>
                      <div className="flex items-center gap-2 text-[11px] text-gray-400">
                        <Calendar className="w-3 h-3" />
                        {formatDate(post.posted_date)}
                      </div>
                    </div>
                  ))}

                  {getRelevantBlogPosts().length === 0 && (
                    <div className="text-center py-8 text-xs text-gray-400">
                      No blog updates yet for your specific criteria.
                    </div>
                  )}
                </div>
              </CardContent>
            </Card>
          </div>

        </div>
      </div>
    </div>
  );
}
