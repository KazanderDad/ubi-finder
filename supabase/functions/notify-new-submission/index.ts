// ============================================================================
// Supabase Edge Function: notify-new-submission
// Purpose: Emails all admins & owners when a new program submission is received
// ============================================================================

import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

interface SubmissionPayload {
  program_id: number;
  name: string;
  organization?: string;
  submitter_email?: string;
  amount_description?: string;
  monthly_amount_usd?: number;
  available_regions?: string[];
  website?: string;
  origin?: string;
}

serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL") || "";
    const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") || "";
    const resendApiKey = Deno.env.get("RESEND_API_KEY") || "";
    const appOrigin = Deno.env.get("APP_URL") || "https://www.ubifinder.org";

    const supabase = createClient(supabaseUrl, supabaseServiceKey);

    const payload: SubmissionPayload = await req.json();
    const {
      program_id,
      name,
      organization = "Community Submission",
      submitter_email = "Not provided",
      amount_description = "Unspecified",
      origin = appOrigin,
    } = payload;

    // 1. Fetch all admins and owners
    const { data: admins, error: adminsError } = await supabase
      .from("users")
      .select("email, full_name, role")
      .in("role", ["admin", "owner"]);

    if (adminsError) {
      console.error("Error fetching admins:", adminsError);
      throw adminsError;
    }

    const adminEmails = (admins || [])
      .map((a) => a.email)
      .filter((email): email is string => Boolean(email && email.includes("@")));

    console.log(`Found ${adminEmails.length} admin/owner recipients:`, adminEmails);

    const reviewUrl = `${origin.replace(/\/$/, "")}/admin/submissions${program_id ? `?id=${program_id}` : ""}`;

    // 2. Dispatch email to each admin/owner
    const emailSubject = `[UBI Finder] New Program Submission: ${name}`;
    const emailHtml = `
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <style>
            body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; background-color: #f4fbf7; margin: 0; padding: 24px; color: #1f2937; }
            .container { max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 16px; border: 1px solid #e5e7eb; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
            .header { background: linear-gradient(135deg, #15803d, #166534); padding: 28px 24px; text-align: center; color: #ffffff; }
            .content { padding: 32px 24px; }
            .badge { display: inline-block; background-color: #dcfce7; color: #166534; font-weight: 700; font-size: 12px; padding: 4px 10px; border-radius: 9999px; text-transform: uppercase; margin-bottom: 12px; }
            .card { background-color: #f9fafb; border-radius: 12px; border: 1px solid #e5e7eb; padding: 18px; margin: 20px 0; }
            .item { margin-bottom: 10px; font-size: 14px; }
            .item strong { color: #111827; }
            .btn { display: inline-block; background-color: #15803d; color: #ffffff !important; font-weight: 700; font-size: 15px; text-decoration: none; padding: 14px 28px; border-radius: 10px; margin-top: 16px; text-align: center; }
            .footer { padding: 20px; font-size: 12px; color: #6b7280; text-align: center; border-top: 1px solid #f3f4f6; }
          </style>
        </head>
        <body>
          <div class="container">
            <div class="header">
              <h1 style="margin: 0; font-size: 22px;">UBI Finder Admin Review</h1>
              <p style="margin: 6px 0 0 0; opacity: 0.9; font-size: 14px;">New Program Submitted for Publication</p>
            </div>
            <div class="content">
              <span class="badge">Action Required</span>
              <h2 style="margin: 0 0 12px 0; font-size: 20px; color: #111827;">${name}</h2>
              <p style="margin: 0 0 16px 0; font-size: 14px; color: #4b5563;">
                A new Universal Basic Income initiative has been submitted and is currently pending review by platform administrators.
              </p>
              
              <div class="card">
                <div class="item"><strong>Organization:</strong> ${organization}</div>
                <div class="item"><strong>Payout Terms:</strong> ${amount_description}</div>
                <div class="item"><strong>Submitter Email:</strong> ${submitter_email}</div>
                <div class="item"><strong>Submission ID:</strong> #${program_id || 'Pending'}</div>
              </div>

              <div style="text-align: center; margin: 28px 0;">
                <a href="${reviewUrl}" class="btn">
                  Review & Approve Submission &rarr;
                </a>
              </div>

              <p style="font-size: 12px; color: #6b7280; text-align: center;">
                Direct link: <a href="${reviewUrl}" style="color: #15803d;">${reviewUrl}</a>
              </p>
            </div>
            <div class="footer">
              This automated notification was sent to authorized UBI Finder administrators and owners.
            </div>
          </div>
        </body>
      </html>
    `;

    let emailsSent = 0;

    // Send using Resend if key is available
    if (resendApiKey && adminEmails.length > 0) {
      for (const email of adminEmails) {
        try {
          const res = await fetch("https://api.resend.com/emails", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${resendApiKey}`,
            },
            body: JSON.stringify({
              from: "UBI Finder <notifications@ubifinder.org>",
              to: email,
              subject: emailSubject,
              html: emailHtml,
            }),
          });
          if (res.ok) {
            emailsSent++;
          } else {
            console.warn(`Resend failed for ${email}:`, await res.text());
          }
        } catch (err) {
          console.error(`Error sending email to ${email}:`, err);
        }
      }
    } else {
      console.log(`[Notification Mock] Notification logged for ${adminEmails.length} admins. Review link: ${reviewUrl}`);
    }

    return new Response(
      JSON.stringify({
        success: true,
        recipients_count: adminEmails.length,
        emails_sent: emailsSent,
        review_url: reviewUrl,
      }),
      {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 200,
      }
    );
  } catch (error: any) {
    console.error("notify-new-submission error:", error);
    return new Response(
      JSON.stringify({ error: error.message || "Internal server error" }),
      {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 500,
      }
    );
  }
});
