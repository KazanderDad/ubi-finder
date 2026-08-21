import React from "react";
import { useNavigate } from "react-router-dom";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { 
  Sparkles, 
  Rocket, 
  ShieldCheck, 
  Megaphone, 
  Trophy, 
  LineChart, 
  ArrowRight, 
  CheckCircle2,
  Building,
  HeartHandshake
} from "lucide-react";

export default function InauguralProjectsModal({ open, onOpenChange }) {
  const navigate = useNavigate();

  const handleSignUpClick = () => {
    onOpenChange(false);
    navigate("/Submit-Program?cohort=epoch-1");
  };

  const handleServicesClick = () => {
    onOpenChange(false);
    navigate("/Services");
  };

  const perks = [
    {
      icon: Sparkles,
      title: "Featured Placement & Discovery",
      description: "Top-tier spotlight across the global map, verified pilot directory, and tailored seeker match feeds.",
      color: "text-amber-600 bg-amber-50 border-amber-200"
    },
    {
      icon: ShieldCheck,
      title: "Dedicated Technical & Rail Support",
      description: "White-glove architecture guidance for configuring payout rails—including ACH direct deposit, smart contracts, and prepaid cards.",
      color: "text-emerald-600 bg-emerald-50 border-emerald-200"
    },
    {
      icon: Megaphone,
      title: "Co-Marketing & Press Amplification",
      description: "Joint press releases, dedicated founder spotlight articles, ecosystem newsletters, and community forum highlights.",
      color: "text-blue-600 bg-blue-50 border-blue-200"
    },
    {
      icon: Trophy,
      title: "Permanent Inaugural Leaderboard",
      description: "Distinguished 'Epoch 1 Founding Partner' badge on your public profile and leaderboard recognition.",
      color: "text-purple-600 bg-purple-50 border-purple-200"
    },
    {
      icon: LineChart,
      title: "Pilot Research & Impact Studies",
      description: "Rigorous retention tracking, economic velocity diagnostics, and inclusion in our quarterly basic income research report.",
      color: "text-teal-600 bg-teal-50 border-teal-200"
    }
  ];

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-2xl max-h-[92vh] overflow-y-auto p-0 border-emerald-100 bg-white/98 shadow-2xl rounded-2xl">
        
        {/* Header Hero Banner */}
        <div className="bg-gradient-to-br from-emerald-800 via-green-800 to-teal-900 text-white p-6 sm:p-8 relative overflow-hidden">
          <div className="absolute -right-8 -bottom-8 w-40 h-40 bg-white/10 rounded-full blur-2xl pointer-events-none" />
          
          <div className="inline-flex items-center gap-1.5 px-3 py-1 bg-white/15 backdrop-blur-md border border-white/20 rounded-full text-xs font-bold text-emerald-200 mb-3">
            <Rocket className="w-3.5 h-3.5 text-yellow-300 animate-bounce" />
            Now Onboarding: Inaugural Pilot Batch • Epoch 1
          </div>

          <DialogTitle className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight leading-snug">
            Looking for Inaugural Projects
          </DialogTitle>
          
          <DialogDescription className="text-emerald-100 text-xs sm:text-sm mt-2 leading-relaxed">
            UBI Finder is officially past launch! We are selecting and onboarding our founding cohort of UBI pilots, municipal income experiments, and Web3 daily claim protocols to participate in our inaugural pilot batch.
          </DialogDescription>
        </div>

        {/* Modal Body: The 5 Inaugural Perks */}
        <div className="p-6 sm:p-8 space-y-6">
          <div>
            <h4 className="text-xs font-bold uppercase tracking-wider text-emerald-800 mb-3 flex items-center gap-1.5">
              <HeartHandshake className="w-4 h-4 text-emerald-700" />
              Inaugural Partner Privileges & Support
            </h4>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
              {perks.map((perk, idx) => {
                const Icon = perk.icon;
                return (
                  <div 
                    key={perk.title}
                    className={`p-3.5 rounded-xl border transition-all ${idx === 4 ? 'sm:col-span-2' : ''} ${perk.color}`}
                  >
                    <div className="flex items-start gap-3">
                      <div className="p-2 rounded-lg bg-white shadow-xs border border-inherit flex-shrink-0">
                        <Icon className="w-4 h-4" />
                      </div>
                      <div>
                        <h5 className="text-xs font-bold text-gray-900 leading-snug">
                          {perk.title}
                        </h5>
                        <p className="text-[11px] text-gray-600 mt-1 leading-relaxed">
                          {perk.description}
                        </p>
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>
          </div>

          {/* Quick Eligibility Note */}
          <div className="bg-emerald-50/80 border border-emerald-200 rounded-xl p-4 flex items-start gap-3 text-xs text-emerald-950">
            <CheckCircle2 className="w-4 h-4 text-emerald-700 flex-shrink-0 mt-0.5" />
            <div>
              <span className="font-bold">Who qualifies: </span>
              Active or upcoming municipal pilots, nonprofit cash funds, corporate basic income programs, and Web3/protocol distribution experiments worldwide.
            </div>
          </div>
        </div>

        {/* Modal Footer / CTAs */}
        <div className="p-6 pt-0 sm:p-8 sm:pt-0 flex flex-col sm:flex-row items-center justify-between gap-3 border-t border-gray-100 mt-2">
          <Button
            variant="ghost"
            onClick={handleServicesClick}
            className="text-xs text-gray-600 hover:text-emerald-800 hover:bg-emerald-50 w-full sm:w-auto font-semibold order-2 sm:order-1"
          >
            <Building className="w-3.5 h-3.5 mr-1 text-emerald-700" />
            Explore Builder Advisory Services
          </Button>

          <Button
            onClick={handleSignUpClick}
            className="bg-emerald-700 hover:bg-emerald-800 text-white font-bold text-xs sm:text-sm py-5 px-6 shadow-md hover:shadow-lg transition-all rounded-xl w-full sm:w-auto flex items-center justify-center gap-2 order-1 sm:order-2"
          >
            Sign Up as a Project (Epoch 1)
            <ArrowRight className="w-4 h-4" />
          </Button>
        </div>

      </DialogContent>
    </Dialog>
  );
}
