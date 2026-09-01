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
import { Heart, Sparkles, ShieldCheck, ArrowRight, X } from 'lucide-react';
import { initiateStripeCheckout } from '@/lib/stripe';
import { markEncouragementDismissed } from '@/lib/supporterPoints';

export default function DonationEncouragementModal({ isOpen, onClose, user }) {
  const [selectedAmount, setSelectedAmount] = useState(5);
  const [customAmount, setCustomAmount] = useState('');
  const [isCustom, setIsCustom] = useState(false);
  const [loading, setLoading] = useState(false);

  if (!isOpen) return null;

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

  const handleDonate = async () => {
    setLoading(true);
    markEncouragementDismissed(user);
    const amountToCharge = isCustom ? Math.max(1, Number(customAmount || 1)) : selectedAmount;
    await initiateStripeCheckout({
      amountUsd: amountToCharge,
      user
    });
  };

  return (
    <Dialog open={isOpen} onOpenChange={handleClose}>
      <DialogContent className="sm:max-w-md p-0 overflow-hidden rounded-3xl border-emerald-200 shadow-2xl bg-white">
        {/* Header Banner */}
        <div className="bg-gradient-to-br from-emerald-600 via-teal-700 to-green-800 p-6 text-white text-center relative">
          <button 
            onClick={handleClose}
            className="absolute top-4 right-4 text-white/80 hover:text-white p-1 rounded-full hover:bg-white/10 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
          
          <div className="w-12 h-12 bg-white/20 backdrop-blur-md rounded-2xl flex items-center justify-center mx-auto mb-3 shadow-inner">
            <Heart className="w-6 h-6 text-pink-300 fill-pink-300" />
          </div>

          <DialogTitle className="text-xl font-extrabold tracking-tight text-white">
            Enjoying UBI Finder?
          </DialogTitle>
          <DialogDescription className="text-emerald-100 text-xs mt-1.5 max-w-xs mx-auto leading-relaxed">
            This platform is 100% volunteer-run and open-source. Help us keep universal basic income data free and updated for everyone.
          </DialogDescription>
        </div>

        {/* Content Body */}
        <div className="p-6 space-y-5">
          <div>
            <label className="text-xs font-semibold text-gray-700 uppercase tracking-wider block mb-2.5">
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
          <div className="space-y-2.5 pt-1">
            <Button
              onClick={handleDonate}
              disabled={loading}
              className="w-full py-5 text-sm bg-emerald-600 hover:bg-emerald-700 text-white font-bold rounded-xl shadow-md flex items-center justify-center gap-2"
            >
              {loading ? (
                'Connecting to Stripe...'
              ) : (
                <>
                  <Sparkles className="w-4 h-4 text-amber-300" />
                  Support with ${isCustom ? (customAmount || 1) : selectedAmount} via Stripe
                </>
              )}
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
  );
}
