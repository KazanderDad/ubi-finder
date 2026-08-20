import React, { useState } from "react";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { 
  Heart, 
  ExternalLink, 
  Coins, 
  Banknote, 
  Sparkles, 
  CheckCircle2, 
  MapPin, 
  DollarSign, 
  Info,
  ChevronDown,
  ChevronUp,
  FileSpreadsheet
} from "lucide-react";
import { useNavigate, Link } from "react-router-dom";
import { generateUserMatchReport, TIERS } from "@/lib/matchingEngine";

export default function MatchingPrograms({ programs, profile, onToggleFavorite, favoritePrograms = [], applications = [] }) {
  const navigate = useNavigate();
  const [selectedTier, setSelectedTier] = useState("all");
  const [expandedDiagnostics, setExpandedDiagnostics] = useState({});

  const report = generateUserMatchReport(profile, programs);

  const displayedPrograms = (report.rankedMatches || []).filter(p => {
    if (favoritePrograms.includes(p.program_id)) return true;
    if (selectedTier === "all") return true;
    return p.tier === selectedTier;
  });

  const toggleDiagnostic = (progId) => {
    setExpandedDiagnostics(prev => ({
      ...prev,
      [progId]: !prev[progId]
    }));
  };

  const getStatusColor = (status, appStatus) => {
    if (appStatus === "Accepting applications" || status === "active_open") {
      return "bg-emerald-100 text-emerald-800 border-emerald-200";
    }
    if (appStatus === "Accepting waitlist" || status === "upcoming") {
      return "bg-blue-100 text-blue-800 border-blue-200";
    }
    if (appStatus === "No longer accepting applications" || status === "active_closed" || status === "closed") {
      return "bg-amber-100 text-amber-800 border-amber-200";
    }
    return "bg-gray-100 text-gray-800 border-gray-200";
  };

  const handleProgramClick = (program) => {
    navigate('/program-details', { state: { programId: program.program_id } });
  };

  const hasApplied = (programId) => {
    return applications?.some(app => app.program_id === programId);
  };

  return (
    <div className="space-y-4">
      
      {/* Top Potential Floor Teaser Banner */}
      <div className="p-4 bg-gradient-to-r from-emerald-900 to-green-950 text-white rounded-2xl flex items-center justify-between shadow-sm">
        <div>
          <span className="text-[10px] font-bold uppercase tracking-wider text-green-300">
            Calculated Potential Cash Floor
          </span>
          <div className="text-xl font-extrabold text-yellow-300">
            ${report.totalPotentialMonthlyUsd.toLocaleString()} USD<span className="text-xs font-normal text-white ml-1">/mo</span>
          </div>
          <span className="text-[11px] text-green-200">
            Across {report.totalEligibleCount} qualified programs & protocols
          </span>
        </div>

        <Link to="/My-Report">
          <Button size="sm" className="bg-white text-green-950 hover:bg-green-100 font-bold text-xs shadow-sm flex items-center gap-1">
            <Sparkles className="w-3.5 h-3.5 text-yellow-500" />
            Full Report &rarr;
          </Button>
        </Link>
      </div>

      {/* Tier Filter Tabs */}
      <div className="flex items-center gap-1.5 overflow-x-auto pb-1 text-xs">
        <button
          onClick={() => setSelectedTier("all")}
          className={`px-2.5 py-1 rounded-full font-medium transition-colors ${selectedTier === "all" ? "bg-green-800 text-white" : "bg-gray-100 text-gray-600 hover:bg-gray-200"}`}
        >
          All ({report.rankedMatches.length})
        </button>

        <button
          onClick={() => setSelectedTier(TIERS.TIER_1_GUARANTEED)}
          className={`px-2.5 py-1 rounded-full font-medium transition-colors ${selectedTier === TIERS.TIER_1_GUARANTEED ? "bg-green-700 text-white" : "bg-green-50 text-green-800 hover:bg-green-100"}`}
        >
          🟢 Guaranteed ({report.tierSummary.tier_1_guaranteed?.length || 0})
        </button>

        <button
          onClick={() => setSelectedTier(TIERS.TIER_2_DAILY_CLAIM)}
          className={`px-2.5 py-1 rounded-full font-medium transition-colors ${selectedTier === TIERS.TIER_2_DAILY_CLAIM ? "bg-purple-700 text-white" : "bg-purple-50 text-purple-800 hover:bg-purple-100"}`}
        >
          🟣 Daily Claim ({report.tierSummary.tier_2_daily_claim?.length || 0})
        </button>

        <button
          onClick={() => setSelectedTier(TIERS.TIER_3_LOTTERY)}
          className={`px-2.5 py-1 rounded-full font-medium transition-colors ${selectedTier === TIERS.TIER_3_LOTTERY ? "bg-amber-700 text-white" : "bg-amber-50 text-amber-800 hover:bg-amber-100"}`}
        >
          🎁 Raffles ({report.tierSummary.tier_3_lottery?.length || 0})
        </button>
      </div>

      <ScrollArea className="h-[580px] pr-3">
        {displayedPrograms.length === 0 ? (
          <div className="text-center p-8 bg-gray-50/70 rounded-xl border border-dashed border-gray-300 text-gray-500 space-y-2">
            <p className="font-semibold text-gray-700">No matching programs found for this filter.</p>
            <p className="text-xs text-gray-500">
              Try clicking "All" or updating your geographic criteria in profile settings.
            </p>
          </div>
        ) : (
          <div className="space-y-3.5">
            {displayedPrograms.map((program) => {
              const isFav = favoritePrograms.includes(program.program_id);
              const isDiagOpen = !!expandedDiagnostics[program.program_id];

              return (
                <div 
                  key={program.program_id} 
                  className="p-4 bg-white rounded-xl border border-gray-200/90 hover:border-green-300 hover:shadow-md transition-all duration-200 cursor-pointer space-y-2.5"
                  onClick={() => handleProgramClick(program)}
                >
                  <div className="flex justify-between items-start gap-3">
                    <div>
                      <div className="flex items-center gap-1.5 flex-wrap mb-1">
                        <h3 className="font-bold text-sm text-green-950 hover:text-green-800 transition-colors">
                          {program.name}
                        </h3>
                        
                        {/* Match Score % Chip */}
                        <span className="inline-flex items-center gap-1 text-[10px] font-extrabold px-2 py-0.5 rounded-full bg-emerald-100 text-emerald-800 border border-emerald-300">
                          <Sparkles className="w-3 h-3 text-emerald-600" />
                          {program.matchScore}% Match
                        </span>

                        {program.involvement_level === "automated_claim" && (
                          <Badge className="text-[10px] bg-purple-100 text-purple-900 border-purple-300 font-bold">
                            🟣 Automated Claim
                          </Badge>
                        )}

                        {program.involvement_level === "managed_application" && (
                          <Badge className="text-[10px] bg-emerald-100 text-emerald-900 border-emerald-300 font-bold">
                            🛡️ Managed App
                          </Badge>
                        )}

                        <Badge className={`text-[10px] ${getStatusColor(program.status, program.application_status)}`}>
                          {program.application_status || program.status || "Active"}
                        </Badge>
                      </div>
                      <p className="text-xs text-gray-500 font-medium">Initiative by {program.organization}</p>
                    </div>

                    <div className="flex items-center gap-1.5 flex-shrink-0" onClick={(e) => e.stopPropagation()}>
                      <Button
                        variant="ghost"
                        size="icon"
                        onClick={(e) => {
                          e.stopPropagation();
                          onToggleFavorite(program.program_id);
                        }}
                        className={`h-7 w-7 rounded-full ${
                          isFav 
                            ? 'text-red-500 bg-red-50 hover:bg-red-100' 
                            : 'text-gray-400 hover:text-red-500 hover:bg-gray-100'
                        }`}
                      >
                        <Heart className={`w-3.5 h-3.5 ${isFav ? 'fill-current' : ''}`} />
                      </Button>
                    </div>
                  </div>

                  {/* Program Diagnostics Dropdown */}
                  <div className="text-[11px] pt-1" onClick={(e) => e.stopPropagation()}>
                    <button
                      onClick={() => toggleDiagnostic(program.program_id)}
                      className="text-green-700 font-semibold hover:underline flex items-center gap-1"
                    >
                      <span>Why you qualified</span>
                      {isDiagOpen ? <ChevronUp className="w-3 h-3" /> : <ChevronDown className="w-3 h-3" />}
                    </button>

                    {isDiagOpen && (
                      <div className="mt-2 p-2.5 bg-gray-50 rounded-lg border border-gray-200 space-y-1">
                        {program.diagnostics?.map((diag, dIdx) => (
                          <div key={dIdx} className="flex items-center gap-1.5">
                            <CheckCircle2 className="w-3 h-3 text-emerald-600 flex-shrink-0" />
                            <span className="text-gray-700"><strong>{diag.label}:</strong> {diag.text}</span>
                          </div>
                        ))}
                      </div>
                    )}
                  </div>
                  
                  <div className="flex items-center justify-between pt-2 border-t border-gray-100 text-xs">
                    <div className="flex items-center gap-2">
                      <span className="font-extrabold text-green-950 text-sm">
                        ${Number(program.monthly_amount_usd || 0).toLocaleString()} {program.currency}/mo
                      </span>
                      <span className="text-gray-300">&bull;</span>
                      <span className="text-gray-500 text-[11px]">
                        {program.municipalities?.length > 0 ? program.municipalities[0] : (program.available_regions?.[0] || "Global")}
                      </span>
                    </div>

                    <Button
                      size="sm"
                      variant={hasApplied(program.program_id) ? "secondary" : "default"}
                      className={hasApplied(program.program_id) 
                        ? "bg-gray-100 text-gray-700 text-xs h-7" 
                        : program.involvement_level === 'automated_claim'
                          ? "bg-purple-800 text-white hover:bg-purple-900 text-xs h-7"
                          : program.involvement_level === 'managed_application'
                            ? "bg-emerald-800 text-white hover:bg-emerald-900 text-xs h-7"
                            : "bg-green-700 text-white hover:bg-green-800 text-xs h-7"}
                      onClick={(e) => {
                        e.stopPropagation();
                        handleProgramClick(program);
                      }}
                    >
                      {hasApplied(program.program_id) 
                        ? "Applied" 
                        : program.involvement_level === 'automated_claim'
                          ? "⚡ Claim"
                          : program.involvement_level === 'managed_application'
                            ? "🛡️ Apply"
                            : "View Details \u2192"}
                    </Button>
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </ScrollArea>
    </div>
  );
}
