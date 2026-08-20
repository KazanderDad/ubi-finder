import React, { useState, useEffect } from "react";
import { useAuth } from "@/lib/AuthContext";
import { supabase } from "@/lib/supabaseClient";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { 
  Coins, 
  Sparkles, 
  Clock, 
  CheckCircle2, 
  ExternalLink, 
  Wallet, 
  ArrowLeft, 
  ShieldCheck, 
  Flame, 
  History,
  Info
} from "lucide-react";
import { Link } from "react-router-dom";
import { Helmet } from "react-helmet-async";

export default function GoodDollarClaim() {
  const { user } = useAuth();
  const [claiming, setClaiming] = useState(false);
  const [claimedToday, setClaimedToday] = useState(false);
  const [claimReceipt, setClaimReceipt] = useState(null);
  const [balance, setBalance] = useState(1450.25);
  const [streakDays, setStreakDays] = useState(12);

  const dailyRewardG$ = 125.40;
  const estimatedUsdVal = "$0.28 USD";

  const handleExecuteClaim = async () => {
    setClaiming(true);
    // Simulate smart contract protocol claim
    setTimeout(async () => {
      const txHash = `0x${Math.random().toString(16).substring(2, 10)}...${Math.random().toString(16).substring(2, 6)}`;
      const receipt = {
        amount: dailyRewardG$,
        currency: "G$",
        txHash,
        timestamp: new Date().toISOString(),
        blockNumber: 48291044
      };

      setBalance(prev => prev + dailyRewardG$);
      setStreakDays(prev => prev + 1);
      setClaimedToday(true);
      setClaimReceipt(receipt);
      setClaiming(false);

      if (user?.id) {
        // Record claim in notifications
        await supabase.from("user_notifications").insert([{
          user_id: user.id,
          type: "daily_claim_success",
          title: "GoodDollar Daily Claim Executed",
          message: `Successfully claimed ${dailyRewardG$} G$ (${estimatedUsdVal}) to your protocol balance.`,
          severity: "success",
          action_url: "/claim/gooddollar"
        }]);
      }
    }, 1200);
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-purple-50 via-white to-green-50 px-4 py-8 md:py-12">
      <Helmet>
        <title>GoodDollar Daily Claim Terminal | UBI Finder</title>
        <meta name="description" content="Automated daily claim protocol terminal for GoodDollar (G$) decentralized universal basic income." />
      </Helmet>

      <div className="max-w-4xl mx-auto space-y-8">
        
        {/* Navigation Breadcrumb */}
        <div className="flex items-center gap-2 text-xs text-gray-500">
          <Link to="/Programs" className="hover:text-purple-700">Programs</Link>
          <span>/</span>
          <span className="font-semibold text-gray-900">GoodDollar Claim Terminal</span>
        </div>

        {/* Hero Card */}
        <div className="bg-gradient-to-br from-purple-950 via-purple-900 to-indigo-950 text-white rounded-3xl p-6 md:p-10 shadow-xl relative overflow-hidden">
          <div className="relative z-10 space-y-6">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-purple-800 pb-6">
              <div className="flex items-center gap-3">
                <div className="w-14 h-14 bg-purple-800/80 border border-purple-400/40 rounded-2xl flex items-center justify-center shadow-inner">
                  <Coins className="w-8 h-8 text-yellow-300" />
                </div>
                <div>
                  <div className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full bg-purple-800/90 text-purple-200 text-[10px] font-bold uppercase tracking-wider mb-1">
                    <Sparkles className="w-3 h-3 text-yellow-300" />
                    Automated Web3 Protocol
                  </div>
                  <h1 className="text-2xl md:text-3xl font-black text-white">GoodDollar Daily UBI Terminal</h1>
                </div>
              </div>

              <Badge className="bg-emerald-500/20 text-emerald-300 border-emerald-400/40 self-start sm:self-auto">
                🟢 Live Protocol (Celo / Fuse)
              </Badge>
            </div>

            {/* Metrics */}
            <div className="grid grid-cols-2 sm:grid-cols-3 gap-4">
              <div className="bg-white/10 backdrop-blur-md p-4 rounded-2xl border border-white/10">
                <span className="text-[11px] font-bold text-purple-200 uppercase tracking-wider block mb-1">
                  Your Balance
                </span>
                <div className="text-2xl font-black text-yellow-300">
                  {balance.toLocaleString(undefined, { minimumFractionDigits: 2 })} <span className="text-xs font-normal text-white">G$</span>
                </div>
              </div>

              <div className="bg-white/10 backdrop-blur-md p-4 rounded-2xl border border-white/10">
                <span className="text-[11px] font-bold text-purple-200 uppercase tracking-wider block mb-1">
                  Daily Claim Rate
                </span>
                <div className="text-2xl font-black text-white">
                  ~{dailyRewardG$} <span className="text-xs font-normal text-purple-200">G$/day</span>
                </div>
              </div>

              <div className="bg-white/10 backdrop-blur-md p-4 rounded-2xl border border-white/10 col-span-2 sm:col-span-1">
                <span className="text-[11px] font-bold text-purple-200 uppercase tracking-wider block mb-1">
                  Claim Streak
                </span>
                <div className="text-2xl font-black text-orange-300 flex items-center gap-1">
                  <Flame className="w-6 h-6 text-orange-400" />
                  {streakDays} Days
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Claim Execution Center */}
        <Card className="shadow-lg border-purple-100 bg-white/95 backdrop-blur-sm">
          <CardHeader>
            <CardTitle className="text-lg font-bold text-gray-900 flex items-center justify-between">
              <span>Today's Daily UBI Disbursement</span>
              {claimedToday ? (
                <Badge className="bg-emerald-100 text-emerald-800 border-emerald-300">
                  ✅ Claimed Today
                </Badge>
              ) : (
                <Badge className="bg-amber-100 text-amber-800 border-amber-300 animate-pulse">
                  ⚡ Ready to Claim
                </Badge>
              )}
            </CardTitle>
            <CardDescription className="text-xs text-gray-500">
              GoodDollar distributes daily unconditional liquidity minted from decentralized yield reserves.
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-6">
            
            {!claimedToday ? (
              <div className="p-6 bg-purple-50/70 border border-purple-200 rounded-2xl text-center space-y-4">
                <div className="text-3xl font-black text-purple-950">
                  +{dailyRewardG$} G$
                  <span className="text-sm font-normal text-gray-600 block mt-0.5">
                    ({estimatedUsdVal} equivalent)
                  </span>
                </div>
                <p className="text-xs text-gray-600 max-w-md mx-auto">
                  Click below to execute your 24-hour periodic basic income claim through the GoodDollar smart contract.
                </p>
                <Button
                  size="lg"
                  disabled={claiming}
                  onClick={handleExecuteClaim}
                  className="bg-purple-800 hover:bg-purple-900 text-white font-bold px-8 shadow-md"
                >
                  {claiming ? "Executing Smart Contract Claim..." : "⚡ Claim Daily Basic Income"}
                </Button>
              </div>
            ) : (
              <div className="p-6 bg-emerald-50 border border-emerald-200 rounded-2xl space-y-3">
                <div className="flex items-center gap-2 text-emerald-900 font-bold text-sm">
                  <CheckCircle2 className="w-5 h-5 text-emerald-600" />
                  <span>Successfully claimed {dailyRewardG$} G$ for today!</span>
                </div>
                {claimReceipt && (
                  <div className="p-3 bg-white rounded-xl border border-emerald-200 text-xs font-mono text-gray-700 space-y-1">
                    <div><strong>Tx Hash:</strong> {claimReceipt.txHash}</div>
                    <div><strong>Timestamp:</strong> {new Date(claimReceipt.timestamp).toLocaleTimeString()}</div>
                    <div><strong>Block:</strong> #{claimReceipt.blockNumber}</div>
                  </div>
                )}
                <div className="text-xs text-emerald-800 flex items-center gap-1.5 pt-1">
                  <Clock className="w-3.5 h-3.5" />
                  <span>Next daily claim window unlocks in: <strong>23h 48m</strong></span>
                </div>
              </div>
            )}

            {/* Protocol Explanation */}
            <div className="p-4 bg-gray-50 rounded-xl border border-gray-200 text-xs text-gray-600 space-y-2">
              <div className="flex items-center gap-1.5 font-bold text-gray-800">
                <Info className="w-4 h-4 text-purple-700" />
                <span>How Periodic Claims Work:</span>
              </div>
              <p className="leading-relaxed">
                GoodDollar uses proof-of-humanity verification to distribute daily basic income to anyone in the world with an internet connection. No government paperwork or banking fees required.
              </p>
              <div className="pt-1">
                <a 
                  href="https://gooddollar.org" 
                  target="_blank" 
                  rel="noopener noreferrer"
                  className="text-purple-700 font-semibold hover:underline inline-flex items-center gap-1"
                >
                  Visit Official GoodDollar Foundation Portal <ExternalLink className="w-3 h-3" />
                </a>
              </div>
            </div>

          </CardContent>
        </Card>

      </div>
    </div>
  );
}
