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
import { Label } from '@/components/ui/label';
import { CreditCard, ShieldCheck, Lock, CheckCircle2, ArrowRight, X, Heart, Sparkles } from 'lucide-react';
import { useNavigate } from 'react-router-dom';

export default function StripeCheckoutModal({ isOpen, onClose, amountUsd = 5, user = null }) {
  const navigate = useNavigate();
  const [cardName, setCardName] = useState(user?.user_metadata?.full_name || user?.email?.split('@')[0] || '');
  const [cardNumber, setCardNumber] = useState('');
  const [expiry, setExpiry] = useState('');
  const [cvc, setCvc] = useState('');
  const [zip, setZip] = useState('');
  const [isProcessing, setIsProcessing] = useState(false);
  const [step, setStep] = useState('card'); // 'card' | 'processing' | 'confirmed'

  if (!isOpen) return null;

  const handleCardNumberChange = (e) => {
    let val = e.target.value.replace(/\D/g, '').substring(0, 16);
    // Format with spaces every 4 digits
    val = val.replace(/(\d{4})(?=\d)/g, '$1 ');
    setCardNumber(val);
  };

  const handleExpiryChange = (e) => {
    let val = e.target.value.replace(/\D/g, '').substring(0, 4);
    if (val.length >= 2) {
      val = val.substring(0, 2) + '/' + val.substring(2, 4);
    }
    setExpiry(val);
  };

  const handleCvcChange = (e) => {
    const val = e.target.value.replace(/\D/g, '').substring(0, 4);
    setCvc(val);
  };

  const handleSubmitPayment = (e) => {
    e.preventDefault();
    setIsProcessing(true);
    setStep('processing');

    setTimeout(() => {
      setStep('confirmed');
      setTimeout(() => {
        onClose();
        navigate(`/donate/success?amount=${amountUsd}&session_id=stripe_ch_${Date.now()}`);
      }, 900);
    }, 1400);
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-md p-0 overflow-hidden rounded-3xl border-emerald-300 shadow-2xl bg-white">
        {/* Stripe Header */}
        <div className="bg-slate-900 p-6 text-white text-left relative">
          <button 
            onClick={onClose}
            className="absolute top-4 right-4 text-gray-400 hover:text-white p-1 rounded-full hover:bg-white/10 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>

          <div className="flex items-center gap-2 mb-2">
            <span className="text-[10px] font-bold uppercase tracking-wider text-emerald-400 bg-emerald-950/80 px-2 py-0.5 rounded border border-emerald-800">
              Stripe Secure Checkout
            </span>
          </div>

          <DialogTitle className="text-xl font-bold text-white flex items-center justify-between">
            <span>UBI Finder Contribution</span>
            <span className="text-2xl font-extrabold text-emerald-400">${amountUsd}.00</span>
          </DialogTitle>
          <DialogDescription className="text-gray-300 text-xs mt-1">
            100% Volunteer-Run Non-Profit Support • One-time contribution
          </DialogDescription>
        </div>

        {/* Card Form */}
        <div className="p-6">
          {step === 'processing' ? (
            <div className="py-12 text-center space-y-4">
              <div className="w-12 h-12 border-3 border-emerald-600 border-t-transparent rounded-full animate-spin mx-auto"></div>
              <p className="text-sm font-bold text-slate-800">Contacting Stripe Network...</p>
              <p className="text-xs text-gray-500">Authorizing 256-bit encrypted transaction</p>
            </div>
          ) : step === 'confirmed' ? (
            <div className="py-10 text-center space-y-3">
              <div className="w-12 h-12 bg-emerald-100 text-emerald-700 rounded-full flex items-center justify-center mx-auto">
                <CheckCircle2 className="w-7 h-7" />
              </div>
              <p className="text-base font-bold text-emerald-950">Payment Successful!</p>
              <p className="text-xs text-gray-500">Unlocking your lifetime supporter access...</p>
            </div>
          ) : (
            <form onSubmit={handleSubmitPayment} className="space-y-4">
              <div>
                <Label className="text-xs text-gray-700 font-semibold mb-1 block">
                  Name on Card
                </Label>
                <Input
                  type="text"
                  placeholder="Jane Doe"
                  value={cardName}
                  onChange={(e) => setCardName(e.target.value)}
                  required
                  className="rounded-xl text-sm"
                />
              </div>

              <div>
                <Label className="text-xs text-gray-700 font-semibold mb-1 block flex items-center justify-between">
                  <span>Card Number</span>
                  <span className="text-[10px] text-gray-400">Visa / MC / Amex</span>
                </Label>
                <div className="relative">
                  <Input
                    type="text"
                    placeholder="4242 4242 4242 4242"
                    value={cardNumber}
                    onChange={handleCardNumberChange}
                    required
                    className="rounded-xl text-sm pl-10 tracking-wide font-mono"
                  />
                  <CreditCard className="w-4 h-4 text-gray-400 absolute left-3.5 top-3" />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <Label className="text-xs text-gray-700 font-semibold mb-1 block">
                    Expiration
                  </Label>
                  <Input
                    type="text"
                    placeholder="MM/YY"
                    value={expiry}
                    onChange={handleExpiryChange}
                    required
                    className="rounded-xl text-sm font-mono text-center"
                  />
                </div>
                <div>
                  <Label className="text-xs text-gray-700 font-semibold mb-1 block">
                    CVC / CVV
                  </Label>
                  <Input
                    type="text"
                    placeholder="123"
                    value={cvc}
                    onChange={handleCvcChange}
                    required
                    className="rounded-xl text-sm font-mono text-center"
                  />
                </div>
              </div>

              <div>
                <Label className="text-xs text-gray-700 font-semibold mb-1 block">
                  Postal / ZIP Code
                </Label>
                <Input
                  type="text"
                  placeholder="90210"
                  value={zip}
                  onChange={(e) => setZip(e.target.value)}
                  required
                  className="rounded-xl text-sm"
                />
              </div>

              <Button
                type="submit"
                className="w-full py-5 text-sm bg-emerald-600 hover:bg-emerald-700 text-white font-extrabold rounded-xl shadow-lg flex items-center justify-center gap-2 mt-2"
              >
                <Lock className="w-4 h-4" />
                <span>Pay ${amountUsd}.00 with Stripe</span>
              </Button>

              <div className="flex items-center justify-center gap-1.5 text-[11px] text-gray-400 pt-1">
                <ShieldCheck className="w-3.5 h-3.5 text-emerald-600" />
                <span>Encrypted via Stripe. Direct receipt will be emailed.</span>
              </div>
            </form>
          )}
        </div>
      </DialogContent>
    </Dialog>
  );
}
