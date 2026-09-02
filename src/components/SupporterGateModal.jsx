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
import { Heart, Sparkles, ShieldCheck, Lock, Globe, CheckCircle2, Bell, Zap, FileText } from 'lucide-react';
import StripeCheckoutModal from '@/components/StripeCheckoutModal';

export default function SupporterGateModal({ isOpen, user, featureName = "full program details and interactive map exploration" }) {
  const [selectedAmount, setSelectedAmount] = useState(5);
  const [customAmount, setCustomAmount] = useState('');
  const [isCustom, setIsCustom] = useState(false);
  const [stripeModalOpen, setStripeModalOpen] = useState(false);

  if (!isOpen && !stripeModalOpen) return null;

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

  const effectiveAmount = isCustom ? Math.max(1, Number(customAmount || 1)) : selectedAmount;

  return (
    <>
      <Dialog open={isOpen && !stripeModalOpen} onOpenChange={() => {}}>
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
            
            <DialogDescription className="text-emerald-100 text-sm sm:text-base mt-2.5 max-w-sm mx-auto leading-relaxed font-normal">
              You're one of our most active researchers! UBI Finder is entirely volunteer-run and non-profit. A contribution starting at just $1 unlocks lifetime unlimited access for your account.
            </DialogDescription>
          </div>

          {/* Benefits List */}
          <div className="px-6 pt-4 pb-1">
            <div className="bg-emerald-50/80 p-3.5 rounded-2xl border border-emerald-100 space-y-2">
              <div className="font-bold text-xs text-emerald-950 flex items-center gap-1.5">
                <Sparkles className="w-4 h-4 text-emerald-700" />
                <span>Supporter Membership Benefits</span>
              </div>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-2 text-[11px] text-gray-700">
                <div className="flex items-start gap-1.5">
                  <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600 flex-shrink-0 mt-0.5" />
                  <span><strong>Custom Report:</strong> Unlimited personalized match scoring.</span>
                </div>
                <div className="flex items-start gap-1.5">
                  <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600 flex-shrink-0 mt-0.5" />
                  <span><strong>Opportunity Alerts:</strong> Email alerts when new pilots open.</span>
                </div>
                <div className="flex items-start gap-1.5">
                  <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600 flex-shrink-0 mt-0.5" />
                  <span><strong>Interactive Map:</strong> Full popup deep links & criteria.</span>
                </div>
                <div className="flex items-start gap-1.5">
                  <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600 flex-shrink-0 mt-0.5" />
                  <span><strong>Early Access:</strong> 1-click auto-enrollment in eligible programs.</span>
                </div>
              </div>
            </div>
          </div>

          {/* Contribution Selection */}
          <div className="p-6 pt-3 space-y-4">
            <div>
              <h3 className="text-base font-bold text-gray-900 mb-0.5">
                Please consider donating
              </h3>
              
              <label className="text-[11px] font-medium text-gray-500 block mb-2.5">
                Select a Contribution Amount
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
                onClick={() => setStripeModalOpen(true)}
                className="w-full py-6 text-base bg-emerald-600 hover:bg-emerald-700 text-white font-extrabold rounded-2xl shadow-lg flex items-center justify-center gap-2 transition-all hover:scale-[1.01]"
              >
                <Heart className="w-5 h-5 text-pink-300 fill-pink-300" />
                Contribute ${effectiveAmount} via Stripe
              </Button>
            </div>

            <div className="flex items-center justify-center gap-1.5 text-[11px] text-gray-500">
              <ShieldCheck className="w-3.5 h-3.5 text-emerald-600 flex-shrink-0" />
              <span>Direct Stripe integration. Instant lifetime access confirmation.</span>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* Direct Stripe Checkout Modal */}
      <StripeCheckoutModal
        isOpen={stripeModalOpen}
        onClose={() => setStripeModalOpen(false)}
        amountUsd={effectiveAmount}
        user={user}
      />
    </>
  );
}
