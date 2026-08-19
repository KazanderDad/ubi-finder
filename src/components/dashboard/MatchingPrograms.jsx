import React from "react";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Heart, ExternalLink, Coins, Banknote, Sparkles, CheckCircle } from "lucide-react";
import { useNavigate } from "react-router-dom";

export default function MatchingPrograms({ programs, profile, onToggleFavorite, favoritePrograms = [], applications = [] }) {
  const navigate = useNavigate();
  
  const getIncomeRange = (range) => {
    switch (range) {
      case "0-20k": return 20000;
      case "20k-40k": return 40000;
      case "40k-60k": return 60000;
      case "60k+": return Infinity;
      default: return Infinity;
    }
  };

  // 5b: Calculate match score %
  const calculateMatchScore = (program) => {
    if (!profile) return 75;
    let score = 50; // base score

    // Country match
    const regions = program.available_regions || [];
    if (regions.length === 0 || regions.includes("Global") || regions.includes("Worldwide") || regions.includes(profile.country)) {
      score += 25;
    }

    // Income eligibility
    if (!program.max_household_income_usd || getIncomeRange(profile.income_range) <= program.max_household_income_usd) {
      score += 15;
    }

    // Gender requirement
    if (!program.gender_requirement || program.gender_requirement === profile.gender) {
      score += 10;
    }

    return Math.min(100, score);
  };

  const matchingPrograms = (programs || []).filter(program => {
    if (favoritePrograms.includes(program.program_id)) {
      return true;
    }
    
    if (!profile) return true;

    if (program.max_household_income_usd && 
        getIncomeRange(profile.income_range) > program.max_household_income_usd) {
      return false;
    }

    if (program.gender_requirement && program.gender_requirement !== profile.gender) {
      return false;
    }

    if (program.available_regions && program.available_regions.length > 0) {
      const inRegion = program.available_regions.includes(profile.country) || 
                       program.available_regions.includes("Global") || 
                       program.available_regions.includes("Worldwide");
      if (!inRegion) return false;
    }

    return true;
  });

  const getStatusColor = (status) => {
    switch (status) {
      case "active":
      case "active_open":
        return "bg-green-100 text-green-800 border-green-200";
      case "upcoming":
        return "bg-blue-100 text-blue-800 border-blue-200";
      case "closed":
      case "active_closed":
        return "bg-orange-100 text-orange-800 border-orange-200";
      default:
        return "bg-gray-100 text-gray-800 border-gray-200";
    }
  };

  const handleProgramClick = (program) => {
    navigate('/program-details', { state: { programId: program.program_id } });
  };

  const hasApplied = (programId) => {
    return applications?.some(app => app.program_id === programId);
  };

  return (
    <ScrollArea className="h-[650px] pr-3">
      {matchingPrograms.length === 0 ? (
        <div className="text-center p-8 bg-gray-50/70 rounded-xl border border-dashed border-gray-300 text-gray-500 space-y-2">
          <p className="font-semibold text-gray-700">No matching programs found for your exact criteria.</p>
          <p className="text-xs text-gray-500">
            Try adjusting your country or income range in your profile settings to discover more opportunities.
          </p>
        </div>
      ) : (
        <div className="space-y-4">
          {matchingPrograms.map((program) => {
            const matchScore = calculateMatchScore(program);
            const isFav = favoritePrograms.includes(program.program_id);

            return (
              <div 
                key={program.id} 
                className="p-4 bg-white rounded-xl border border-gray-200/90 hover:border-green-300 hover:shadow-md transition-all duration-200 cursor-pointer space-y-3"
                onClick={() => handleProgramClick(program)}
              >
                <div className="flex justify-between items-start gap-3">
                  <div>
                    <div className="flex items-center gap-2 flex-wrap mb-1">
                      <h3 className="font-bold text-green-950 hover:text-green-800 transition-colors">
                        {program.name}
                      </h3>
                      
                      {/* 5b: Match Score % Chip */}
                      <span className="inline-flex items-center gap-1 text-[11px] font-bold px-2 py-0.5 rounded-full bg-emerald-50 text-emerald-700 border border-emerald-200">
                        <Sparkles className="w-3 h-3 text-emerald-600" />
                        {matchScore}% Match
                      </span>

                      <Badge className={`text-[10px] ${getStatusColor(program.status)}`}>
                        {program.application_status || (program.status ? program.status.charAt(0).toUpperCase() + program.status.slice(1) : "Active")}
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
                      className={`h-8 w-8 rounded-full ${
                        isFav 
                          ? 'text-red-500 bg-red-50 hover:bg-red-100' 
                          : 'text-gray-400 hover:text-red-500 hover:bg-gray-100'
                      }`}
                    >
                      <Heart className={`w-4 h-4 ${isFav ? 'fill-current' : ''}`} />
                    </Button>
                  </div>
                </div>
                
                <div className="flex items-center justify-between pt-1 border-t border-gray-100 text-xs">
                  <div className="flex items-center gap-2">
                    <span className="font-extrabold text-green-950 text-sm">
                      ${Number(program.monthly_amount_usd || 0).toLocaleString()} {program.currency}/mo
                    </span>
                    <span className="text-gray-400">&bull;</span>
                    <span className="text-gray-600">
                      {program.available_regions?.length > 0 ? program.available_regions.join(", ") : "Global"}
                    </span>
                  </div>

                  <Button
                    size="sm"
                    variant={hasApplied(program.program_id) ? "secondary" : "default"}
                    className={hasApplied(program.program_id) 
                      ? "bg-gray-100 text-gray-700 text-xs h-7" 
                      : "bg-green-700 text-white hover:bg-green-800 text-xs h-7"}
                    onClick={(e) => {
                      e.stopPropagation();
                      handleProgramClick(program);
                    }}
                  >
                    {hasApplied(program.program_id) ? "Applied" : "View Details &rarr;"}
                  </Button>
                </div>
              </div>
            );
          })}
        </div>
      )}
    </ScrollArea>
  );
}
