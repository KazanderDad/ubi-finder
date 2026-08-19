




import React, { useState, useEffect } from "react";
import { supabase } from "@/lib/supabaseClient";
import { useLocation, useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Separator } from "@/components/ui/separator";
import { format, parseISO } from "date-fns";
import { 
  ChevronLeft, 
  ExternalLink, 
  Calendar, 
  User as UserIcon, 
  Pencil,
  MapPin, 
  DollarSign, 
  FileText,
  Info,
  Users,
  Coins,
  Banknote,
  AlertTriangle,
  CheckCircle,
  XCircle,
  Lock
} from "lucide-react";
import { createPageUrl } from "@/utils";

export default function ProgramDetailsPage() {
  const location = useLocation();
  const navigate = useNavigate();
  const { programId } = location.state || {};
  
  const [program, setProgram] = useState(null);
  const [blogPosts, setBlogPosts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [user, setUser] = useState(null);
  const [userProfile, setUserProfile] = useState(null);
  const [canManage, setCanManage] = useState(false);

  useEffect(() => {
    window.scrollTo(0, 0);
    
    if (!programId) {
      navigate("/Programs");
      return;
    }
    
    loadData();
  }, [programId]);

  const loadData = async () => {
    try {
      // 1. Load user auth session
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
      }
      
      // 2. Load program data
      const { data: programData, error: programError } = await supabase
        .from('programs')
        .select('*')
        .eq('program_id', parseInt(programId))
        .single();
        
      if (programError || !programData) {
        console.error("Program not found:", programError);
        navigate("/Programs");
        return;
      }
      
      setProgram(programData);
      
      // 3. Load blog posts related to this program
      const { data: allPosts } = await supabase
        .from('blog_posts')
        .select('*')
        .order('posted_date', { ascending: false });
        
      const relatedPosts = (allPosts || []).filter(post => 
        post.related_programs && 
        post.related_programs.some(id => parseInt(id) === parseInt(programId))
      );
      setBlogPosts(relatedPosts);
      
      // 4. Check if user can manage this program
      if (userData) {
        const { data: managers } = await supabase
          .from('program_managers')
          .select('*')
          .eq('program_id', parseInt(programId))
          .eq('user_email', userData.email);
          
        setCanManage(managers && managers.length > 0);
        
        // Load their profile for eligibility checks
        const { data: profiles } = await supabase
          .from('user_profiles')
          .select('*')
          .eq('created_by_id', currentUser.id);
          
        if (profiles && profiles.length > 0) {
          setUserProfile(profiles[0]);
        }
      }
      
      setLoading(false);
    } catch (error) {
      console.error("Error loading program details:", error);
      setLoading(false);
    }
  };
  

  const handleSendMagicLink = async (e) => {
    e.preventDefault();
    setAuthErrorMsg("");
    setAuthSuccessMsg("");
    if (!authEmail) return;
    
    setAuthLoading(true);
    const { error } = await supabase.auth.signInWithOtp({
      email: authEmail,
    });
    setAuthLoading(false);
    
    if (error) {
      setAuthErrorMsg(error.message);
    } else {
      setAuthStep("otp");
      setAuthSuccessMsg("Verification code sent to your email.");
    }
  };

  const handleVerifyOtp = async (e) => {
    e.preventDefault();
    setAuthErrorMsg("");
    setAuthSuccessMsg("");
    if (!authOtp) return;
    
    setAuthLoading(true);
    const { data, error } = await supabase.auth.verifyOtp({
      email: authEmail,
      token: authOtp,
      type: 'email'
    });
    setAuthLoading(false);
    
    if (error) {
      setAuthErrorMsg(error.message);
    } else if (data.session) {
      setAuthSuccessMsg("Success! Unlocking details...");
      setTimeout(() => {
        window.location.reload();
      }, 1000);
    }
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
  
  // Check if user meets each eligibility requirement
  const checkGenderRequirement = () => {
    if (!program.gender_requirement || !userProfile) return true;
    return program.gender_requirement === userProfile.gender;
  };
  
  const checkLocationRequirement = () => {
    if (!program.available_regions || program.available_regions.length === 0 || !userProfile) return true;
    
    // Check if user's country is in available regions
    const inRegion = program.available_regions.includes(userProfile.country);
    
    // If state/province is required, check that too
    if (inRegion && program.required_states && program.required_states.length > 0) {
      return program.required_states.includes(userProfile.state);
    }
    
    return inRegion;
  };
  
  const checkIncomeRequirement = () => {
    if (!program.max_household_income_usd || !userProfile) return true;
    
    const getIncomeRange = (range) => {
      switch (range) {
        case "0-20k": return 20000;
        case "20k-40k": return 40000;
        case "40k-60k": return 60000;
        case "60k+": return 100000; // Assuming a high value for the highest bracket
        default: return 0;
      }
    };
    
    return getIncomeRange(userProfile.income_range) <= program.max_household_income_usd;
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-700"></div>
      </div>
    );
  }

  if (!program) {
    return (
      <div className="text-center py-12">
        <p className="text-gray-500">Program not found.</p>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-12">
      <div className="max-w-6xl mx-auto">
        <Button
          variant="ghost"
          className="mb-8 text-green-700 hover:text-green-800 hover:bg-green-50"
          onClick={() => navigate("/Programs")}
        >
          <ChevronLeft className="w-4 h-4 mr-2" />
          Back to Programs
        </Button>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Left column - Program details */}
          <div className="lg:col-span-2 space-y-8">
            <Card>
              <CardHeader className="pb-2">
                <div className="flex justify-between items-start">
                  <div>
                    <CardTitle className="text-2xl font-bold text-green-900">
                      {program.name}
                    </CardTitle>
                    <CardDescription className="text-md mt-1">
                      By {program.organization}
                    </CardDescription>
                  </div>
                  {canManage && (
                    <Button
                      variant="outline"
                      size="sm"
                      className="border-green-700 text-green-700 hover:bg-green-50"
                      onClick={() => navigate("/Manage-Program", { state: { programId: program.program_id } })}
                    >
                      <Pencil className="w-4 h-4 mr-2" />
                      Manage Program
                    </Button>
                  )}
                </div>
              </CardHeader>
              <CardContent className="space-y-6">
                {/* Status badges */}
                <div className="flex flex-wrap gap-2">
                  {/* Payout status */}
                  {program.payout_status ? (
                    <Badge className={
                      program.payout_status === 'Ongoing' ? 'bg-green-100 text-green-800' :
                      program.payout_status === 'Planned' ? 'bg-blue-100 text-blue-800' :
                      program.payout_status === 'Ended'   ? 'bg-gray-100 text-gray-800' :
                      'bg-yellow-100 text-yellow-800'
                    }>
                      Payouts: {program.payout_status}
                    </Badge>
                  ) : (
                    <Badge className={`${program.status === 'active_open' ? 'bg-green-100 text-green-800' : 
                                      program.status === 'active_closed' ? 'bg-orange-100 text-orange-800' : 
                                      program.status === 'upcoming' ? 'bg-blue-100 text-blue-800' : 
                                      'bg-gray-100 text-gray-800'}`}>
                      {program.status === 'active_open' ? 'Active • Open' : 
                       program.status === 'active_closed' ? 'Active • Closed' : 
                       program.status === 'upcoming' ? 'Upcoming' : 'Closed'}
                    </Badge>
                  )}

                  {/* Application status */}
                  {program.application_status && (
                    <Badge className={
                      program.application_status === 'Accepting applications'             ? 'bg-emerald-100 text-emerald-800' :
                      program.application_status === 'Accepting waitlist'                 ? 'bg-yellow-100 text-yellow-800' :
                      program.application_status === 'No longer accepting applications'   ? 'bg-red-100 text-red-800' :
                      'bg-slate-100 text-slate-700'
                    }>
                      {program.application_status}
                    </Badge>
                  )}
                  
                  <Badge className={program.payment_method === 'digital' 
                    ? 'bg-purple-100 text-purple-800' 
                    : 'bg-blue-100 text-blue-800'}>
                    {program.payment_method === 'digital' 
                      ? 'Digital Payment' 
                      : 'Standard Payment'}
                  </Badge>
                  
                  {!program.verified && (
                    <Badge className="bg-amber-100 text-amber-800 flex items-center gap-1">
                      <AlertTriangle className="w-3 h-3 mr-1" />
                      Not Yet Reviewed
                    </Badge>
                  )}
                </div>

                {/* Program description */}
                <div>
                  <h3 className="text-lg font-semibold text-green-900 mb-2">Description</h3>
                  <p className="text-gray-700">{program.description}</p>
                </div>

                
              <div className="relative">
                
                <Separator />

                {/* Payment details */}
                <div>
                  <div className="flex items-start justify-between mb-3">
                    <h3 className="text-lg font-semibold text-green-900">Payment Details</h3>
                    
                    {(program.apply_url || program.website) && (
                      <div className={!user ? "blur-md select-none pointer-events-none opacity-50" : ""}>
                      <Button 
                        onClick={() => window.open(program.apply_url || program.website, '_blank')}
                        variant="outline"
                        className="border-green-700 text-green-700 hover:bg-green-50"
                      >
                        <ExternalLink className="w-4 h-4 mr-2" />
                        {program.apply_url ? 'Apply / Learn More' : 'Visit Program Website'}
                      </Button>
                      </div>
                    )}
                  </div>
                  
                  <div className="bg-green-50 p-5 rounded-lg border border-green-100">
                    <div className="flex justify-between items-center">
                      <div className="flex items-center">
                        {program.payment_method === 'digital' ? (
                          <Coins className="w-8 h-8 text-purple-600 mr-3" />
                        ) : (
                          <Banknote className="w-8 h-8 text-blue-600 mr-3" />
                        )}
                        <div>
                          <h4 className="text-2xl font-bold text-green-800">
                            <span className={!user ? "blur-md select-none opacity-50" : ""}>${program.monthly_amount_usd}</span>
                          </h4>
                          <p className="text-sm text-gray-600">monthly comparison value</p>
                        </div>
                      </div>
                    </div>

                    <div className="mt-3 space-y-3">
                      <div className="p-3 bg-white rounded border border-green-100">
                        <h5 className="font-medium text-green-800 mb-1">Actual Payment Structure:</h5>
                        <p className="text-sm text-gray-700">
                          <span className={!user ? "blur-sm select-none opacity-50 block" : ""}>{program.amount_description}</span>
                        </p>
                      </div>
                      
                      <div className="p-3 bg-white rounded border border-green-100">
                        <h5 className="font-medium text-green-800 mb-1">Currency:</h5>
                        <p className="text-sm text-gray-700 flex items-center gap-2">
                          <span className="font-semibold">{program.currency}</span>
                          {program.currency !== "USD" && (
                            <span className="text-gray-500">
                              (${program.monthly_amount_usd} USD equivalent)
                            </span>
                          )}
                        </p>
                      </div>
                    </div>

                  </div>
                </div>

                <Separator />

                {/* Eligibility and Apply Now */}
                <div className="flex flex-col md:flex-row gap-6">
                  <div className="md:w-2/3 space-y-3">
                    <h3 className="text-lg font-semibold text-green-900 mb-2">Eligibility Requirements</h3>
                    
                    <div className="flex items-start gap-2">
                      <Users className="w-5 h-5 text-green-700 mt-0.5 min-w-5" />
                      <div className="flex-1">
                        <div className="flex items-center">
                          <p className="font-medium text-gray-800 mr-2">Demographics</p>
                          {userProfile && (
                            checkGenderRequirement() 
                              ? <CheckCircle className="w-4 h-4 text-green-600" />
                              : <XCircle className="w-4 h-4 text-red-600" />
                          )}
                        </div>
                        <p className="text-gray-600">
                          {program.gender_requirement 
                            ? `Open to ${program.gender_requirement} applicants only` 
                            : "Open to all genders"}
                        </p>
                      </div>
                    </div>
                    
                    <div className="flex items-start gap-2">
                      <MapPin className="w-5 h-5 text-green-700 mt-0.5 min-w-5" />
                      <div className="flex-1">
                        <div className="flex items-center">
                          <p className="font-medium text-gray-800 mr-2">Location</p>
                          {userProfile && (
                            checkLocationRequirement() 
                              ? <CheckCircle className="w-4 h-4 text-green-600" />
                              : <XCircle className="w-4 h-4 text-red-600" />
                          )}
                        </div>
                        <p className="text-gray-600">
                          {program.available_regions && program.available_regions.length > 0 
                            ? `Available in: ${program.available_regions.join(", ")}` 
                            : "Available worldwide"}
                          {program.required_states && program.required_states.length > 0 &&
                            ` (${program.required_states.join(", ")})`}
                        </p>
                      </div>
                    </div>
                    
                    <div className="flex items-start gap-2">
                      <DollarSign className="w-5 h-5 text-green-700 mt-0.5 min-w-5" />
                      <div className="flex-1">
                        <div className="flex items-center">
                          <p className="font-medium text-gray-800 mr-2">Income Limit</p>
                          {userProfile && (
                            checkIncomeRequirement() 
                              ? <CheckCircle className="w-4 h-4 text-green-600" />
                              : <XCircle className="w-4 h-4 text-red-600" />
                          )}
                        </div>
                        <p className="text-gray-600">
                          {program.max_household_income_usd
                            ? `Maximum household income: $${program.max_household_income_usd.toLocaleString()} per year`
                            : "No income limit specified"}
                        </p>
                      </div>
                    </div>
                    
                    <div className="flex items-start gap-2">
                      <Info className="w-5 h-5 text-green-700 mt-0.5 min-w-5" />
                      <div>
                        <p className="font-medium text-gray-800">Additional Requirements</p>
                        <p className="text-gray-600">
                          <span className={!user ? "blur-sm select-none opacity-50 block" : ""}>{program.eligibility}</span>
                        </p>
                      </div>
                    </div>
                  </div>
                  
                  <div className="md:w-1/3 flex flex-col justify-center items-center">
                    <div className={!user ? "blur-md select-none pointer-events-none opacity-50 w-full" : "w-full"}>
                      <Button className="bg-green-700 hover:bg-green-800 w-full py-6 text-lg">
                      Apply Now
                      <span className="block text-sm opacity-80">(Coming Soon)</span>
                    </Button>
                    </div>
                  </div>
                </div>
                  
                
              {/* Sources */}
              {program.sources && program.sources.length > 0 && (
                <div>
                  <Separator className="my-4" />
                  <h3 className="text-sm font-semibold text-gray-500 uppercase tracking-wide mb-2">Sources</h3>
                  <ul className="space-y-1">
                    {program.sources.map((src, i) => (
                      <li key={i}>
                        <a
                          href={src}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="text-sm text-green-700 hover:underline flex items-center gap-1 break-all"
                        >
                          <ExternalLink className="w-3 h-3 flex-shrink-0" />
                          {src}
                        </a>
                      </li>
                    ))}
                  </ul>
                </div>
              )}

              {!user && (
                <div className="absolute inset-0 z-10 flex flex-col items-center justify-center bg-white/40 backdrop-blur-[2px] rounded-lg p-6">
                  <div className="bg-white shadow-2xl rounded-xl p-8 max-w-md w-full border border-green-100 text-center relative overflow-hidden">
                    <div className="absolute top-0 left-0 w-full h-1 bg-green-500"></div>
                    <Lock className="w-12 h-12 text-green-600 mx-auto mb-4" />
                    <h3 className="text-2xl font-bold text-gray-900 mb-2">Unlock Full Details</h3>
                    <p className="text-gray-600 mb-6">Enter your email to instantly view payout amounts, links, and full eligibility requirements.</p>
                    
                    {authStep === 'email' ? (
                      <form onSubmit={handleSendMagicLink} className="space-y-4">
                        <Input 
                          type="email" 
                          placeholder="Your email address" 
                          value={authEmail}
                          onChange={(e) => setAuthEmail(e.target.value)}
                          required
                          className="w-full text-lg py-6"
                        />
                        {authErrorMsg && <p className="text-sm text-red-600 text-left">{authErrorMsg}</p>}
                        <Button type="submit" className="w-full py-6 text-lg bg-green-600 hover:bg-green-700" disabled={authLoading}>
                          {authLoading ? "Sending..." : "Unlock Access"}
                        </Button>
                      </form>
                    ) : (
                      <form onSubmit={handleVerifyOtp} className="space-y-4">
                        <p className="text-sm text-green-700 font-medium mb-2">{authSuccessMsg}</p>
                        <Input 
                          type="text" 
                          placeholder="6-digit code" 
                          value={authOtp}
                          onChange={(e) => setAuthOtp(e.target.value)}
                          required
                          className="w-full text-lg py-6 text-center tracking-widest"
                          maxLength={6}
                        />
                        {authErrorMsg && <p className="text-sm text-red-600 text-left">{authErrorMsg}</p>}
                        <Button type="submit" className="w-full py-6 text-lg bg-green-600 hover:bg-green-700" disabled={authLoading}>
                          {authLoading ? "Verifying..." : "Verify & View"}
                        </Button>
                        <button type="button" onClick={() => setAuthStep('email')} className="text-sm text-gray-500 hover:text-gray-700 mt-4 block w-full text-center">
                          Use a different email
                        </button>
                      </form>
                    )}
                  </div>
                </div>
              )}

              </div>
  
              </CardContent>
            </Card>
          </div>

          {/* Right column - Related blog posts */}
          <div className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <FileText className="w-5 h-5 text-green-700" />
                  Related Articles
                </CardTitle>
                <CardDescription>
                  Learn more about this program
                </CardDescription>
              </CardHeader>
              <CardContent>
                {blogPosts.length > 0 ? (
                  <div className="space-y-6">
                    {blogPosts.map(post => (
                      <div 
                        key={post.id}
                        className="cursor-pointer group"
                        onClick={() => navigate(createPageUrl("BlogPost"), { 
                          state: { postId: post.id } 
                        })}
                      >
                        {post.image_url && (
                          <img 
                            src={post.image_url} 
                            alt={post.title}
                            className="w-full h-32 object-cover rounded-lg mb-3"
                          />
                        )}
                        <h3 className="text-lg font-semibold text-green-900 group-hover:text-green-700 transition-colors">
                          {post.title}
                        </h3>
                        <div className="flex items-center gap-4 text-sm text-gray-600 mb-2">
                          <div className="flex items-center gap-1">
                            <Calendar className="w-4 h-4" />
                            {formatDate(post.posted_date)}
                          </div>
                          <div className="flex items-center gap-1">
                            <UserIcon className="w-4 h-4" />
                            {post.author}
                          </div>
                        </div>
                        <p className="text-sm text-gray-700 line-clamp-2">{post.summary}</p>
                      </div>
                    ))}
                  </div>
                ) : (
                  <div className="text-center py-6">
                    <FileText className="w-12 h-12 text-gray-300 mx-auto mb-3" />
                    <p className="text-gray-500">No articles available for this program yet</p>
                  </div>
                )}
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  );
}


