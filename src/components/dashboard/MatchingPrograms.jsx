import React from "react";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Heart, ExternalLink, Coins, Banknote } from "lucide-react";
import { useNavigate } from "react-router-dom";

export default function MatchingPrograms({ programs, profile, onToggleFavorite, favoritePrograms, applications }) {
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

  const matchingPrograms = programs.filter(program => {
    // Include if it's a favorite
    if (favoritePrograms.includes(program.program_id)) {
      return true;
    }
    
    // Otherwise check eligibility
    if (program.max_household_income_usd && 
        getIncomeRange(profile.income_range) > program.max_household_income_usd) {
      return false;
    }

    // Check gender requirement
    if (program.gender_requirement && program.gender_requirement !== profile.gender) {
      return false;
    }

    // Check currency compatibility
    if (program.currency !== profile.currency && !profile.accepts_foreign_currency) {
      return false;
    }

    // Check region eligibility
    if (program.available_regions.length > 0) {
      if (!program.available_regions.includes(profile.country)) {
        return false;
      }
      
      if (program.required_states && program.required_states.length > 0) {
        if (!program.required_states.includes(profile.state)) {
          return false;
        }
      }
    }

    // Check payment method compatibility
    if (program.payment_method === "digital" && !profile.accepts_digital_currency) {
      return false;
    }

    return true;
  });

  const getStatusColor = (status) => {
    switch (status) {
      case "active":
        return "bg-green-100 text-green-800";
      case "upcoming":
        return "bg-blue-100 text-blue-800";
      case "closed":
        return "bg-red-100 text-red-800";
      default:
        return "bg-gray-100 text-gray-800";
    }
  };

  const handleProgramClick = (program) => {
    navigate('/program-details', { state: { programId: program.program_id } });
  };

  const hasApplied = (programId) => {
    return applications?.some(app => app.program_id === programId);
  };

  return (
    <ScrollArea className="h-[600px]">
      {matchingPrograms.length === 0 ? (
        <div className="text-center p-4 text-gray-500">
          No matching programs found for your profile.
          <br />
          Try adjusting your profile preferences or minimum payment requirements.
        </div>
      ) : (
        <div className="space-y-4">
          {matchingPrograms.map((program) => (
            <div 
              key={program.id} 
              className="p-4 border rounded-lg hover:shadow-lg transition-all duration-300 transform hover:-translate-y-1 cursor-pointer"
              onClick={() => handleProgramClick(program)}
            >
              <div className="flex justify-between items-start">
                <div>
                  <div className="flex items-center gap-2">
                    <h3 className="font-medium text-green-900">{program.name}</h3>
                    <Badge className={getStatusColor(program.status)}>
                      {program.status.charAt(0).toUpperCase() + program.status.slice(1)}
                    </Badge>
                  </div>
                  <p className="text-sm text-green-700">{program.organization}</p>
                </div>
                <div className="flex items-center gap-2">
                  <Button
                    variant={hasApplied(program.program_id) ? "secondary" : "default"}
                    size="sm"
                    className={hasApplied(program.program_id) 
                      ? "bg-gray-100 text-gray-700" 
                      : "bg-green-700 text-white hover:bg-green-800"}
                    disabled={hasApplied(program.program_id)}
                  >
                    {hasApplied(program.program_id) ? "Already Applied" : "Apply Now"}
                  </Button>
                  <Button
                    variant="ghost"
                    size="icon"
                    onClick={(e) => {
                      e.stopPropagation();
                      onToggleFavorite(program.program_id);
                    }}
                  >
                    <Heart 
                      className={`w-4 h-4 ${
                        favoritePrograms.includes(program.program_id) 
                          ? 'text-red-500 fill-red-500' 
                          : 'text-gray-400'
                      }`}
                    />
                  </Button>
                </div>
              </div>
              
              <div className="mt-2 flex items-center gap-4 flex-wrap">
                <div className="flex items-center gap-1">
                  {program.payment_method === "both" ? (
                    <>
                      <Banknote className="w-4 h-4 text-green-600" />
                      <Coins className="w-4 h-4 text-blue-600" />
                    </>
                  ) : program.payment_method === "digital" ? (
                    <Coins className="w-4 h-4 text-blue-600" />
                  ) : (
                    <Banknote className="w-4 h-4 text-green-600" />
                  )}
                  <span className="text-sm font-medium text-gray-900">
                    {program.monthly_amount_usd} {program.currency}/month
                  </span>
                </div>
                
                {program.gender_requirement && (
                  <Badge variant="secondary">
                    {program.gender_requirement.charAt(0).toUpperCase() + program.gender_requirement.slice(1)} only
                  </Badge>
                )}
                
                <Badge variant="outline" className="text-green-700">
                  {program.available_regions.length === 0 
                    ? "Worldwide" 
                    : program.available_regions.join(", ")}
                </Badge>
              </div>

              <Button
                variant="ghost"
                size="sm"
                className="mt-2 text-green-700 hover:text-green-800 hover:bg-green-100"
                onClick={(e) => {
                  e.stopPropagation();
                  window.open(program.website, '_blank');
                }}
              >
                <ExternalLink className="w-4 h-4 mr-1" />
                Learn More
              </Button>
            </div>
          ))}
        </div>
      )}
    </ScrollArea>
  );
}

