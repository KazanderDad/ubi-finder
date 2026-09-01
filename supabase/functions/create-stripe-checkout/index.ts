import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import Stripe from "https://esm.sh/stripe@14.14.0?target=deno";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const { amount_usd, user_id, user_email, return_url } = await req.json();

    const stripeSecretKey = Deno.env.get("STRIPE_SECRET_KEY");
    const origin = return_url || "https://ubifinder.org";
    const parsedAmount = Math.max(1, Math.round(Number(amount_usd || 5)));

    if (!stripeSecretKey) {
      // If Stripe secret key not configured in Edge Function, return simulated direct checkout URL
      return new Response(
        JSON.stringify({ 
          mock: true, 
          url: `${origin}/donate/success?amount=${parsedAmount}&session_id=demo_session_${Date.now()}` 
        }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" }, status: 200 }
      );
    }

    const stripe = new Stripe(stripeSecretKey, {
      apiVersion: "2023-10-16",
      httpClient: Stripe.createFetchHttpClient(),
    });

    const session = await stripe.checkout.sessions.create({
      payment_method_types: ["card"],
      line_items: [
        {
          price_data: {
            currency: "usd",
            product_data: {
              name: "UBI Finder Volunteer Community Contribution",
              description: "Supporting independent open-source research and universal basic income accessibility.",
            },
            unit_amount: parsedAmount * 100,
          },
          quantity: 1,
        },
      ],
      mode: "payment",
      customer_email: user_email || undefined,
      client_reference_id: user_id || undefined,
      success_url: `${origin}/donate/success?amount=${parsedAmount}&session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${origin}/Programs`,
    });

    return new Response(
      JSON.stringify({ url: session.url, session_id: session.id }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" }, status: 200 }
    );
  } catch (err) {
    return new Response(
      JSON.stringify({ error: err.message }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" }, status: 400 }
    );
  }
});
