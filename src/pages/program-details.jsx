import React, { useState, useEffect } from "react";
import { supabase } from "@/lib/supabaseClient";
import { useLocation, useNavigate, Link } from "react-router-dom";
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
  Lock,
  Share2,
  Check
} from "lucide-react";
import { createPageUrl } from "@/utils";
import { Helmet } from "react-helmet-async";

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
  const [copied, setCopied] = useState(false);

  // Auth gate states
  const [authStep, setAuthStep] = useState('email');
  const [authEmail, setAuthEmail] = useState('');
  const [authOtp, setAuthOtp] = useState('');
  const [authLoading, setAuthLoading] = useState(false);
  const [authErrorMsg, setAuthErrorMsg] = useState('');
  const [authSuccessMsg, setAuthSuccessMsg] = useState('');

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
      if (userData && currentUser) {
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

  const handleShare = () => {
    navigator.clipboard.writeText(window.location.href);
    setCopied(true);
    setTimeout(() => setCopied(false), 2500);
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
    
    const inRegion = program.available_regions.includes(userProfile.country) || program.available_regions.includes("Global") || program.available_regions.includes("Worldwide");
    
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
        case "60k+": return 100000;
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

  const programSchema = {
    "@context": "https://schema.org",
    "@type": "FinancialProduct",
    "name": program.name,
    "description": program.description,
    "provider": {
      "@type": "Organization",
      "name": program.organization
    },
    "amount": {
      "@type": "MonetaryAmount",
      "currency": program.currency || "USD",
      "value": program.monthly_amount_usd
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-10 pb-24 md:pb-12">
      <Helmet>
        <title>{`${program.name} — Basic Income & Payout Details | UBI Finder`}</title>
        <meta name="description" content={`Learn about ${program.name} by ${program.organization}. Estimated monthly support: $${program.monthly_amount_usd} ${program.currency}. Check eligibility requirements and how to apply.`} />
        <script type="application/ld+json">
          {JSON.stringify(programSchema)}
        </script>
      </Helmet>
      <div className="max-w-6xl mx-auto">
        
        {/* 9c: Breadcrumbs */}
        <div className="flex items-center gap-2 text-xs text-gray-500 mb-6">
          <Link to="/" className="hover:text-green-700 transition-colors">Home</Link>
          <span>/</span>
          <Link to="/Programs" className="hover:text-green-700 transition-colors">Programs</Link>
          <span>/</span>
          <span className="text-gray-800 font-semibold truncate max-w-xs">{program.name}</span>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Left column - Program details */}
          <div className="lg:col-span-2 space-y-8">
            <Card className="shadow-lg border-green-100 bg-white/95 backdrop-blur-sm">
              <CardHeader className="pb-4">
                <div className="flex justify-between items-start gap-4">
                  <div>
                    <CardTitle className="text-2xl md:text-3xl font-bold text-green-950">
                      {program.name}
                    </CardTitle>
                    <CardDescription className="text-base mt-1 text-gray-600">
                      Organized by <span className="font-medium text-gray-800">{program.organization}</span>
                    </CardDescription>
                  </div>
                  
                  {/* Action buttons (Share + Manage) */}
                  <div className="flex items-center gap-2 flex-shrink-0">
                    {/* 4c. Share button */}
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={handleShare}
                      className="border-gray-200 hover:bg-green-50 text-gray-700 hover:text-green-800 text-xs flex items-center gap-1.5"
                    >
                      {copied ? (
                        <>
                          <Check className="w-3.5 h-3.5 text-green-600" />
                          <span className="text-green-700 font-medium">Copied!</span>
                        </>
                      ) : (
                        <>
                          <Share2 className="w-3.5 h-3.5" />
                          <span>Share</span>
                        </>
                      )}
                    </Button>

                    {canManage && (
                      <Button
                        variant="outline"
                        size="sm"
                        className="border-green-700 text-green-700 hover:bg-green-50 text-xs"
                        onClick={() => navigate("/Manage-Program", { state: { programId: program.program_id } })}
                      >
                        <Pencil className="w-3.5 h-3.5 mr-1" />
                        Manage
                      </Button>
                    )}
                  </div>
                </div>
              </CardHeader>
              <CardContent className="space-y-6">
                {/* Status badges */}
                <div className="flex flex-wrap gap-2">
                  {/* Payout status */}
                  {program.payout_status ? (
                    <Badge className={
                      program.payout_status === 'Ongoing' ? 'bg-green-100 text-green-800 border-green-200' :
                      program.payout_status === 'Planned' ? 'bg-blue-100 text-blue-800 border-blue-200' :
                      program.payout_status === 'Ended'   ? 'bg-gray-100 text-gray-800 border-gray-200' :
                      'bg-yellow-100 text-yellow-800 border-yellow-200'
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
                      program.application_status === 'Accepting applications'             ? 'bg-emerald-100 text-emerald-900 border-emerald-200' :
                      program.application_status === 'Accepting waitlist'                 ? 'bg-amber-100 text-amber-900 border-amber-200' :
                      program.application_status === 'No longer accepting applications'   ? 'bg-red-100 text-red-800 border-red-200' :
                      'bg-slate-100 text-slate-700'
                    }>
                      {program.application_status}
                    </Badge>
                  )}
                  
                  <Badge className={program.payment_method === 'digital' 
                    ? 'bg-purple-100 text-purple-800 border-purple-200' 
                    : 'bg-blue-100 text-blue-800 border-blue-200'}>
                    {program.payment_method === 'digital' 
                      ? 'Digital / Crypto Payment' 
                      : 'Standard Bank Payout'}
                  </Badge>
                  
                  {!program.verified && (
                    <Badge className="bg-amber-100 text-amber-800 flex items-center gap-1">
                      <AlertTriangle className="w-3 h-3 mr-1" />
                      Under Review
                    </Badge>
                  )}
                </div>

                {/* Program description */}
                <div>
                  <h3 className="text-lg font-semibold text-green-950 mb-2">About This Program</h3>
                  <p className="text-gray-700 leading-relaxed">{program.description}</p>
                </div>

                <div className="relative">
                  <Separator className="my-6" />

                  {/* Payment details */}
                  <div>
                    <div className="flex items-start justify-between mb-4">
                      <h3 className="text-lg font-semibold text-green-950">Disbursement & Terms</h3>
                      
                      {(program.apply_url || program.website) && (
                        <div className={!user ? "blur-md select-none pointer-events-none opacity-50" : ""}>
                          <Button 
                            onClick={() => window.open(program.apply_url || program.website, '_blank')}
                            variant="outline"
                            className="border-green-700 text-green-700 hover:bg-green-50 shadow-sm"
                          >
                            <ExternalLink className="w-4 h-4 mr-2" />
                            {program.apply_url ? 'Apply / Learn More' : 'Visit Program Website'}
                          </Button>
                        </div>
                      )}
                    </div>
                    
                    <div className="bg-green-50/80 p-5 rounded-2xl border border-green-200/80 space-y-4">
                      <div className="flex items-center justify-between">
                        <div className="flex items-center">
                          {program.payment_method === 'digital' ? (
                            <div className="w-12 h-12 bg-purple-100 text-purple-700 rounded-xl flex items-center justify-center mr-4">
                              <Coins className="w-6 h-6" />
                            </div>
                          ) : (
                            <div className="w-12 h-12 bg-green-100 text-green-700 rounded-xl flex items-center justify-center mr-4">
                              <Banknote className="w-6 h-6" />
                            </div>
                          )}
                          <div>
                            <div className="text-xs text-gray-500 font-medium">Monthly Valuation</div>
                            <h4 className="text-3xl font-extrabold text-green-950">
                              <span className={!user ? "blur-md select-none opacity-50" : ""}>${program.monthly_amount_usd}</span>
                              <span className="text-xs font-normal text-gray-600 ml-1.5">{program.currency || 'USD'}</span>
                            </h4>
                          </div>
                        </div>
                      </div>

                      <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 pt-2">
                        <div className="p-3.5 bg-white/90 rounded-xl border border-green-100">
                          <div className="text-xs font-semibold text-green-800 mb-1">Disbursement Schedule</div>
                          <p className="text-sm text-gray-700">
                            <span className={!user ? "blur-sm select-none opacity-50 block" : ""}>{program.amount_description}</span>
                          </p>
                        </div>
                        
                        <div className="p-3.5 bg-white/90 rounded-xl border border-green-100">
                          <div className="text-xs font-semibold text-green-800 mb-1">Native Currency</div>
                          <p className="text-sm text-gray-700 font-medium">
                            {program.currency}
                            {program.currency !== "USD" && (
                              <span className="text-xs font-normal text-gray-500 ml-1.5">
                                (${program.monthly_amount_usd} USD equivalent)
                              </span>
                            )}
                          </p>
                        </div>
                      </div>
                    </div>
                  </div>

                  <Separator className="my-6" />

                  {/* 4b. Eligibility checklist with visual feedback */}
                  <div className="space-y-4">
                    <h3 className="text-lg font-semibold text-green-950">Eligibility & Qualifications</h3>
                    
                    <div className="grid grid-cols-1 gap-3">
                      {/* Location check */}
                      <div className="p-3.5 bg-gray-50/80 rounded-xl border border-gray-200/80 flex items-start gap-3">
                        <MapPin className="w-5 h-5 text-green-700 mt-0.5 flex-shrink-0" />
                        <div className="flex-1">
                          <div className="flex items-center justify-between">
                            <p className="font-semibold text-gray-900 text-sm">Geographic Eligibility</p>
                            {userProfile && (
                              checkLocationRequirement() 
                                ? <span className="inline-flex items-center gap-1 text-xs text-green-700 bg-green-100 px-2 py-0.5 rounded-full font-medium"><CheckCircle className="w-3.5 h-3.5" /> Matches You</span>
                                : <span className="inline-flex items-center gap-1 text-xs text-red-700 bg-red-100 px-2 py-0.5 rounded-full font-medium"><XCircle className="w-3.5 h-3.5" /> Region Mismatch</span>
                            )}
                          </div>
                          <p className="text-xs text-gray-600 mt-0.5">
                            {program.available_regions && program.available_regions.length > 0 
                              ? `Open to residents of: ${program.available_regions.join(", ")}` 
                              : "Open to international applicants worldwide"}
                            {program.required_states && program.required_states.length > 0 &&
                              ` (${program.required_states.join(", ")})`}
                          </p>
                        </div>
                      </div>

                      {/* Income limit check */}
                      <div className="p-3.5 bg-gray-50/80 rounded-xl border border-gray-200/80 flex items-start gap-3">
                        <DollarSign className="w-5 h-5 text-green-700 mt-0.5 flex-shrink-0" />
                        <div className="flex-1">
                          <div className="flex items-center justify-between">
                            <p className="font-semibold text-gray-900 text-sm">Income Threshold</p>
                            {userProfile && (
                              checkIncomeRequirement() 
                                ? <span className="inline-flex items-center gap-1 text-xs text-green-700 bg-green-100 px-2 py-0.5 rounded-full font-medium"><CheckCircle className="w-3.5 h-3.5" /> Within Limit</span>
                                : <span className="inline-flex items-center gap-1 text-xs text-red-700 bg-red-100 px-2 py-0.5 rounded-full font-medium"><XCircle className="w-3.5 h-3.5" /> Income Exceeds Limit</span>
                            )}
                          </div>
                          <p className="text-xs text-gray-600 mt-0.5">
                            {program.max_household_income_usd
                              ? `Maximum household income: $${program.max_household_income_usd.toLocaleString()} per year`
                              : "No income restrictions or means test required"}
                          </p>
                        </div>
                      </div>

                      {/* Gender requirement */}
                      <div className="p-3.5 bg-gray-50/80 rounded-xl border border-gray-200/80 flex items-start gap-3">
                        <Users className="w-5 h-5 text-green-700 mt-0.5 flex-shrink-0" />
                        <div className="flex-1">
                          <div className="flex items-center justify-between">
                            <p className="font-semibold text-gray-900 text-sm">Demographics</p>
                            {userProfile && (
                              checkGenderRequirement() 
                                ? <span className="inline-flex items-center gap-1 text-xs text-green-700 bg-green-100 px-2 py-0.5 rounded-full font-medium"><CheckCircle className="w-3.5 h-3.5" /> Eligible</span>
                                : <span className="inline-flex items-center gap-1 text-xs text-red-700 bg-red-100 px-2 py-0.5 rounded-full font-medium"><XCircle className="w-3.5 h-3.5" /> Does Not Match</span>
                            )}
                          </div>
                          <p className="text-xs text-gray-600 mt-0.5">
                            {program.gender_requirement 
                              ? `Dedicated to ${program.gender_requirement} applicants` 
                              : "Open to all qualifying applicants regardless of gender"}
                          </p>
                        </div>
                      </div>

                      {/* Additional criteria */}
                      {program.eligibility && (
                        <div className="p-3.5 bg-gray-50/80 rounded-xl border border-gray-200/80 flex items-start gap-3">
                          <Info className="w-5 h-5 text-green-700 mt-0.5 flex-shrink-0" />
                          <div className="flex-1">
                            <p className="font-semibold text-gray-900 text-sm">Additional Criteria</p>
                            <p className="text-xs text-gray-600 mt-0.5">
                              <span className={!user ? "blur-sm select-none opacity-50 block" : ""}>{program.eligibility}</span>
                            </p>
                          </div>
                        </div>
                      )}
                    </div>
                  </div>
                    
                  {/* Sources & 4d Report Outdated Link */}
                  {program.sources && program.sources.length > 0 && (
                    <div className="mt-8">
                      <Separator className="my-4" />
                      <h3 className="text-xs font-bold text-gray-500 uppercase tracking-wider mb-2">Verified Sources</h3>
                      <ul className="space-y-1.5">
                        {program.sources.map((src, i) => (
                          <li key={i}>
                            <a
                              href={src}
                              target="_blank"
                              rel="noopener noreferrer"
                              className="text-xs text-green-700 hover:underline flex items-center gap-1.5 break-all"
                            >
                              <ExternalLink className="w-3 h-3 flex-shrink-0" />
                              {src}
                            </a>
                          </li>
                        ))}
                      </ul>

                      {/* 4d: Report outdated link */}
                      <div className="mt-3 pt-3 border-t border-gray-100 flex items-center justify-between text-xs text-gray-500">
                        <span>Notice an error or outdated link?</span>
                        <a 
                          href={`mailto:updates@ubifinder.org?subject=Update%20Report%20for%20${encodeURIComponent(program.name)}`}
                          className="text-green-700 hover:underline font-medium flex items-center gap-1"
                        >
                          Report an update &rarr;
                        </a>
                      </div>
                    </div>
                  )}

                  {!user && (
                    <div className="absolute inset-0 z-10 flex flex-col items-center justify-center bg-white/40 backdrop-blur-[2px] rounded-2xl p-6">
                      <div className="bg-white shadow-2xl rounded-2xl p-8 max-w-md w-full border border-green-100 text-center relative overflow-hidden">
                        <div className="absolute top-0 left-0 w-full h-1 bg-green-500"></div>
                        <Lock className="w-12 h-12 text-green-600 mx-auto mb-4" />
                        <h3 className="text-2xl font-bold text-gray-900 mb-2">Unlock Full Details</h3>
                        <p className="text-gray-600 mb-6 text-sm leading-relaxed">
                          Enter your email to instantly view payout amounts, direct application links, and your personalized eligibility report.
                        </p>
                        
                        {authStep === 'email' ? (
                          <form onSubmit={handleSendMagicLink} className="space-y-4">
                            <Input 
                              type="email" 
                              placeholder="Your email address" 
                              value={authEmail}
                              onChange={(e) => setAuthEmail(e.target.value)}
                              required
                              className="w-full text-base py-5"
                            />
                            {authErrorMsg && <p className="text-xs text-red-600 text-left">{authErrorMsg}</p>}
                            <Button type="submit" className="w-full py-5 text-base bg-green-700 hover:bg-green-800 text-white font-semibold" disabled={authLoading}>
                              {authLoading ? "Sending..." : "Unlock Access"}
                            </Button>
                          </form>
                        ) : (
                          <form onSubmit={handleVerifyOtp} className="space-y-4">
                            <p className="text-xs text-green-700 font-medium mb-2">{authSuccessMsg}</p>
                            <Input 
                              type="text" 
                              placeholder="6-digit code" 
                              value={authOtp}
                              onChange={(e) => setAuthOtp(e.target.value)}
                              required
                              className="w-full text-lg py-5 text-center tracking-widest"
                              maxLength={6}
                            />
                            {authErrorMsg && <p className="text-xs text-red-600 text-left">{authErrorMsg}</p>}
                            <Button type="submit" className="w-full py-5 text-base bg-green-700 hover:bg-green-800 text-white font-semibold" disabled={authLoading}>
                              {authLoading ? "Verifying..." : "Verify & View"}
                            </Button>
                            <button type="button" onClick={() => setAuthStep('email')} className="text-xs text-gray-500 hover:text-gray-700 mt-3 block w-full text-center">
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

          {/* Right column - Quick facts summary & Related blog posts */}
          <div className="space-y-6">
            {/* Quick summary card with prominent apply CTA (4a desktop) */}
            <Card className="shadow-lg border-green-100 bg-white/95 backdrop-blur-sm sticky top-24">
              <CardHeader className="pb-3">
                <CardTitle className="text-lg font-bold text-green-950">Program Summary</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4 text-sm">
                <div className="bg-green-50/90 p-4 rounded-xl border border-green-100 text-center">
                  <div className="text-xs font-semibold text-green-800 uppercase tracking-wider">Estimated Monthly Value</div>
                  <div className="text-3xl font-extrabold text-green-950 mt-1">
                    ${Number(program.monthly_amount_usd || 0).toLocaleString()} <span className="text-xs font-normal text-gray-600">{program.currency}</span>
                  </div>
                </div>

                <div className="space-y-2 pt-1 text-xs text-gray-600">
                  <div className="flex justify-between py-1 border-b border-gray-100">
                    <span className="text-gray-500">Status</span>
                    <span className="font-semibold text-gray-900">{program.application_status || program.status || "Active"}</span>
                  </div>
                  <div className="flex justify-between py-1 border-b border-gray-100">
                    <span className="text-gray-500">Type</span>
                    <span className="font-semibold text-gray-900">{program.payment_method === 'digital' ? 'Crypto / Digital' : 'Bank Transfer'}</span>
                  </div>
                  <div className="flex justify-between py-1 border-b border-gray-100">
                    <span className="text-gray-500">Regions</span>
                    <span className="font-semibold text-gray-900 truncate max-w-[140px]">
                      {program.available_regions?.length > 0 ? program.available_regions.join(", ") : "Global"}
                    </span>
                  </div>
                </div>

                {(program.apply_url || program.website) && (
                  <Button 
                    onClick={() => window.open(program.apply_url || program.website, '_blank')}
                    className="w-full bg-green-700 hover:bg-green-800 text-white font-semibold py-3 shadow-md"
                  >
                    <ExternalLink className="w-4 h-4 mr-2" />
                    {program.apply_url ? 'Apply / Learn More' : 'Visit Official Site'}
                  </Button>
                )}
              </CardContent>
            </Card>

            {/* Related Articles */}
            <Card className="shadow-lg border-green-100 bg-white/95 backdrop-blur-sm">
              <CardHeader className="pb-3">
                <CardTitle className="flex items-center gap-2 text-base font-bold text-green-950">
                  <FileText className="w-4 h-4 text-green-700" />
                  Related Insights
                </CardTitle>
              </CardHeader>
              <CardContent>
                {blogPosts.length > 0 ? (
                  <div className="space-y-4">
                    {blogPosts.map(post => (
                      <div 
                        key={post.id}
                        className="cursor-pointer group p-2.5 rounded-lg hover:bg-green-50/50 transition-colors"
                        onClick={() => navigate(createPageUrl("BlogPost"), { 
                          state: { postId: post.id } 
                        })}
                      >
                        {post.image_url && (
                          <img 
                            src={post.image_url} 
                            alt={post.title}
                            className="w-full h-24 object-cover rounded-lg mb-2"
                          />
                        )}
                        <h4 className="text-sm font-semibold text-green-950 group-hover:text-green-700 transition-colors line-clamp-2">
                          {post.title}
                        </h4>
                        <div className="flex items-center gap-3 text-[11px] text-gray-500 mt-1">
                          <span>{formatDate(post.posted_date)}</span>
                          <span>&bull;</span>
                          <span>{post.author}</span>
                        </div>
                      </div>
                    ))}
                  </div>
                ) : (
                  <div className="text-center py-6">
                    <FileText className="w-8 h-8 text-gray-300 mx-auto mb-2" />
                    <p className="text-xs text-gray-500">No articles for this program yet</p>
                  </div>
                )}
              </CardContent>
            </Card>
          </div>
        </div>
      </div>

      {/* 4a. Sticky floating bottom CTA for Mobile */}
      {(program.apply_url || program.website) && (
        <div className="lg:hidden fixed bottom-0 left-0 right-0 p-3 bg-white/95 backdrop-blur-md border-t border-gray-200 shadow-2xl z-40 flex items-center justify-between gap-3">
          <div>
            <div className="text-[10px] text-gray-500 uppercase tracking-wider font-semibold">Monthly</div>
            <div className="text-base font-extrabold text-green-950">
              ${Number(program.monthly_amount_usd || 0).toLocaleString()} <span className="text-[11px] font-normal text-gray-600">{program.currency}</span>
            </div>
          </div>
          <Button
            onClick={() => window.open(program.apply_url || program.website, '_blank')}
            className="bg-green-700 hover:bg-green-800 text-white font-semibold text-xs px-4 py-2.5 shadow-md flex-1 max-w-[200px]"
          >
            <ExternalLink className="w-3.5 h-3.5 mr-1.5" />
            {program.apply_url ? "Apply Now" : "Official Site"}
          </Button>
        </div>
      )}
    </div>
  );
}
