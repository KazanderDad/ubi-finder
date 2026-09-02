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
import { Heart, Sparkles, ShieldCheck, ArrowRight, X, Bell, Zap, FileText, CheckCircle2 } from 'lucide-react';
import { markEncouragementDismissed } from '@/lib/supporterPoints';
import StripeCheckoutModal from '@/components/StripeCheckoutModal';

export default function DonationEncouragementModal({ isOpen, onClose, user }) {
  const [selectedAmount, setSelectedAmount] = useState(5);
  const [customAmount, setCustomAmount] = useState('');
  const [isCustom, setIsCustom] = useState(false);
  const [stripeModalOpen, setStripeModalOpen] = useState(false);

  if (!isOpen && !stripeModalOpen) return null;

  const handleClose = () => {
    markEncouragementDismissed(user);
    onClose();
  };

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

  const handleDonateClick = () => {
    markEncouragementDismissed(user);
    setStripeModalOpen(true);
  };

  const effectiveAmount = isCustom ? Math.max(1, Number(customAmount || 1)) : selectedAmount;

  return (
    <>
      <Dialog open={isOpen && !stripeModalOpen} onOpenChange={handleClose}>
        <DialogContent className="sm:max-w-md p-0 overflow-hidden rounded-3xl border-emerald-200 shadow-2xl bg-white">
          {/* Header Banner */}
          <div className="bg-gradient-to-br from-emerald-600 via-teal-700 to-green-800 p-6 sm:p-7 text-white text-center relative">
            <button 
              onClick={handleClose}
              className="absolute top-4 right-4 text-white/80 hover:text-white p-1 rounded-full hover:bg-white/10 transition-colors"
            >
              <X className="w-5 h-5" />
            </button>
            
            <div className="w-12 h-12 bg-white/20 backdrop-blur-md rounded-2xl flex items-center justify-center mx-auto mb-3 shadow-inner">
              <Heart className="w-6 h-6 text-pink-300 fill-pink-300" />
            </div>

            <DialogTitle className="text-xl sm:text-2xl font-extrabold tracking-tight text-white">
              Enjoying UBI Finder?
            </DialogTitle>
            
            <DialogDescription className="text-emerald-50 text-sm sm:text-base mt-2.5 max-w-sm mx-auto leading-relaxed font-normal">
              This platform is 100% volunteer-run and open-source. Help us keep universal basic income data free and accessible for everyone.
            </DialogDescription>
          </div>

          {/* Benefits Grid */}
          <div className="px-6 pt-4 pb-0">
            <div className="bg-emerald-50/70 p-3 rounded-2xl border border-emerald-100 space-y-1.5 text-xs text-emerald-950">
              <div className="font-bold text-[11px] uppercase tracking-wider text-emerald-800 flex items-center gap-1.5">
                <Sparkles className="w-3.5 h-3.5 text-amber-500" />
                <span>What Your Contribution Unlocks</span>
              </div>
              <ul className="space-y-1 text-[11px] text-gray-700 leading-snug">
                <li className="flex items-center gap-1.5">
                  <CheckCircle2 className="w-3 h-3 text-emerald-600 flex-shrink-0" />
                  <span><strong>Full Platform Access:</strong> Complete criteria & direct application links.</span>
                </li>
                <li className="flex items-center gap-1.5">
                  <CheckCircle2 className="w-3 h-3 text-emerald-600 flex-shrink-0" />
                  <span><strong>Opportunity Alerts:</strong> Email notifications when new programs open.</span>
                </li>
                <li className="flex items-center gap-1.5">
                  <CheckCircle2 className="w-3 h-3 text-emerald-600 flex-shrink-0" />
                  <span><strong>Early Access:</strong> Upcoming auto-enrollment into eligible programs.</span>
                </li>
              </ul>
            </div>
          </div>

          {/* Content Body */}
          <div className="p-6 pt-3 space-y-4">
            <div>
              <h3 className="text-base font-bold text-gray-900 mb-0.5">
                Please consider donating
              </h3>
              
              <label className="text-[11px] font-medium text-gray-500 block mb-2.5">
                Select a Contribution Amount
              </label>

              <div className="grid grid-cols-3 gap-2.5">
                {[5, 50, 500].map((amt) => (
                  <button
                    key={amt}
                    type="button"
                    onClick={() => handleSelectPreset(amt)}
                    className={`py-3 px-2 rounded-xl text-center border-2 font-bold transition-all ${
                      !isCustom && selectedAmount === amt
                        ? 'border-emerald-600 bg-emerald-50 text-emerald-900 shadow-sm scale-[1.02]'
                        : 'border-gray-200 hover:border-emerald-300 text-gray-700 bg-white'
                    }`}
                  >
                    <div className="text-base">${amt}</div>
                    <div className="text-[10px] font-normal text-gray-500 mt-0.5">
                      {amt === 5 ? 'Supporter' : amt === 50 ? 'Champion' : 'Patron'}
                    </div>
                  </button>
                ))}
              </div>

              {/* Custom Amount Input */}
              <div className="mt-3">
                <div className="relative">
                  <span className="absolute left-3 top-2.5 text-gray-500 font-semibold text-sm">$</span>
                  <Input
                    type="text"
                    placeholder="Custom amount (min $1)"
                    value={customAmount}
                    onChange={handleCustomChange}
                    onFocus={() => setIsCustom(true)}
                    className={`pl-7 text-sm rounded-xl ${
                      isCustom ? 'border-emerald-600 ring-1 ring-emerald-600' : 'border-gray-200'
                    }`}
                  />
                </div>
              </div>
            </div>

            {/* Action Buttons */}
            <div className="space-y-2 pt-1">
              <Button
                onClick={handleDonateClick}
                className="w-full py-5 text-sm bg-emerald-600 hover:bg-emerald-700 text-white font-bold rounded-xl shadow-md flex items-center justify-center gap-2"
              >
                <Sparkles className="w-4 h-4 text-amber-300" />
                Support with ${effectiveAmount} via Stripe
              </Button>

              <Button
                variant="ghost"
                onClick={handleClose}
                className="w-full text-xs text-gray-500 hover:text-gray-800 font-medium py-2"
              >
                Continue Exploring Free &rarr;
              </Button>
            </div>

            <div className="flex items-center justify-center gap-1.5 text-[11px] text-gray-400">
              <ShieldCheck className="w-3.5 h-3.5 text-emerald-600" />
              <span>Secure 256-bit Stripe checkout. Contributions start from $1.</span>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* Direct Stripe Checkout Modal */}
      <StripeCheckoutModal
        isOpen={stripeModalOpen}
        onClose={() => {
          setStripeModalOpen(false);
          onClose();
        }}
        amountUsd={effectiveAmount}
        user={user}
      />
    </>
  );
}
