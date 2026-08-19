import React from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Heart, ExternalLink, AlertTriangle, Globe, Sparkles, DollarSign, Calendar, RefreshCw } from "lucide-react";
import { useNavigate } from "react-router-dom";

export default function ProgramList({ programs, onToggleFavorite, favoritePrograms, userEmail, isAdmin, onClearFilters }) {
  const navigate = useNavigate();

  // 3d. Empty state improvement
  if (!programs || programs.length === 0) {
    return (
      <div className="text-center py-16 px-4 space-y-4">
        <div className="w-16 h-16 bg-green-50 text-green-700 rounded-full flex items-center justify-center mx-auto text-2xl border border-green-100">
          🔍
        </div>
        <h3 className="text-xl font-bold text-gray-800">No programs found matching your filters</h3>
        <p className="text-sm text-gray-500 max-w-md mx-auto">
          Try expanding your country filter, clearing search keywords, or selecting all payment types.
        </p>
        {onClearFilters && (
          <Button 
            variant="outline" 
            onClick={onClearFilters}
            className="border-green-600 text-green-700 hover:bg-green-50 mt-2"
          >
            <RefreshCw className="w-4 h-4 mr-2" />
            Reset All Filters
          </Button>
        )}
      </div>
    );
  }

  const handleProgramClick = (program) => {
    navigate('/program-details', { state: { programId: program.program_id } });
  };
  
  return (
    <div className="grid grid-cols-1 gap-5">
      {programs.map(program => {
        const isFavorite = favoritePrograms?.includes(program.program_id);
        const monthlyUsd = Number(program.monthly_amount_usd || 0);

        return (
          <Card 
            key={program.id} 
            className="overflow-hidden hover:shadow-xl transition-all duration-200 transform hover:-translate-y-0.5 cursor-pointer bg-white/90 backdrop-blur-sm border-gray-200/80 hover:border-green-300"
            onClick={() => handleProgramClick(program)}
          >
            <CardContent className="p-6">
              <div className="flex flex-col md:flex-row justify-between gap-6">
                
                {/* Main Program Info */}
                <div className="flex-1 space-y-3">
                  <div className="flex items-start justify-between gap-4">
                    <div>
                      <div className="flex items-center gap-2 flex-wrap mb-1">
                        <h3 className="text-xl font-bold text-green-950 hover:text-green-800 transition-colors">
                          {program.name}
                        </h3>
                        {program.verified && (
                          <span className="inline-flex items-center gap-1 text-[11px] font-semibold text-green-700 bg-green-100/90 px-2 py-0.5 rounded-full">
                            <Sparkles className="w-3 h-3" /> Verified
                          </span>
                        )}
                      </div>
                      <p className="text-sm font-medium text-gray-500">
                        Initiative by <span className="text-gray-800">{program.organization}</span>
                      </p>
                    </div>

                    {/* Quick action buttons */}
                    <div className="flex items-center gap-1.5 flex-shrink-0" onClick={(e) => e.stopPropagation()}>
                      {onToggleFavorite && (
                        <Button
                          variant="ghost"
                          size="icon"
                          title={isFavorite ? "Remove from favorites" : "Save to favorites"}
                          onClick={(e) => {
                            e.stopPropagation();
                            onToggleFavorite(program.program_id);
                          }}
                          className={`h-9 w-9 rounded-full ${
                            isFavorite 
                              ? "text-red-500 bg-red-50 hover:bg-red-100 hover:text-red-600" 
                              : "text-gray-400 hover:text-red-500 hover:bg-gray-100"
                          }`}
                        >
                          <Heart className={`h-5 w-5 ${isFavorite ? "fill-current" : ""}`} />
                        </Button>
                      )}
                      {(program.apply_url || program.website) && (
                        <Button
                          variant="ghost"
                          size="icon"
                          title="Open official program page"
                          onClick={(e) => {
                            e.stopPropagation();
                            window.open(program.apply_url || program.website, '_blank');
                          }}
                          className="h-9 w-9 rounded-full text-gray-400 hover:text-green-700 hover:bg-green-50"
                        >
                          <ExternalLink className="h-4 w-4" />
                        </Button>
                      )}
                    </div>
                  </div>
                  
                  {/* Badges / Meta row (3a) */}
                  <div className="flex flex-wrap items-center gap-2">
                    {/* Status badge */}
                    {program.application_status ? (
                      <Badge className={
                        program.application_status === 'Accepting applications' ? 'bg-emerald-100 text-emerald-900 border-emerald-200' :
                        program.application_status === 'Accepting waitlist' ? 'bg-amber-100 text-amber-900 border-amber-200' :
                        'bg-gray-100 text-gray-700 border-gray-200'
                      }>
                        {program.application_status}
                      </Badge>
                    ) : (
                      <Badge className={`${
                        program.status === 'active_open' ? 'bg-green-100 text-green-800' : 
                        program.status === 'active_closed' ? 'bg-orange-100 text-orange-800' : 
                        program.status === 'upcoming' ? 'bg-blue-100 text-blue-800' : 
                        'bg-gray-100 text-gray-800'
                      }`}>
                        {program.status === 'active_open' ? 'Active • Open' : 
                         program.status === 'active_closed' ? 'Active • Closed' : 
                         program.status === 'upcoming' ? 'Upcoming' : 'Closed'}
                      </Badge>
                    )}
                    
                    {/* Payment Type */}
                    <Badge className={program.payment_method === 'digital' 
                      ? 'bg-purple-100 text-purple-800 border-purple-200' 
                      : 'bg-blue-100 text-blue-800 border-blue-200'}>
                      {program.payment_method === 'digital' ? 'Crypto / Digital' : 'Direct Bank / Cash'}
                    </Badge>

                    {/* Region */}
                    <div className="inline-flex items-center gap-1 text-xs text-gray-600 bg-gray-100 px-2.5 py-1 rounded-md">
                      <Globe className="w-3.5 h-3.5 text-gray-500" />
                      <span>
                        {program.available_regions && program.available_regions.length > 0 
                          ? program.available_regions.join(", ") 
                          : "Worldwide"}
                      </span>
                    </div>

                    {/* Gender Requirement if any */}
                    {program.gender_requirement && (
                      <Badge variant="outline" className="text-xs border-gray-300 text-gray-700">
                        {program.gender_requirement.charAt(0).toUpperCase() + program.gender_requirement.slice(1)} Only
                      </Badge>
                    )}

                    {!program.verified && (
                      <Badge className="bg-amber-100 text-amber-800 flex items-center gap-1">
                        <AlertTriangle className="w-3 h-3 mr-1" />
                        Under Review
                      </Badge>
                    )}
                  </div>
                  
                  {/* Description snippet */}
                  <p className="text-gray-600 text-sm line-clamp-2 leading-relaxed">
                    {program.description}
                  </p>
                </div>
                
                {/* 3a: Prominent Monthly Amount Card Panel */}
                <div className="md:w-56 flex-shrink-0 flex flex-col justify-center items-center p-4 bg-green-50/70 rounded-xl border border-green-100/90 text-center">
                  <span className="text-xs font-semibold uppercase tracking-wider text-green-800 mb-0.5">
                    Monthly Support
                  </span>
                  <div className="text-2xl md:text-3xl font-extrabold text-green-950">
                    ${monthlyUsd.toLocaleString()}
                    <span className="text-xs font-normal text-gray-600 ml-1">
                      {program.currency || 'USD'}
                    </span>
                  </div>
                  <p className="text-[11px] text-gray-500 mt-1 line-clamp-1">
                    {program.amount_description || "Estimated monthly disbursement"}
                  </p>
                  <Button 
                    size="sm" 
                    className="w-full mt-3 bg-green-700 hover:bg-green-800 text-white font-medium text-xs shadow-sm"
                  >
                    View Program &rarr;
                  </Button>
                </div>

              </div>
            </CardContent>
          </Card>
        );
      })}
    </div>
  );
}
