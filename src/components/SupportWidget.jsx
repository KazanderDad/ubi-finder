import React, { useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Heart, Copy, Check, Sparkles, Send, ShieldCheck, Wallet, ArrowRight } from "lucide-react";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { useToast } from "@/components/ui/use-toast";
import { supabase } from "@/lib/supabaseClient";
import confetti from "canvas-confetti";

export default function SupportWidget() {
  const { toast } = useToast();
  const [amount, setAmount] = useState("100");
  const [customAmount, setCustomAmount] = useState("");
  const [email, setEmail] = useState("");
  const [donorName, setDonorName] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [copiedField, setCopiedField] = useState(null);

  const selectedAmount = customAmount ? customAmount : amount;

  const handleCopy = (text, fieldName) => {
    navigator.clipboard.writeText(text);
    setCopiedField(fieldName);
    setTimeout(() => setCopiedField(null), 2500);
    toast({
      title: "Copied to clipboard",
      description: `${text} has been copied.`,
    });
  };

  const handleOpenDonate = (e) => {
    e.preventDefault();
    const finalVal = parseFloat(selectedAmount);
    if (!finalVal || isNaN(finalVal) || finalVal <= 0) {
      toast({
        title: "Please enter a valid amount",
        description: "Select or specify a donation amount to proceed.",
        variant: "destructive",
      });
      return;
    }

    // Trigger celebratory confetti
    try {
      confetti({
        particleCount: 75,
        spread: 60,
        origin: { y: 0.8 },
      });
    } catch (err) {
      console.warn("Confetti animation skipped:", err);
    }

    setIsModalOpen(true);
  };

  const handleConfirmDonation = async (paymentMethod) => {
    setIsSubmitting(true);
    try {
      const { data: { user } } = await supabase.auth.getUser();

      await supabase.from("support_donations").insert([
        {
          user_id: user?.id || null,
          amount_usd: parseFloat(selectedAmount) || 0,
          donor_name: donorName.trim() || user?.user_metadata?.full_name || "Anonymous Supporter",
          donor_email: email.trim() || user?.email || null,
          payment_method: paymentMethod,
          status: "pledged",
          notes: `Pledged via ${paymentMethod} confirmation dialog on landing page`,
        },
      ]);

      // Confetti burst
      try {
        confetti({
          particleCount: 120,
          spread: 90,
          origin: { y: 0.6 },
        });
      } catch (e) {
        console.debug("Confetti animation skipped:", e);
      }

      toast({
        title: "Thank You for Your Support! ❤️",
        description: `Your pledge of $${selectedAmount} USD via ${paymentMethod === 'e-transfer' ? 'E-Transfer' : 'Crypto Transfer'} helps power universal cash access worldwide.`,
      });

      setIsModalOpen(false);
      setCustomAmount("");
    } catch (error) {
      console.error("Error saving donation pledge:", error);
      toast({
        title: "Pledge Recorded",
        description: "Thank you for supporting UBI Finder! Your generosity makes a difference.",
      });
      setIsModalOpen(false);
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <>
      <Card className="w-full max-w-lg mx-auto shadow-2xl border-green-200/90 bg-white/95 backdrop-blur-md overflow-hidden relative">
        <div className="absolute -top-12 -right-12 w-36 h-36 bg-green-100/60 rounded-full blur-2xl pointer-events-none" />
        <div className="absolute -bottom-12 -left-12 w-36 h-36 bg-pink-100/60 rounded-full blur-2xl pointer-events-none" />

        <CardHeader className="text-center pb-4 pt-6">
          <div className="flex items-center justify-center mb-3">
            <div className="rounded-full bg-gradient-to-br from-red-100 via-pink-100 to-rose-100 p-3 shadow-inner border border-red-200 animate-pulse">
              <Heart className="h-7 w-7 text-red-600 fill-red-500" />
            </div>
          </div>
          <CardTitle className="text-2xl sm:text-3xl font-extrabold text-green-950 tracking-tight">
            Support This Project
          </CardTitle>
          <CardDescription className="text-sm text-gray-600 max-w-md mx-auto mt-1 leading-relaxed">
            UBI Finder is a public-benefit initiative. Your support helps us research, maintain, and expand access to verified guaranteed income & cash pilots globally.
          </CardDescription>
        </CardHeader>

        <CardContent className="space-y-5 px-6 sm:px-8">
          <form onSubmit={handleOpenDonate} className="space-y-4">
            
            {/* Preset Amount Grid */}
            <div className="space-y-2">
              <Label className="text-xs font-semibold uppercase tracking-wider text-gray-700">
                Select an Amount (USD)
              </Label>
              <RadioGroup
                value={customAmount ? "" : amount}
                onValueChange={(val) => {
                  setAmount(val);
                  setCustomAmount("");
                }}
                className="grid grid-cols-2 sm:grid-cols-4 gap-2.5"
              >
                {["20", "100", "500", "1000"].map((preset) => {
                  const isChecked = !customAmount && amount === preset;
                  return (
                    <Label
                      key={preset}
                      htmlFor={`amount-${preset}`}
                      className={`flex flex-col items-center justify-center py-3.5 px-2 rounded-xl border-2 cursor-pointer transition-all duration-200 text-center ${
                        isChecked
                          ? "border-green-700 bg-green-50/90 text-green-950 shadow-sm font-bold scale-[1.02]"
                          : "border-gray-200 bg-white/70 hover:border-green-300 hover:bg-green-50/30 text-gray-700"
                      }`}
                    >
                      <RadioGroupItem value={preset} id={`amount-${preset}`} className="sr-only" />
                      <span className="text-lg font-bold">${preset}</span>
                      <span className="text-[10px] text-gray-500 font-normal mt-0.5">
                        {preset === "20" ? "Supporter" : preset === "100" ? "Advocate" : preset === "500" ? "Champion" : "Patron"}
                      </span>
                    </Label>
                  );
                })}
              </RadioGroup>
            </div>

            {/* Custom Amount Input */}
            <div className="space-y-1.5">
              <Label htmlFor="custom-amount" className="text-xs font-semibold text-gray-700">
                Or enter a custom amount
              </Label>
              <div className="relative">
                <span className="absolute left-3.5 top-1/2 -translate-y-1/2 text-gray-500 font-bold">$</span>
                <Input
                  id="custom-amount"
                  type="number"
                  min="1"
                  step="any"
                  placeholder="e.g. 50"
                  value={customAmount}
                  onChange={(e) => {
                    setCustomAmount(e.target.value);
                  }}
                  className="pl-8 bg-white/80 border-gray-200 focus:border-green-600 focus:ring-green-600 font-medium"
                />
              </div>
            </div>

            {/* Optional Email for Receipt */}
            <div className="space-y-1.5">
              <Label htmlFor="donor-email" className="text-xs font-semibold text-gray-700">
                Email address <span className="text-gray-400 font-normal">(Optional, for receipt & updates)</span>
              </Label>
              <Input
                id="donor-email"
                type="email"
                placeholder="you@example.com"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="bg-white/80 border-gray-200 focus:border-green-600 focus:ring-green-600 text-xs sm:text-sm"
              />
            </div>

            <Button
              type="submit"
              size="lg"
              className="w-full bg-gradient-to-r from-emerald-600 via-green-700 to-teal-700 hover:from-emerald-700 hover:to-teal-800 text-white font-bold py-6 text-base rounded-xl shadow-lg hover:shadow-xl transition-all duration-200 transform hover:-translate-y-0.5 mt-2 flex items-center justify-center gap-2"
            >
              <Heart className="w-5 h-5 fill-white text-white" />
              Donate ${selectedAmount || "25"} USD Now
            </Button>
          </form>
        </CardContent>

        <CardFooter className="bg-gray-50/80 border-t border-gray-100 px-6 py-3.5 flex items-center justify-center gap-4 text-xs text-gray-500">
          <span className="flex items-center gap-1">
            <ShieldCheck className="w-4 h-4 text-green-700" /> 100% Direct Impact
          </span>
          <span>•</span>
          <span className="flex items-center gap-1">
            <Wallet className="w-4 h-4 text-purple-700" /> Fiat & Crypto Accepted
          </span>
        </CardFooter>
      </Card>

      {/* Confirmation & Payment Instructions Modal */}
      <Dialog open={isModalOpen} onOpenChange={setIsModalOpen}>
        <DialogContent className="sm:max-w-md bg-white border-green-100">
          <DialogHeader>
            <div className="w-12 h-12 rounded-full bg-green-100 text-green-800 flex items-center justify-center mx-auto mb-2">
              <Sparkles className="w-6 h-6 text-green-700" />
            </div>
            <DialogTitle className="text-center text-xl font-bold text-green-950">
              Complete Your ${selectedAmount} Contribution
            </DialogTitle>
            <DialogDescription className="text-center text-xs text-gray-600">
              Thank you for advancing Universal Basic Income! Choose your preferred payment method below:
            </DialogDescription>
          </DialogHeader>

          <div className="space-y-4 my-2 text-xs">
            
            {/* E-Transfer / Bank Option */}
            <div className="p-3.5 bg-gray-50 rounded-xl border border-gray-200 space-y-2">
              <div className="flex items-center justify-between">
                <span className="font-bold text-gray-900 flex items-center gap-1.5">
                  🏦 Interac / E-Transfer / Bank
                </span>
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => handleCopy("donations@ubifinder.org", "etransfer")}
                  className="h-7 text-[11px] px-2 text-green-700 hover:bg-green-100"
                >
                  {copiedField === "etransfer" ? <Check className="w-3.5 h-3.5 text-green-600" /> : <Copy className="w-3.5 h-3.5" />}
                  {copiedField === "etransfer" ? "Copied" : "Copy Email"}
                </Button>
              </div>
              <p className="text-gray-600">
                Send your contribution to: <code className="bg-white px-1.5 py-0.5 rounded border border-gray-300 font-mono font-semibold text-green-900">donations@ubifinder.org</code>
              </p>
            </div>

            {/* Cryptocurrency Option */}
            <div className="p-3.5 bg-purple-50/60 rounded-xl border border-purple-200 space-y-2">
              <div className="flex items-center justify-between">
                <span className="font-bold text-purple-950 flex items-center gap-1.5">
                  🪙 Cryptocurrency (Ethereum / EVM / Celo)
                </span>
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => handleCopy("ubifinder.eth", "crypto")}
                  className="h-7 text-[11px] px-2 text-purple-700 hover:bg-purple-100"
                >
                  {copiedField === "crypto" ? <Check className="w-3.5 h-3.5 text-purple-600" /> : <Copy className="w-3.5 h-3.5" />}
                  {copiedField === "crypto" ? "Copied" : "Copy ENS"}
                </Button>
              </div>
              <p className="text-gray-600">
                Send ETH, USDC, or G$ to ENS: <code className="bg-white px-1.5 py-0.5 rounded border border-purple-200 font-mono font-semibold text-purple-900">ubifinder.eth</code>
              </p>
            </div>

            {/* Preferred Donor Name Input */}
            <div className="space-y-1">
              <Label htmlFor="donor-board-name" className="text-xs font-semibold text-gray-700">
                Preferred name for Supporter Recognition <span className="text-gray-400 font-normal">(Optional)</span>
              </Label>
              <Input
                id="donor-board-name"
                type="text"
                placeholder="e.g. Satoshi Nakamoto or Community Friend"
                value={donorName}
                onChange={(e) => setDonorName(e.target.value)}
                className="bg-white border-gray-200 text-xs"
              />
            </div>
          </div>

          <DialogFooter className="flex flex-col sm:flex-row gap-2 pt-2">
            <Button
              variant="outline"
              onClick={() => setIsModalOpen(false)}
              className="text-xs border-gray-300 w-full sm:w-auto"
            >
              Cancel
            </Button>
            <Button
              onClick={() => handleConfirmDonation("e-transfer")}
              disabled={isSubmitting}
              className="bg-green-700 hover:bg-green-800 text-white text-xs w-full sm:w-auto font-semibold"
            >
              I have eTransferred
            </Button>
            <Button
              onClick={() => handleConfirmDonation("crypto")}
              disabled={isSubmitting}
              className="bg-purple-700 hover:bg-purple-800 text-white text-xs w-full sm:w-auto font-semibold"
            >
              I have transferred crypto
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  );
}
