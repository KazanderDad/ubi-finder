import React, { useState } from 'react';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Heart, Sparkles, ShieldCheck, Lock, Globe, CheckCircle2 } from 'lucide-react';
import { initiateStripeCheckout } from '@/lib/stripe';

export default function SupporterGateModal({ isOpen, user, featureName = "full program details and interactive map exploration" }) {
  const [selectedAmount, setSelectedAmount] = useState(5);
  const [customAmount, setCustomAmount] = useState('');
  const [isCustom, setIsCustom] = useState(false);
  const [loading, setLoading] = useState(false);

  if (!isOpen) return null;

  const handleSelectPreset = (amt) => {
    setSelectedAmount(amt);
    setIsCustom(false);
  };

  const handleCustomChange = (e) => {
    const val = e.target.value.replace(/[^0-9]/g, '');
    setCustomAmount(val);
    if (val && Number(val) > 0) {
      setSelectedAmount(Number(val));
      setIsCustom(true);
    }
  };

  const handleDonate = async () => {
    setLoading(true);
    const amountToCharge = isCustom ? Math.max(1, Number(customAmount || 1)) : selectedAmount;
    await initiateStripeCheckout({
      amountUsd: amountToCharge,
      user
    });
  };

  return (
    <Dialog open={isOpen} onOpenChange={() => {}}>
      <DialogContent 
        className="sm:max-w-lg p-0 overflow-hidden rounded-3xl border-emerald-300 shadow-2xl bg-white"
        onPointerDownOutside={(e) => e.preventDefault()}
        onEscapeKeyDown={(e) => e.preventDefault()}
      >
        {/* Header Hero */}
        <div className="bg-gradient-to-br from-emerald-700 via-teal-800 to-green-950 p-7 text-white text-center relative">
          <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-white/15 text-emerald-200 text-xs font-semibold mb-3 border border-white/20">
            <Sparkles className="w-3.5 h-3.5 text-amber-300" />
            <span>Volunteer-Powered Community</span>
          </div>

          <DialogTitle className="text-2xl font-extrabold tracking-tight text-white">
            Join Our Community of Supporters
          </DialogTitle>
          
          <DialogDescription className="text-emerald-100 text-xs sm:text-sm mt-2 max-w-sm mx-auto leading-relaxed">
            You're one of our most active researchers! UBI Finder is entirely volunteer-run and non-profit. A small contribution unlocks lifetime unlimited access for your account.
          </DialogDescription>
        </div>

        {/* Value Highlights */}
        <div className="px-6 pt-5 pb-2">
          <div className="grid grid-cols-3 gap-2 text-center text-xs py-2 bg-emerald-50/70 rounded-xl border border-emerald-100">
            <div className="p-1">
              <span className="font-bold text-emerald-950 block">100%</span>
              <span className="text-[10px] text-gray-600">Volunteer Run</span>
            </div>
            <div className="p-1 border-x border-emerald-200/60">
              <span className="font-bold text-emerald-950 block">290+</span>
              <span className="text-[10px] text-gray-600">Global Initiatives</span>
            </div>
            <div className="p-1">
              <span className="font-bold text-emerald-950 block">From $1</span>
              <span className="text-[10px] text-gray-600">Give What You Can</span>
            </div>
          </div>
        </div>

        {/* Contribution Selection */}
        <div className="p-6 pt-3 space-y-5">
          <div>
            <label className="text-xs font-bold text-gray-700 uppercase tracking-wider block mb-2.5">
              Choose Your Support Tier
            </label>
            <div className="grid grid-cols-3 gap-3">
              {[
                { amt: 5, title: 'Supporter', desc: 'Sustains server costs' },
                { amt: 50, title: 'Champion', desc: 'Funds data updates' },
                { amt: 500, title: 'Patron', desc: 'Expands global access' }
              ].map(({ amt, title, desc }) => (
                <button
                  key={amt}
                  type="button"
                  onClick={() => handleSelectPreset(amt)}
                  className={`p-3 rounded-2xl text-center border-2 font-bold transition-all ${
                    !isCustom && selectedAmount === amt
                      ? 'border-emerald-600 bg-emerald-50/90 text-emerald-950 shadow-md scale-[1.02]'
                      : 'border-gray-200 hover:border-emerald-300 text-gray-700 bg-white'
                  }`}
                >
                  <div className="text-lg font-extrabold text-emerald-900">${amt}</div>
                  <div className="text-xs font-semibold text-emerald-800 mt-0.5">{title}</div>
                  <div className="text-[10px] font-normal text-gray-500 mt-1 leading-tight">{desc}</div>
                </button>
              ))}
            </div>

            {/* Custom Amount */}
            <div className="mt-3.5">
              <div className="relative">
                <span className="absolute left-3.5 top-2.5 text-gray-500 font-bold text-sm">$</span>
                <Input
                  type="text"
                  placeholder="Custom amount (minimum $1)"
                  value={customAmount}
                  onChange={handleCustomChange}
                  onFocus={() => setIsCustom(true)}
                  className={`pl-8 text-sm rounded-xl py-2 ${
                    isCustom ? 'border-emerald-600 ring-1 ring-emerald-600' : 'border-gray-200'
                  }`}
                />
              </div>
            </div>
          </div>

          {/* Unlock Button */}
          <div className="space-y-2 pt-1">
            <Button
              onClick={handleDonate}
              disabled={loading}
              className="w-full py-6 text-base bg-emerald-600 hover:bg-emerald-700 text-white font-extrabold rounded-2xl shadow-lg flex items-center justify-center gap-2 transition-all hover:scale-[1.01]"
            >
              {loading ? (
                'Connecting to Stripe Checkout...'
              ) : (
                <>
                  <Heart className="w-5 h-5 text-pink-300 fill-pink-300" />
                  Contribute ${isCustom ? (customAmount || 1) : selectedAmount} & Unlock All Features
                </>
              )}
            </Button>
          </div>

          <div className="flex items-center justify-center gap-1.5 text-[11px] text-gray-500">
            <ShieldCheck className="w-3.5 h-3.5 text-emerald-600 flex-shrink-0" />
            <span>Direct Stripe integration. Instant lifetime access confirmation.</span>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}
