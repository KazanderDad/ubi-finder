import React from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { 
  Heart, 
  ExternalLink, 
  AlertTriangle, 
  Globe, 
  Sparkles, 
  DollarSign, 
  Calendar, 
  RefreshCw,
  Coins,
  CreditCard,
  Building,
  Smartphone,
  Gift,
  CheckCircle2,
  MapPin,
  Zap,
  ShieldCheck,
  GraduationCap,
  FlaskConical,
  Users,
  Landmark
} from "lucide-react";
import { useNavigate } from "react-router-dom";

export default function ProgramList({ programs, onToggleFavorite, favoritePrograms, userEmail, isAdmin, onClearFilters }) {
  const navigate = useNavigate();

  // Empty state
  if (!programs || programs.length === 0) {
    return (
      <div className="text-center py-16 px-4 space-y-4">
        <div className="w-16 h-16 bg-green-50 text-green-700 rounded-full flex items-center justify-center mx-auto text-2xl border border-green-100">
          🔍
        </div>
        <h3 className="text-xl font-bold text-gray-800">No programs found matching your filters</h3>
        <p className="text-sm text-gray-500 max-w-md mx-auto">
          Try expanding your country filter, clearing search keywords, or selecting all payment types and distribution models.
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

  const getDistributionBadge = (type) => {
    switch (type) {
      case 'permanent_statewide':
        return (
          <Badge className="bg-blue-100 text-blue-900 border-blue-200 font-semibold flex items-center gap-1">
            <Landmark className="w-3 h-3 text-blue-700" />
            Permanent Statewide Program
          </Badge>
        );
      case 'daily_claim_protocol':
        return (
          <Badge className="bg-purple-100 text-purple-900 border-purple-200 font-semibold flex items-center gap-1">
            <Coins className="w-3 h-3 text-purple-700" />
            Daily Claim Protocol
          </Badge>
        );
      case 'lottery_raffle':
        return (
          <Badge className="bg-amber-100 text-amber-900 border-amber-200 font-semibold flex items-center gap-1">
            <Gift className="w-3 h-3 text-amber-700" />
            Lottery / Community Raffle
          </Badge>
        );
      case 'guaranteed_recurrent':
      default:
        return (
          <Badge className="bg-emerald-100 text-emerald-900 border-emerald-200 font-semibold flex items-center gap-1">
            <CheckCircle2 className="w-3 h-3 text-emerald-700" />
            Guaranteed Income
          </Badge>
        );
    }
  };

  const getRailBadge = (rail) => {
    switch (rail) {
      case 'crypto_wallet':
        return (
          <span className="inline-flex items-center gap-1 text-xs text-purple-800 bg-purple-50 px-2 py-0.5 rounded border border-purple-200">
            <Coins className="w-3 h-3" /> Crypto / Smart Contract
          </span>
        );
      case 'prepaid_card':
        return (
          <span className="inline-flex items-center gap-1 text-xs text-blue-800 bg-blue-50 px-2 py-0.5 rounded border border-blue-200">
            <CreditCard className="w-3 h-3" /> Prepaid Debit Card
          </span>
        );
      case 'mobile_money':
        return (
          <span className="inline-flex items-center gap-1 text-xs text-teal-800 bg-teal-50 px-2 py-0.5 rounded border border-teal-200">
            <Smartphone className="w-3 h-3" /> Mobile Money
          </span>
        );
      case 'direct_deposit':
      default:
        return (
          <span className="inline-flex items-center gap-1 text-xs text-slate-800 bg-slate-100 px-2 py-0.5 rounded border border-slate-200">
            <Building className="w-3 h-3" /> Direct Deposit / Bank
          </span>
        );
    }
  };
  
  const getInvolvementBadge = (level) => {
    switch (level) {
      case 'automated_claim':
        return (
          <Badge className="bg-purple-100 text-purple-900 border-purple-300 font-bold flex items-center gap-1">
            <Zap className="w-3 h-3 text-purple-700" />
            Automated Claim Protocol
          </Badge>
        );
      case 'managed_application':
        return (
          <Badge className="bg-emerald-100 text-emerald-900 border-emerald-300 font-bold flex items-center gap-1">
            <ShieldCheck className="w-3 h-3 text-emerald-700" />
            Managed Application
          </Badge>
        );
      case 'external_self_apply':
      default:
        return (
          <Badge className="bg-blue-50 text-blue-900 border-blue-200 font-medium flex items-center gap-1">
            <ExternalLink className="w-3 h-3 text-blue-700" />
            External Self-Apply
          </Badge>
        );
    }
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
                        Initiative by <span className="text-gray-800 font-semibold">{program.organization}</span>
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
                  
                  {/* Badges / Meta row */}
                  <div className="flex flex-wrap items-center gap-2">
                    {/* Intelligent Match Score if profile is active */}
                    {program.matchScore !== undefined && program.matchScore > 0 && (
                      <Badge className={
                        program.matchScore >= 85 
                          ? 'bg-emerald-600 text-white font-bold flex items-center gap-1 shadow-xs' 
                          : program.matchScore >= 65 
                            ? 'bg-emerald-100 text-emerald-900 border-emerald-300 font-bold flex items-center gap-1'
                            : 'bg-slate-100 text-slate-800 border-slate-200 font-medium flex items-center gap-1'
                      }>
                        <Sparkles className="w-3 h-3 text-white" />
                        {program.matchScore}% Match {program.matchScore >= 85 ? '• Best Fit' : ''}
                      </Badge>
                    )}

                    {/* Data Source Badge (Stanford Lab vs Community) */}
                    {program.data_source === 'stanford_basic_income_lab' || program.stanford_experiment_id ? (
                      <Badge className="bg-red-50 text-red-900 border-red-200 font-semibold flex items-center gap-1 text-[11px]">
                        <GraduationCap className="w-3 h-3 text-red-700" />
                        Stanford Basic Income Lab
                      </Badge>
                    ) : (
                      <Badge className="bg-slate-50 text-slate-700 border-slate-200 font-normal flex items-center gap-1 text-[11px]">
                        <Globe className="w-3 h-3 text-slate-500" />
                        Community Submission
                      </Badge>
                    )}

                    {/* RCT Study Badge */}
                    {program.is_rct && (
                      <Badge className="bg-blue-50 text-blue-900 border-blue-200 font-semibold flex items-center gap-1 text-[11px]">
                        <FlaskConical className="w-3 h-3 text-blue-700" />
                        RCT Study
                      </Badge>
                    )}

                    {/* Total Participants */}
                    {program.total_participants && (
                      <div className="inline-flex items-center gap-1 text-xs text-gray-700 bg-gray-50 px-2.5 py-1 rounded-md border border-gray-200">
                        <Users className="w-3 h-3 text-gray-500" />
                        <span>{program.total_participants} Participants</span>
                      </div>
                    )}

                    {/* Project Involvement Level Badge */}
                    {getInvolvementBadge(program.involvement_level)}

                    {/* Capability 4: Distribution Class Badge */}
                    {getDistributionBadge(program.distribution_type)}

                    {/* Capability 4: Payout Rail Badge */}
                    {getRailBadge(program.payout_rail)}

                    {/* Payout Status Badge */}
                    {program.payout_status && (
                      <Badge className={
                        program.payout_status.toLowerCase().includes('ongoing') ? 'bg-green-100 text-green-800 border-green-200' :
                        program.payout_status.toLowerCase().includes('planned') || program.payout_status.toLowerCase().includes('scheduled') ? 'bg-blue-100 text-blue-800 border-blue-200' :
                        program.payout_status.toLowerCase().includes('ended') || program.payout_status.toLowerCase().includes('completed') ? 'bg-gray-100 text-gray-800 border-gray-200' :
                        'bg-yellow-100 text-yellow-800 border-yellow-200'
                      }>
                        Payouts: {program.payout_status}
                      </Badge>
                    )}

                    {/* Application Status Badge */}
                    {program.application_status ? (
                      <Badge className={
                        program.application_status.toLowerCase().includes('accepting') || program.application_status.toLowerCase().includes('open') || program.application_status.toLowerCase().includes('automatic') ? 'bg-emerald-100 text-emerald-900 border-emerald-200' :
                        program.application_status.toLowerCase().includes('waitlist') ? 'bg-amber-100 text-amber-900 border-amber-200' :
                        program.application_status.toLowerCase().includes('referral') ? 'bg-purple-100 text-purple-900 border-purple-200' :
                        program.application_status.toLowerCase().includes('no longer') || program.application_status.toLowerCase().includes('closed') ? 'bg-red-100 text-red-800 border-red-200' :
                        'bg-gray-100 text-gray-700 border-gray-200'
                      }>
                        {program.application_status}
                      </Badge>
                    ) : null}

                    {/* Region / Geography */}
                    <div className="inline-flex items-center gap-1 text-xs text-gray-600 bg-gray-100 px-2.5 py-1 rounded-md">
                      <Globe className="w-3.5 h-3.5 text-gray-500" />
                      <span>
                        {program.available_regions && program.available_regions.length > 0 
                          ? program.available_regions.join(", ") 
                          : "Worldwide"}
                      </span>
                    </div>

                    {/* Municipalities if specific */}
                    {program.municipalities && program.municipalities.length > 0 && !program.municipalities.includes('Global') && (
                      <div className="inline-flex items-center gap-1 text-xs text-emerald-800 bg-emerald-50 px-2.5 py-1 rounded-md border border-emerald-200">
                        <MapPin className="w-3 h-3 text-emerald-600" />
                        <span>{program.municipalities.join(", ")}</span>
                      </div>
                    )}

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
                
                {/* Monthly Amount Card Panel */}
                <div className="md:w-56 flex-shrink-0 flex flex-col justify-center items-center p-4 bg-green-50/70 rounded-xl border border-green-100/90 text-center">
                  <span className="text-xs font-semibold uppercase tracking-wider text-green-800 mb-0.5">
                    {program.distribution_type === 'daily_claim_protocol' 
                      ? 'Daily Claim Approx' 
                      : program.distribution_type === 'lottery_raffle' 
                        ? 'Raffle Prize' 
                        : 'Monthly Support'}
                  </span>
                  <div className="text-2xl md:text-3xl font-extrabold text-green-950">
                    ${monthlyUsd.toLocaleString()}
                    <span className="text-xs font-normal text-gray-600 ml-1">
                      USD
                    </span>
                  </div>
                  <span className="text-[11px] text-green-700 font-medium mt-0.5">
                    {program.amount_description || `${program.currency} ${monthlyUsd}/mo`}
                  </span>
                  <Button 
                    size="sm" 
                    className={`mt-3 w-full text-white text-xs font-semibold shadow-sm ${
                      program.involvement_level === 'automated_claim'
                        ? 'bg-purple-800 hover:bg-purple-900'
                        : program.involvement_level === 'managed_application'
                          ? 'bg-emerald-800 hover:bg-emerald-900'
                          : 'bg-green-700 hover:bg-green-800'
                    }`}
                  >
                    {program.involvement_level === 'automated_claim' ? "⚡ Claim Terminal" :
                     program.involvement_level === 'managed_application' ? "🛡️ Apply Managed" :
                     "View Details \u2192"}
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
