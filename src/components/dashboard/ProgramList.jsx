import React from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Heart, ExternalLink, AlertTriangle } from "lucide-react";
import { useNavigate } from "react-router-dom";

export default function ProgramList({ programs, onToggleFavorite, favoritePrograms, userEmail, isAdmin }) {
  const navigate = useNavigate();

  if (!programs || programs.length === 0) {
    return (
      <div className="text-center py-8">
        <p className="text-gray-500">No programs found matching your criteria.</p>
      </div>
    );
  }

  const handleProgramClick = (program) => {
    navigate('/program-details', { state: { programId: program.program_id } });
  };
  
  return (
    <div className="space-y-6">
      {programs.map(program => (
        <Card 
          key={program.id} 
          className="overflow-hidden hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1 cursor-pointer"
          onClick={() => handleProgramClick(program)}
        >
          <CardContent className="p-6">
            <div className="flex flex-col md:flex-row justify-between">
              <div className="md:w-3/4">
                <div className="flex items-start justify-between">
                  <div>
                    <h3 className="text-xl font-bold text-green-800 mb-1">
                      {program.name}
                    </h3>
                    <p className="text-sm text-gray-600 mb-2">
                      By {program.organization}
                    </p>
                  </div>
                  <div className="flex space-x-2" onClick={(e) => e.stopPropagation()}>
                    {favoritePrograms && (
                      <Button
                        variant="ghost"
                        size="sm"
                        onClick={(e) => {
                          e.stopPropagation();
                          onToggleFavorite(program.program_id);
                        }}
                        className={favoritePrograms.includes(program.program_id) 
                          ? "text-red-600 hover:text-red-700 hover:bg-red-50" 
                          : "text-gray-400 hover:text-gray-600"}
                      >
                        {favoritePrograms.includes(program.program_id) 
                          ? <Heart className="h-5 w-5 fill-current" /> 
                          : <Heart className="h-5 w-5" />}
                      </Button>
                    )}
                    {program.website && (
                      <Button
                        variant="ghost"
                        size="sm"
                        onClick={(e) => {
                          e.stopPropagation();
                          window.open(program.website, '_blank');
                        }}
                        className="text-green-700 hover:text-green-800 hover:bg-green-50"
                      >
                        <ExternalLink className="h-5 w-5" />
                      </Button>
                    )}
                  </div>
                </div>
                
                <div className="flex flex-wrap gap-2 my-2">
                  <Badge className={`${program.status === 'active_open' ? 'bg-green-100 text-green-800' : 
                                      program.status === 'active_closed' ? 'bg-orange-100 text-orange-800' : 
                                      program.status === 'upcoming' ? 'bg-blue-100 text-blue-800' : 
                                      'bg-gray-100 text-gray-800'}`}>
                    {program.status === 'active_open' ? 'Active • Open' : 
                     program.status === 'active_closed' ? 'Active • Closed' : 
                     program.status === 'upcoming' ? 'Upcoming' : 'Closed'}
                  </Badge>
                  
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
                  
                  {program.available_regions && program.available_regions.length > 0 && (
                    <Badge variant="outline">
                      {program.available_regions.length === 1 
                        ? program.available_regions[0] 
                        : `${program.available_regions.length} Regions`}
                    </Badge>
                  )}
                  
                  {program.gender_requirement && (
                    <Badge variant="outline">
                      {program.gender_requirement.charAt(0).toUpperCase() + program.gender_requirement.slice(1)} Only
                    </Badge>
                  )}
                </div>
                
                <p className="text-gray-700 my-3">
                  {program.description.length > 150 
                    ?  `${program.description.slice(0, 150)}...` 
                    : program.description}
                </p>
              </div>
              
              <div className="md:w-1/4 md:pl-6 mt-4 md:mt-0 border-t pt-4 md:pt-0 md:border-t-0 md:border-l">
                <div className="text-center">
                  <div className="text-2xl font-bold text-green-700 mb-1">
                    ${program.monthly_amount_usd}
                  </div>
                  <p className="text-sm text-gray-600 mb-3">per month</p>
                  <p className="text-xs text-gray-500">{program.amount_description}</p>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>
      ))}
    </div>
  );
}

