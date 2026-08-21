import React, { useState, useEffect } from "react";
import { supabase } from "@/lib/supabaseClient";
import { useAuth } from "@/lib/AuthContext";
import { 
  Sparkles, 
  Printer, 
  Share2, 
  ArrowRight, 
  CheckCircle2, 
  XCircle, 
  AlertCircle, 
  Coins, 
  Banknote, 
  ExternalLink, 
  MapPin, 
  User, 
  DollarSign, 
  Filter, 
  RefreshCw, 
  Bell, 
  ShieldCheck, 
  Check, 
  ChevronDown, 
  ChevronUp, 
  Info,
  Clock,
  Zap
} from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Link, useNavigate } from "react-router-dom";
import { Helmet } from "react-helmet-async";
import { generateUserMatchReport, TIERS, isProfileComplete } from "@/lib/matchingEngine";
import { syncMatchSnapshotAndDetectDeltas } from "@/lib/matchDeltaService";
import UserForm from "@/components/UserForm";

export default function MyReport() {
  const { user, isAuthenticated } = useAuth();
  const navigate = useNavigate();

  const [profile, setProfile] = useState(null);
  const [allPrograms, setAllPrograms] = useState([]);
  const [report, setReport] = useState(null);
  const [deltas, setDeltas] = useState([]);
  const [loading, setLoading] = useState(true);
  const [activeTier, setActiveTier] = useState("all");
  const [expandedDiagnostics, setExpandedDiagnostics] = useState({});
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    loadReportData();
  }, [user]);

  const loadReportData = async () => {
    setLoading(true);
    try {
      // 1. Fetch user profile from Supabase or localStorage fallback
      let userProfile = null;
      if (user?.email) {
        const { data: profiles } = await supabase
          .from("user_profiles")
          .select("*")
          .eq("created_by", user.email)
          .order("created_date", { ascending: false })
          .limit(1);

        if (profiles && profiles.length > 0) {
          userProfile = profiles[0];
        }
      }

      if (!userProfile && user?.id) {
        const { data: profiles } = await supabase
          .from("user_profiles")
          .select("*")
          .eq("created_by_id", user.id)
          .order("created_date", { ascending: false })
          .limit(1);

        if (profiles && profiles.length > 0) {
          userProfile = profiles[0];
        }
      }

      const pending = localStorage.getItem("pendingProfile");
      if (pending) {
        try {
          const parsedPending = JSON.parse(pending);
          userProfile = { ...(userProfile || {}), ...parsedPending };
        } catch (e) {
          console.warn("Could not parse pending profile:", e);
        }
      }

      setProfile(userProfile);

      // 2. Fetch all programs
      const { data: progs } = await supabase
        .from("programs")
        .select("*")
        .neq("internal_status", "deleted");

      const programsList = progs || [];
      setAllPrograms(programsList);

      // 3. Generate matches & compute snapshot deltas
      if (programsList.length > 0) {
        const deltaResult = await syncMatchSnapshotAndDetectDeltas(user, userProfile, programsList);
        if (deltaResult) {
          setReport(deltaResult.currentReport);
          setDeltas(deltaResult.deltas || []);
        } else {
          setReport(generateUserMatchReport(userProfile, programsList));
        }
      }
    } catch (err) {
      console.error("Error generating customized UBI report:", err);
    } finally {
      setLoading(false);
    }
  };

  const toggleDiagnostic = (progId) => {
    setExpandedDiagnostics(prev => ({
      ...prev,
      [progId]: !prev[progId]
    }));
  };

  const handleShareReport = () => {
    if (navigator.clipboard) {
      navigator.clipboard.writeText(window.location.href);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    }
  };

  const handlePrint = () => {
    window.print();
  };

  const filteredMatches = (report?.rankedMatches || []).filter(prog => {
    if (activeTier === "all") return true;
    return prog.tier === activeTier;
  });

  if (loading) {
    return (
      <div className="min-h-screen flex flex-col items-center justify-center bg-gradient-to-b from-green-50 to-white">
        <div className="w-12 h-12 border-4 border-green-200 border-t-green-700 rounded-full animate-spin mb-4"></div>
        <p className="text-sm font-semibold text-green-950">Calculating your personalized UBI matches & ranking...</p>
      </div>
    );
  }

  // Force users to complete the form before seeing the personalized report
  if (!isProfileComplete(profile)) {
    return (
      <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-8 md:py-12">
        <Helmet>
          <title>Complete Your Profile | UBI Finder</title>
          <meta name="description" content="Complete your profile to generate your customized Universal Basic Income qualification report." />
        </Helmet>
        <div className="max-w-2xl mx-auto space-y-6">
          <div className="text-center space-y-2">
            <div className="inline-flex items-center gap-1.5 px-3 py-1 bg-emerald-100 border border-emerald-200 rounded-full text-xs font-bold text-emerald-800 shadow-xs">
              <Sparkles className="w-3.5 h-3.5 text-emerald-700" />
              1 Quick Step to Unlock Your Report
            </div>
            <h1 className="text-3xl font-extrabold text-green-950 tracking-tight">
              Complete Your Profile
            </h1>
            <p className="text-sm text-gray-600 max-w-lg mx-auto leading-relaxed">
              To calculate your true qualification matches and prevent incorrect eligibility results, please complete your household and location details below.
            </p>
          </div>

          <UserForm 
            onComplete={(savedProfile) => {
              setProfile(savedProfile);
              loadReportData();
            }}
            initialData={profile}
            isMandatoryModal={true}
          />
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-8 md:py-12 print:bg-white print:p-0">
      <Helmet>
        <title>Personalized UBI Match Report | UBI Finder</title>
        <meta name="description" content="Your custom Universal Basic Income qualification report, ranking verified cash disbursements, Web3 daily claim protocols, and regional pilots." />
      </Helmet>

      <div className="max-w-6xl mx-auto space-y-8">
        
        {/* Top Action Bar (hidden in print) */}
        <div className="flex flex-wrap items-center justify-between gap-4 print:hidden">
          <div className="flex items-center gap-2 text-xs text-gray-500">
            <Link to="/" className="hover:text-green-700">Home</Link>
            <span>/</span>
            <Link to="/Dashboard" className="hover:text-green-700">Dashboard</Link>
            <span>/</span>
            <span className="font-semibold text-gray-900">Custom Match Report</span>
          </div>

          <div className="flex items-center gap-2">
            <Button
              variant="outline"
              size="sm"
              onClick={handlePrint}
              className="border-gray-300 text-gray-700 hover:bg-gray-100 text-xs flex items-center gap-1.5 shadow-sm"
            >
              <Printer className="w-3.5 h-3.5" />
              <span>Print / Save PDF</span>
            </Button>

            <Button
              variant="outline"
              size="sm"
              onClick={handleShareReport}
              className="border-gray-300 text-gray-700 hover:bg-gray-100 text-xs flex items-center gap-1.5 shadow-sm"
            >
              {copied ? <Check className="w-3.5 h-3.5 text-green-600" /> : <Share2 className="w-3.5 h-3.5" />}
              <span>{copied ? "Link Copied!" : "Share Report"}</span>
            </Button>

            <Button
              variant="outline"
              size="sm"
              onClick={loadReportData}
              className="border-green-700 text-green-700 hover:bg-green-50 text-xs flex items-center gap-1.5"
            >
              <RefreshCw className="w-3.5 h-3.5" />
              <span>Re-Calculate</span>
            </Button>
          </div>
        </div>

        {/* Dynamic Delta Notification Banner */}
        {deltas.length > 0 && (
          <div className="p-4 bg-emerald-50 border border-emerald-200 rounded-2xl flex items-start gap-3 print:hidden shadow-sm animate-in fade-in">
            <Bell className="w-5 h-5 text-emerald-700 mt-0.5 flex-shrink-0" />
            <div className="flex-1 text-xs text-emerald-950">
              <span className="font-bold text-sm block mb-1">
                Updates Detected Since Your Previous Visit ({deltas.length})
              </span>
              <ul className="list-disc pl-4 space-y-1 text-emerald-900">
                {deltas.map((d, idx) => (
                  <li key={idx}><strong>{d.programName}:</strong> {d.message}</li>
                ))}
              </ul>
            </div>
          </div>
        )}

        {/* Executive Header Banner */}
        <div className="bg-gradient-to-br from-green-900 via-green-800 to-emerald-950 text-white rounded-3xl p-6 md:p-10 shadow-xl relative overflow-hidden">
          <div className="relative z-10 space-y-6">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 border-b border-green-700/60 pb-6">
              <div>
                <div className="inline-flex items-center gap-1.5 px-3 py-1 bg-green-700/60 rounded-full text-xs font-semibold text-green-200 mb-2">
                  <Sparkles className="w-3.5 h-3.5 text-yellow-300" />
                  Verified Custom Qualification Report
                </div>
                <h1 className="text-3xl md:text-4xl font-black tracking-tight text-white">
                  Personalized UBI Income Portfolio
                </h1>
                <p className="text-green-100 text-xs md:text-sm mt-1">
                  Prepared for: <span className="font-semibold text-white">{profile?.name || user?.email || "Applicant"}</span> &bull; Location: <span className="font-semibold text-white">{profile?.municipality ? `${profile.municipality}, ` : ""}{profile?.state ? `${profile.state}, ` : ""}{profile?.country || "Global"}</span>
                </p>
              </div>

              <div className="flex flex-col items-start md:items-end">
                <span className="text-[11px] uppercase tracking-wider text-green-300 font-bold">Report Status</span>
                <div className="flex items-center gap-1.5 text-sm font-bold text-white mt-0.5">
                  <ShieldCheck className="w-4 h-4 text-green-400" />
                  <span>Dynamic Snapshot Verified</span>
                </div>
              </div>
            </div>

            {/* Key KPI Metrics Cards */}
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4 pt-2">
              <div className="bg-white/10 backdrop-blur-md rounded-2xl p-4 border border-white/10">
                <span className="text-[11px] font-bold uppercase tracking-wider text-green-200 block mb-1">
                  Potential Monthly Floor
                </span>
                <div className="text-2xl md:text-3xl font-black text-yellow-300">
                  ${report?.totalPotentialMonthlyUsd?.toLocaleString() || 0}
                  <span className="text-xs font-normal text-white ml-1">USD/mo</span>
                </div>
              </div>

              <div className="bg-white/10 backdrop-blur-md rounded-2xl p-4 border border-white/10">
                <span className="text-[11px] font-bold uppercase tracking-wider text-green-200 block mb-1">
                  Total Eligible Matches
                </span>
                <div className="text-2xl md:text-3xl font-black text-white">
                  {report?.totalEligibleCount || 0}
                  <span className="text-xs font-normal text-green-200 ml-1">programs</span>
                </div>
              </div>

              <div className="bg-white/10 backdrop-blur-md rounded-2xl p-4 border border-white/10">
                <span className="text-[11px] font-bold uppercase tracking-wider text-green-200 block mb-1">
                  Avg Match Confidence
                </span>
                <div className="text-2xl md:text-3xl font-black text-emerald-300">
                  {report?.averageScore || 0}%
                  <span className="text-xs font-normal text-white ml-1">fit</span>
                </div>
              </div>

              <div className="bg-white/10 backdrop-blur-md rounded-2xl p-4 border border-white/10">
                <span className="text-[11px] font-bold uppercase tracking-wider text-green-200 block mb-1">
                  Web3 Daily Claim Protocols
                </span>
                <div className="text-2xl md:text-3xl font-black text-purple-200">
                  {report?.tierSummary?.tier_2_daily_claim?.length || 0}
                  <span className="text-xs font-normal text-white ml-1">active</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Interactive Tier Filter Pills */}
        <div className="flex items-center gap-2 overflow-x-auto pb-2 print:hidden">
          <Button
            size="sm"
            variant={activeTier === "all" ? "default" : "outline"}
            onClick={() => setActiveTier("all")}
            className={activeTier === "all" ? "bg-green-800 text-white" : "border-gray-300 text-gray-700"}
          >
            All Matches ({report?.rankedMatches?.length || 0})
          </Button>

          <Button
            size="sm"
            variant={activeTier === TIERS.TIER_1_GUARANTEED ? "default" : "outline"}
            onClick={() => setActiveTier(TIERS.TIER_1_GUARANTEED)}
            className={activeTier === TIERS.TIER_1_GUARANTEED ? "bg-green-700 text-white" : "border-green-200 text-green-800 bg-green-50"}
          >
            🟢 Guaranteed Monthly ({report?.tierSummary?.tier_1_guaranteed?.length || 0})
          </Button>

          <Button
            size="sm"
            variant={activeTier === TIERS.TIER_2_DAILY_CLAIM ? "default" : "outline"}
            onClick={() => setActiveTier(TIERS.TIER_2_DAILY_CLAIM)}
            className={activeTier === TIERS.TIER_2_DAILY_CLAIM ? "bg-purple-700 text-white" : "border-purple-200 text-purple-800 bg-purple-50"}
          >
            🟣 Daily Claim Protocols ({report?.tierSummary?.tier_2_daily_claim?.length || 0})
          </Button>

          <Button
            size="sm"
            variant={activeTier === TIERS.TIER_3_LOTTERY ? "default" : "outline"}
            onClick={() => setActiveTier(TIERS.TIER_3_LOTTERY)}
            className={activeTier === TIERS.TIER_3_LOTTERY ? "bg-amber-700 text-white" : "border-amber-200 text-amber-800 bg-amber-50"}
          >
            🎁 Lotteries & Raffles ({report?.tierSummary?.tier_3_lottery?.length || 0})
          </Button>

          <Button
            size="sm"
            variant={activeTier === TIERS.TIER_4_WAITLIST ? "default" : "outline"}
            onClick={() => setActiveTier(TIERS.TIER_4_WAITLIST)}
            className={activeTier === TIERS.TIER_4_WAITLIST ? "bg-blue-700 text-white" : "border-blue-200 text-blue-800 bg-blue-50"}
          >
            ⏳ Waitlist / Upcoming ({report?.tierSummary?.tier_4_waitlist?.length || 0})
          </Button>
        </div>

        {/* Ranked Custom Program Cards */}
        <div className="space-y-4">
          <div className="flex items-center justify-between">
            <h2 className="text-xl font-bold text-green-950">
              Ranked Recommended Opportunities
            </h2>
            <span className="text-xs text-gray-500 font-medium">
              Sorted by Match Confidence & Monthly Cash Value
            </span>
          </div>

          {filteredMatches.length === 0 ? (
            <Card className="border-dashed border-gray-300 p-8 text-center bg-gray-50">
              <p className="text-sm text-gray-600 font-semibold">No programs match this specific tier.</p>
              <Button variant="link" onClick={() => setActiveTier("all")} className="text-green-700 text-xs mt-1">
                View all matching programs
              </Button>
            </Card>
          ) : (
            filteredMatches.map((prog, index) => {
              const isExpanded = !!expandedDiagnostics[prog.program_id];

              return (
                <Card 
                  key={prog.program_id} 
                  className="shadow-md border-green-100 hover:border-green-300 transition-all duration-200 bg-white/95 overflow-hidden"
                >
                  <CardContent className="p-6 space-y-4">
                    
                    {/* Card Top Row */}
                    <div className="flex flex-col md:flex-row md:items-start justify-between gap-4">
                      <div className="space-y-1">
                        <div className="flex items-center gap-2 flex-wrap">
                          <span className="w-6 h-6 rounded-full bg-green-100 text-green-800 text-xs font-extrabold flex items-center justify-center">
                            #{index + 1}
                          </span>
                          <h3 className="text-xl font-extrabold text-green-950">
                            {prog.name}
                          </h3>
                          
                          {/* Match Score Badge */}
                          <span className="inline-flex items-center gap-1 text-xs font-extrabold px-2.5 py-0.5 rounded-full bg-emerald-100 text-emerald-800 border border-emerald-300 shadow-sm">
                            <Sparkles className="w-3.5 h-3.5 text-emerald-600" />
                            {prog.matchScore}% Match
                          </span>

                          {/* Involvement Level Badge */}
                          {prog.involvement_level === "automated_claim" ? (
                            <Badge className="bg-purple-100 text-purple-900 border-purple-300 font-bold">🟣 Automated Claim Protocol</Badge>
                          ) : prog.involvement_level === "managed_application" ? (
                            <Badge className="bg-emerald-100 text-emerald-900 border-emerald-300 font-bold">🛡️ Managed Application</Badge>
                          ) : (
                            <Badge className="bg-blue-50 text-blue-900 border-blue-200">🌐 External Self-Apply</Badge>
                          )}

                          {/* Application Status Badge */}
                          <Badge className="bg-gray-100 text-gray-800 border-gray-200">
                            {prog.application_status || prog.status}
                          </Badge>
                        </div>
                        
                        <p className="text-xs text-gray-500 font-medium">
                          Organized by <span className="text-gray-800 font-semibold">{prog.organization}</span>
                        </p>
                      </div>

                      {/* Right Valuation Callout */}
                      <div className="text-left md:text-right bg-green-50/80 p-3 rounded-xl border border-green-200/80 flex-shrink-0">
                        <span className="text-[10px] uppercase font-bold text-green-700 block">Estimated Benefit</span>
                        <div className="text-2xl font-black text-green-950">
                          ${prog.monthly_amount_usd || 0}
                          <span className="text-xs font-medium text-gray-600 ml-1">{prog.currency}/mo</span>
                        </div>
                        <span className="text-[11px] text-gray-500 block">
                          {prog.amount_description || "Monthly regular distribution"}
                        </span>
                      </div>
                    </div>

                    {/* Program Description */}
                    <p className="text-xs text-gray-600 leading-relaxed line-clamp-2">
                      {prog.description}
                    </p>

                    {/* Feature Chips */}
                    <div className="flex flex-wrap items-center gap-2 pt-1 border-t border-gray-100 text-xs">
                      <span className="inline-flex items-center gap-1 px-2.5 py-1 bg-gray-100 rounded-lg text-gray-700">
                        <MapPin className="w-3.5 h-3.5 text-gray-500" />
                        {prog.municipalities?.length > 0 
                          ? `City: ${prog.municipalities.join(", ")}`
                          : prog.available_regions?.join(", ") || "Global"}
                      </span>

                      <span className="inline-flex items-center gap-1 px-2.5 py-1 bg-gray-100 rounded-lg text-gray-700">
                        <Banknote className="w-3.5 h-3.5 text-gray-500" />
                        Rail: {prog.payout_rail === "crypto_wallet" ? "Crypto Smart Contract" : prog.payout_rail || "Direct Deposit"}
                      </span>

                      <span className="inline-flex items-center gap-1 px-2.5 py-1 bg-gray-100 rounded-lg text-gray-700">
                        <DollarSign className="w-3.5 h-3.5 text-gray-500" />
                        Source: {prog.funding_source?.replace("_", " ") || "Philanthropic Grant"}
                      </span>
                    </div>

                    {/* Expandable "Why You Matched" Diagnostic Drawer */}
                    <div className="pt-2 border-t border-gray-100">
                      <button
                        onClick={() => toggleDiagnostic(prog.program_id)}
                        className="flex items-center gap-1.5 text-xs font-bold text-green-700 hover:text-green-900 transition-colors"
                      >
                        <Info className="w-3.5 h-3.5" />
                        <span>Why you matched this program</span>
                        {isExpanded ? <ChevronUp className="w-3.5 h-3.5" /> : <ChevronDown className="w-3.5 h-3.5" />}
                      </button>

                      {isExpanded && (
                        <div className="mt-3 p-4 bg-gray-50 rounded-xl border border-gray-200 grid grid-cols-1 sm:grid-cols-2 gap-3 animate-in fade-in">
                          {prog.diagnostics?.map((diag, dIdx) => (
                            <div key={dIdx} className="flex items-start gap-2 text-xs">
                              {diag.passed ? (
                                <CheckCircle2 className="w-4 h-4 text-emerald-600 flex-shrink-0 mt-0.5" />
                              ) : (
                                <XCircle className="w-4 h-4 text-amber-600 flex-shrink-0 mt-0.5" />
                              )}
                              <div>
                                <span className="font-bold text-gray-900">{diag.label}: </span>
                                <span className="text-gray-600">{diag.text}</span>
                              </div>
                            </div>
                          ))}
                        </div>
                      )}
                    </div>

                    {/* Action Bottom Bar */}
                    <div className="flex items-center justify-between pt-2 border-t border-gray-100 flex-wrap gap-2">
                      <Button
                        variant="ghost"
                        size="sm"
                        onClick={() => navigate('/program-details', { state: { programId: prog.program_id } })}
                        className="text-xs text-gray-700 hover:text-green-800"
                      >
                        View Full Details &rarr;
                      </Button>

                      {prog.involvement_level === "automated_claim" ? (
                        <Button
                          size="sm"
                          onClick={() => navigate(prog.custom_claim_path || '/claim/gooddollar')}
                          className="bg-purple-800 hover:bg-purple-900 text-white font-bold text-xs shadow-sm flex items-center gap-1.5"
                        >
                          <Zap className="w-3.5 h-3.5" />
                          <span>Open Claim Terminal</span>
                        </Button>
                      ) : prog.involvement_level === "managed_application" ? (
                        <Button
                          size="sm"
                          onClick={() => navigate('/program-details', { state: { programId: prog.program_id } })}
                          className="bg-emerald-800 hover:bg-emerald-900 text-white font-bold text-xs shadow-sm flex items-center gap-1.5"
                        >
                          <ShieldCheck className="w-3.5 h-3.5" />
                          <span>Apply via UBI Finder</span>
                        </Button>
                      ) : (
                        (prog.apply_url || prog.website) && (
                          <Button
                            size="sm"
                            onClick={() => window.open(prog.apply_url || prog.website, "_blank")}
                            className="bg-green-700 hover:bg-green-800 text-white font-bold text-xs shadow-sm flex items-center gap-1.5"
                          >
                            <span>Official Portal</span>
                            <ExternalLink className="w-3.5 h-3.5" />
                          </Button>
                        )
                      )}
                    </div>

                  </CardContent>
                </Card>
              );
            })
          )}
        </div>

        {/* Demoted / Ineligible Accordion Section */}
        {report?.demotedOrIneligible?.length > 0 && (
          <div className="pt-6 border-t border-gray-200">
            <Card className="border-gray-200 bg-gray-50/70">
              <CardHeader className="pb-3">
                <CardTitle className="text-base font-bold text-gray-800 flex items-center gap-2">
                  <AlertCircle className="w-4 h-4 text-gray-500" />
                  Programs Outside Your Current Demographic or Region ({report.demotedOrIneligible.length})
                </CardTitle>
                <CardDescription className="text-xs text-gray-500">
                  These programs are currently disqualified based on your location, income bracket, or eligibility requirements.
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-3">
                {report.demotedOrIneligible.slice(0, 4).map(prog => (
                  <div key={prog.program_id} className="p-3 bg-white rounded-xl border border-gray-200 text-xs flex items-center justify-between gap-4">
                    <div>
                      <span className="font-bold text-gray-900">{prog.name}</span>
                      <span className="text-gray-400 mx-2">&bull;</span>
                      <span className="text-red-700 font-medium">
                        {prog.disqualifiers?.join("; ") || "Outside eligible criteria"}
                      </span>
                    </div>
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={() => navigate('/program-details', { state: { programId: prog.program_id } })}
                      className="text-[11px] h-7"
                    >
                      Inspect
                    </Button>
                  </div>
                ))}
              </CardContent>
            </Card>
          </div>
        )}

      </div>
    </div>
  );
}
