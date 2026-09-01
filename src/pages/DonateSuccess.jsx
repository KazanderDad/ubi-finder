import React, { useEffect } from 'react';
import { useSearchParams, useNavigate, Link } from 'react-router-dom';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Heart, Sparkles, CheckCircle2, ArrowRight, ShieldCheck } from 'lucide-react';
import { recordSuccessfulDonation } from '@/lib/supporterPoints';
import { supabase } from '@/lib/supabaseClient';

export default function DonateSuccess() {
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const amount = searchParams.get('amount') || '5';
  const sessionId = searchParams.get('session_id') || 'stripe_success';

  useEffect(() => {
    (async () => {
      let currentUser = null;
      if (supabase) {
        const { data: { session } } = await supabase.auth.getSession();
        currentUser = session?.user || null;
      }
      await recordSuccessfulDonation(amount, sessionId, currentUser);
    })();
  }, [amount, sessionId]);

  return (
    <div className="min-h-[80vh] flex items-center justify-center px-4 py-12">
      <Card className="max-w-md w-full border-emerald-200 shadow-2xl rounded-3xl overflow-hidden bg-white text-center">
        {/* Header Hero */}
        <div className="bg-gradient-to-br from-emerald-600 via-teal-700 to-green-800 p-8 text-white relative">
          <div className="w-16 h-16 bg-white/20 backdrop-blur-md rounded-3xl flex items-center justify-center mx-auto mb-4 shadow-inner">
            <Heart className="w-8 h-8 text-pink-300 fill-pink-300 animate-pulse" />
          </div>
          <h1 className="text-2xl font-extrabold tracking-tight">Thank You for Your Support!</h1>
          <p className="text-emerald-100 text-xs sm:text-sm mt-2 leading-relaxed">
            Your generous contribution of <span className="font-bold text-white">${amount} USD</span> keeps UBI Finder free, independent, and open to all.
          </p>
        </div>

        {/* Body Content */}
        <CardContent className="p-6 space-y-5">
          <div className="bg-emerald-50/80 p-4 rounded-2xl border border-emerald-100 text-left space-y-2">
            <div className="flex items-center gap-2 text-xs font-bold text-emerald-900">
              <CheckCircle2 className="w-4 h-4 text-emerald-600" />
              <span>Supporter Status: Active</span>
            </div>
            <p className="text-xs text-gray-600 leading-relaxed">
              All feature access, detailed eligibility criteria, and global interactive mapping tools have been permanently unlocked for your session.
            </p>
          </div>

          <div className="pt-2 space-y-2.5">
            <Button
              onClick={() => navigate('/Programs')}
              className="w-full py-5 text-sm bg-emerald-600 hover:bg-emerald-700 text-white font-bold rounded-xl shadow-md flex items-center justify-center gap-2"
            >
              <span>Explore Programs Directory</span>
              <ArrowRight className="w-4 h-4" />
            </Button>

            <Button
              variant="outline"
              onClick={() => navigate('/')}
              className="w-full text-xs text-gray-600 border-gray-200 hover:bg-gray-50 py-2 rounded-xl"
            >
              Return to Homepage
            </Button>
          </div>

          <div className="flex items-center justify-center gap-1 text-[11px] text-gray-400 pt-2">
            <ShieldCheck className="w-3.5 h-3.5 text-emerald-600" />
            <span>Thank you for empowering open basic income research.</span>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
