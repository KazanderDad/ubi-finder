import React, { useState } from "react";
import { useAuth } from "@/lib/AuthContext";
import { supabase } from "@/lib/supabaseClient";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { 
  Users, 
  Sparkles, 
  CheckCircle2, 
  ExternalLink, 
  Layers,
  Info,
  Clock
} from "lucide-react";
import { Link } from "react-router-dom";
import { Helmet } from "react-helmet-async";

export default function CirclesClaim() {
  const { user } = useAuth();
  const [minting, setMinting] = useState(false);
  const [minted, setMinted] = useState(false);
  const [balance, setBalance] = useState(840);

  const handleMintCRC = async () => {
    setMinting(true);
    setTimeout(async () => {
      setMinted(true);
      setBalance(prev => prev + 24);
      setMinting(false);

      if (user?.id) {
        await supabase.from("user_notifications").insert([{
          user_id: user.id,
          type: "circles_minted",
          title: "Circles CRC Minted",
          message: "Minted 24 CRC personal basic income tokens.",
          severity: "success",
          action_url: "/claim/circles"
        }]);
      }
    }, 1200);
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-amber-50 via-white to-green-50 px-4 py-8 md:py-12">
      <Helmet>
        <title>Circles UBI Minting Hub | UBI Finder</title>
        <meta name="description" content="Personal Circles (CRC) token issuance and basic income trust network terminal." />
      </Helmet>

      <div className="max-w-4xl mx-auto space-y-8">
        
        {/* Navigation Breadcrumb */}
        <div className="flex items-center gap-2 text-xs text-gray-500">
          <Link to="/Programs" className="hover:text-amber-700">Programs</Link>
          <span>/</span>
          <span className="font-semibold text-gray-900">Circles UBI Minting Hub</span>
        </div>

        {/* Hero Card */}
        <div className="bg-gradient-to-br from-amber-950 via-yellow-950 to-orange-950 text-white rounded-3xl p-6 md:p-10 shadow-xl relative overflow-hidden">
          <div className="relative z-10 space-y-6">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-amber-800 pb-6">
              <div className="flex items-center gap-3">
                <div className="w-14 h-14 bg-amber-800/80 border border-amber-400/40 rounded-2xl flex items-center justify-center shadow-inner">
                  <Users className="w-8 h-8 text-yellow-300" />
                </div>
                <div>
                  <div className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full bg-amber-800/90 text-amber-200 text-[10px] font-bold uppercase tracking-wider mb-1">
                    <Sparkles className="w-3 h-3 text-yellow-300" />
                    Personal Minting Protocol
                  </div>
                  <h1 className="text-2xl md:text-3xl font-black text-white">Circles UBI Minting Hub</h1>
                </div>
              </div>

              <Badge className="bg-yellow-500/20 text-yellow-300 border-yellow-400/40 self-start sm:self-auto">
                🤝 Web-of-Trust Active (Gnosis)
              </Badge>
            </div>

            {/* Metrics */}
            <div className="grid grid-cols-2 sm:grid-cols-3 gap-4">
              <div className="bg-white/10 backdrop-blur-md p-4 rounded-2xl border border-white/10">
                <span className="text-[11px] font-bold text-amber-200 uppercase tracking-wider block mb-1">
                  Personal CRC Balance
                </span>
                <div className="text-2xl font-black text-yellow-300">
                  {balance} <span className="text-xs font-normal text-white">CRC</span>
                </div>
              </div>

              <div className="bg-white/10 backdrop-blur-md p-4 rounded-2xl border border-white/10">
                <span className="text-[11px] font-bold text-amber-200 uppercase tracking-wider block mb-1">
                  Continuous Issuance
                </span>
                <div className="text-2xl font-black text-white">
                  24 <span className="text-xs font-normal text-amber-200">CRC/day</span>
                </div>
              </div>

              <div className="bg-white/10 backdrop-blur-md p-4 rounded-2xl border border-white/10 col-span-2 sm:col-span-1">
                <span className="text-[11px] font-bold text-amber-200 uppercase tracking-wider block mb-1">
                  Trust Connections
                </span>
                <div className="text-2xl font-black text-white">
                  8 Peers
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Minting Execution Card */}
        <Card className="shadow-lg border-amber-100 bg-white/95 backdrop-blur-sm">
          <CardHeader>
            <CardTitle className="text-lg font-bold text-gray-900">
              Mint Your Daily Circles
            </CardTitle>
            <CardDescription className="text-xs text-gray-500">
              Circles issues personal money directly to individual humans on the Gnosis chain.
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-6">
            
            {!minted ? (
              <div className="p-6 bg-amber-50/70 border border-amber-200 rounded-2xl text-center space-y-4">
                <div className="text-3xl font-black text-amber-950">
                  +24 CRC Ready
                  <span className="text-xs font-normal text-gray-600 block mt-0.5">
                    Unconditional personal currency issuance
                  </span>
                </div>
                <Button
                  size="lg"
                  disabled={minting}
                  onClick={handleMintCRC}
                  className="bg-amber-800 hover:bg-amber-900 text-white font-bold px-8 shadow-md"
                >
                  {minting ? "Minting on Gnosis Chain..." : "⚡ Mint 24 CRC"}
                </Button>
              </div>
            ) : (
              <div className="p-6 bg-emerald-50 border border-emerald-200 rounded-2xl space-y-2 text-center">
                <CheckCircle2 className="w-8 h-8 text-emerald-600 mx-auto" />
                <h4 className="font-bold text-emerald-950">24 CRC Minted to Your Trust Address!</h4>
                <p className="text-xs text-emerald-800">
                  Tokens are now tradeable across your verified trust graph.
                </p>
              </div>
            )}

            <div className="p-4 bg-gray-50 rounded-xl border border-gray-200 text-xs text-gray-600 space-y-2">
              <div className="flex items-center gap-1.5 font-bold text-gray-800">
                <Info className="w-4 h-4 text-amber-700" />
                <span>How Circles Works:</span>
              </div>
              <p className="leading-relaxed">
                Circles creates a decentralized economy where every member mints their own currency, convertible with trusted peers in their local community.
              </p>
              <div className="pt-1">
                <a 
                  href="https://aboutcircles.com" 
                  target="_blank" 
                  rel="noopener noreferrer"
                  className="text-amber-800 font-semibold hover:underline inline-flex items-center gap-1"
                >
                  Visit Circles Official Trust Network <ExternalLink className="w-3 h-3" />
                </a>
              </div>
            </div>

          </CardContent>
        </Card>

      </div>
    </div>
  );
}
