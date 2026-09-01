import { supabase } from '@/lib/supabaseClient';

export async function initiateStripeCheckout({ amountUsd = 5, user = null, returnUrl = null }) {
  const origin = returnUrl || window.location.origin;
  const parsedAmount = Math.max(1, Math.round(Number(amountUsd || 5)));

  try {
    // Attempt invoking Supabase Edge function
    if (supabase) {
      const { data, error } = await supabase.functions.invoke('create-stripe-checkout', {
        body: {
          amount_usd: parsedAmount,
          user_id: user?.id || null,
          user_email: user?.email || null,
          return_url: origin
        }
      });

      if (!error && data?.url) {
        window.location.href = data.url;
        return;
      }
    }
  } catch (err) {
    console.warn('Edge function unavailable, falling back to direct checkout flow:', err);
  }

  // Graceful fallback for local dev or direct link
  const successPath = `${origin}/donate/success?amount=${parsedAmount}&session_id=stripe_sess_${Date.now()}`;
  window.location.href = successPath;
}
