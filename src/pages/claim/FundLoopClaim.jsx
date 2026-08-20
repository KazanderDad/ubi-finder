import React, { useState } from "react";
import { useAuth } from "@/lib/AuthContext";
import { supabase } from "@/lib/supabaseClient";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { 
  Zap, 
  Sparkles, 
  TrendingUp, 
  CheckCircle2, 
  ExternalLink, 
  ShieldCheck, 
  Clock, 
  Layers,
  Info
} from "lucide-react";
import { Link } from "react-router-dom";
import { Helmet } from "react-helmet-async";

export default function FundLoopClaim() {
  const { user } = useAuth();
  const [claiming, setClaiming] = useState(false);
  const [claimed, setClaimed] = useState(false);
  const [accruedReward, setAccruedReward] = useState(48.50);
  const [streamRatePerSecond] = useState(0.00056);

  const handleClaimYield = async () => {
    setClaiming(true);
    setTimeout(async () => {
      setClaimed(true);
      setAccruedReward(0);
      setClaiming(false);

      if (user?.id) {
        await supabase.from("user_notifications").insert([{
          user_id: user.id,
          type: "yield_claimed",
          title: "FundLoop Yield Dividend Claimed",
          message: "Successfully claimed $48.50 USD in continuous streaming basic income.",
          severity: "success",
          action_url: "/claim/fundloop"
        }]);
      }
    }, 1200);
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-blue-50 via-white to-green-50 px-4 py-8 md:py-12">
      <Helmet>
        <title>FundLoop Continuous Yield Terminal | UBI Finder</title>
        <meta name="description" content="Streaming yield basic income distributor terminal for FundLoop." />
      </Helmet>

      <div className="max-w-4xl mx-auto space-y-8">
        
        {/* Navigation Breadcrumb */}
        <div className="flex items-center gap-2 text-xs text-gray-500">
          <Link to="/Programs" className="hover:text-blue-700">Programs</Link>
          <span>/</span>
          <span className="font-semibold text-gray-900">FundLoop Streaming Terminal</span>
        </div>

        {/* Hero Card */}
        <div className="bg-gradient-to-br from-blue-950 via-slate-900 to-indigo-950 text-white rounded-3xl p-6 md:p-10 shadow-xl relative overflow-hidden">
          <div className="relative z-10 space-y-6">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-blue-800 pb-6">
              <div className="flex items-center gap-3">
                <div className="w-14 h-14 bg-blue-800/80 border border-blue-400/40 rounded-2xl flex items-center justify-center shadow-inner">
                  <Zap className="w-8 h-8 text-cyan-300" />
                </div>
                <div>
                  <div className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full bg-blue-800/90 text-blue-200 text-[10px] font-bold uppercase tracking-wider mb-1">
                    <Sparkles className="w-3 h-3 text-cyan-300" />
                    Continuous Stream Protocol
                  </div>
                  <h1 className="text-2xl md:text-3xl font-black text-white">FundLoop Yield Streamer</h1>
                </div>
              </div>

              <Badge className="bg-cyan-500/20 text-cyan-300 border-cyan-400/40 self-start sm:self-auto">
                🌊 Streaming Active
              </Badge>
            </div>

            {/* Metrics */}
            <div className="grid grid-cols-2 sm:grid-cols-3 gap-4">
              <div className="bg-white/10 backdrop-blur-md p-4 rounded-2xl border border-white/10">
                <span className="text-[11px] font-bold text-blue-200 uppercase tracking-wider block mb-1">
                  Accrued Dividends
                </span>
                <div className="text-2xl font-black text-cyan-300">
                  ${accruedReward.toFixed(2)} <span className="text-xs font-normal text-white">USD</span>
                </div>
              </div>

              <div className="bg-white/10 backdrop-blur-md p-4 rounded-2xl border border-white/10">
                <span className="text-[11px] font-bold text-blue-200 uppercase tracking-wider block mb-1">
                  Streaming Velocity
                </span>
                <div className="text-2xl font-black text-white">
                  ~$150 <span className="text-xs font-normal text-blue-200">USD/mo</span>
                </div>
              </div>

              <div className="bg-white/10 backdrop-blur-md p-4 rounded-2xl border border-white/10 col-span-2 sm:col-span-1">
                <span className="text-[11px] font-bold text-blue-200 uppercase tracking-wider block mb-1">
                  Yield Source
                </span>
                <div className="text-sm font-bold text-white flex items-center gap-1 mt-1">
                  <TrendingUp className="w-4 h-4 text-emerald-400" />
                  RWA Treasury Yield
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Claim Card */}
        <Card className="shadow-lg border-blue-100 bg-white/95 backdrop-blur-sm">
          <CardHeader>
            <CardTitle className="text-lg font-bold text-gray-900">
              Claim Streaming Yield Dividend
            </CardTitle>
            <CardDescription className="text-xs text-gray-500">
              FundLoop turns perpetual treasury yield streams into unconditional basic income for qualified ecosystem participants.
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-6">
            
            {!claimed ? (
              <div className="p-6 bg-blue-50/70 border border-blue-200 rounded-2xl text-center space-y-4">
                <div className="text-3xl font-black text-blue-950">
                  ${accruedReward.toFixed(2)} USD
                  <span className="text-xs font-normal text-gray-600 block mt-0.5">
                    Ready for immediate payout claim
                  </span>
                </div>
                <Button
                  size="lg"
                  disabled={claiming}
                  onClick={handleClaimYield}
                  className="bg-blue-800 hover:bg-blue-900 text-white font-bold px-8 shadow-md"
                >
                  {claiming ? "Processing Stream Settlement..." : "⚡ Claim Accrued Yield"}
                </Button>
              </div>
            ) : (
              <div className="p-6 bg-emerald-50 border border-emerald-200 rounded-2xl space-y-2 text-center">
                <CheckCircle2 className="w-8 h-8 text-emerald-600 mx-auto" />
                <h4 className="font-bold text-emerald-950">Yield Successfully Claimed!</h4>
                <p className="text-xs text-emerald-800">
                  Your stream continues to accrue in real-time. Next payout batch settles daily.
                </p>
              </div>
            )}

            <div className="p-4 bg-gray-50 rounded-xl border border-gray-200 text-xs text-gray-600 space-y-2">
              <div className="flex items-center gap-1.5 font-bold text-gray-800">
                <Info className="w-4 h-4 text-blue-700" />
                <span>About FundLoop Streaming Payouts:</span>
              </div>
              <p className="leading-relaxed">
                FundLoop deposits yield from sustainable treasury endowments directly into user balances on a continuous per-second basis.
              </p>
            </div>

          </CardContent>
        </Card>

      </div>
    </div>
  );
}
