// ============================================================================
// Supabase Edge Function: notify-new-submission
// Purpose: Emails all admins & owners when a new program submission is received
// Supports: AWS SES REST API (Primary) -> SES SMTP / Supabase Auth SMTP (Fallback)
// ============================================================================

import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { SmtpClient } from "https://deno.land/x/smtp@v0.7.0/mod.ts";

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

// ----------------------------------------------------------------------------
// AWS SigV4 Signing for Amazon SES v2 REST API
// ----------------------------------------------------------------------------
async function hmacSha256(key: ArrayBuffer | Uint8Array, data: string): Promise<ArrayBuffer> {
  const cryptoKey = await crypto.subtle.importKey(
    "raw",
    key,
    { name: "HMAC", hash: "SHA-256" },
    false,
    ["sign"]
  );
  return await crypto.subtle.sign("HMAC", cryptoKey, new TextEncoder().encode(data));
}

async function sha256Hex(data: string): Promise<string> {
  const digest = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(data));
  return Array.from(new Uint8Array(digest))
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");
}

async function getSignatureKey(key: string, dateStamp: string, regionName: string, serviceName: string): Promise<ArrayBuffer> {
  const kDate = await hmacSha256(new TextEncoder().encode("AWS4" + key), dateStamp);
  const kRegion = await hmacSha256(kDate, regionName);
  const kService = await hmacSha256(kRegion, serviceName);
  const kSigning = await hmacSha256(kService, "aws4_request");
  return kSigning;
}

async function sendViaAwsSesApi(params: {
  accessKeyId: string;
  secretAccessKey: string;
  region: string;
  fromEmail: string;
  toEmail: string;
  subject: string;
  htmlBody: string;
}): Promise<{ ok: boolean; error?: string; messageId?: string }> {
  const { accessKeyId, secretAccessKey, region, fromEmail, toEmail, subject, htmlBody } = params;
  const host = `email.${region}.amazonaws.com`;
  const endpoint = `https://${host}/v2/email/outbound-emails`;

  const payloadObj = {
    FromEmailAddress: fromEmail,
    Destination: {
      ToAddresses: [toEmail],
    },
    Content: {
      Simple: {
        Subject: {
          Data: subject,
          Charset: "UTF-8",
        },
        Body: {
          Html: {
            Data: htmlBody,
            Charset: "UTF-8",
          },
        },
      },
    },
  };

  const payload = JSON.stringify(payloadObj);
  const payloadHash = await sha256Hex(payload);

  const now = new Date();
  const amzDate = now.toISOString().replace(/[:-]|\.\d{3}/g, "");
  const dateStamp = amzDate.substring(0, 8);

  const canonicalUri = "/v2/email/outbound-emails";
  const canonicalHeaders = `content-type:application/json\nhost:${host}\nx-amz-date:${amzDate}\n`;
  const signedHeaders = "content-type;host;x-amz-date";

  const canonicalRequest = `POST\n${canonicalUri}\n\n${canonicalHeaders}\n${signedHeaders}\n${payloadHash}`;
  const canonicalRequestHash = await sha256Hex(canonicalRequest);

  const credentialScope = `${dateStamp}/${region}/ses/aws4_request`;
  const stringToSign = `AWS4-HMAC-SHA256\n${amzDate}\n${credentialScope}\n${canonicalRequestHash}`;

  const signingKey = await getSignatureKey(secretAccessKey, dateStamp, region, "ses");
  const signatureBytes = await hmacSha256(signingKey, stringToSign);
  const signature = Array.from(new Uint8Array(signatureBytes))
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");

  const authorizationHeader = `AWS4-HMAC-SHA256 Credential=${accessKeyId}/${credentialScope}, SignedHeaders=${signedHeaders}, Signature=${signature}`;

  try {
    const res = await fetch(endpoint, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Host: host,
        "X-Amz-Date": amzDate,
        Authorization: authorizationHeader,
      },
      body: payload,
    });

    if (!res.ok) {
      const errorText = await res.text();
      console.error(`AWS SES API error (${res.status}):`, errorText);
      return { ok: false, error: `HTTP ${res.status}: ${errorText}` };
    }

    const result = await res.json();
    console.log(`Email dispatched via AWS SES REST API to ${toEmail}. MessageId: ${result.MessageId || "ok"}`);
    return { ok: true, messageId: result.MessageId };
  } catch (err: any) {
    return { ok: false, error: err.message || String(err) };
  }
}

// ----------------------------------------------------------------------------
// SES SMTP / Shared Supabase Auth SMTP Dispatcher (Fallback)
// ----------------------------------------------------------------------------
async function sendViaSmtp(params: {
  host: string;
  port: number;
  user: string;
  pass: string;
  fromEmail: string;
  toEmail: string;
  subject: string;
  htmlBody: string;
}): Promise<{ ok: boolean; error?: string }> {
  const { host, port, user, pass, fromEmail, toEmail, subject, htmlBody } = params;

  // Clean raw email address for SMTP envelope
  const cleanFrom = fromEmail.includes("<")
    ? fromEmail.match(/<([^>]+)>/)?.[1] || fromEmail
    : fromEmail;

  try {
    const client = new SmtpClient();
    
    // Connect with TLS on 465 or STARTTLS on 587/2587
    if (port === 465) {
      await client.connectTLS({
        hostname: host,
        port: port,
        username: user,
        password: pass,
      });
    } else {
      await client.connect({
        hostname: host,
        port: port,
        username: user,
        password: pass,
      });
    }

    await client.send({
      from: cleanFrom.trim(),
      to: toEmail.trim(),
      subject: subject,
      content: htmlBody,
      html: htmlBody,
    });

    await client.close();
    console.log(`Email dispatched via SES SMTP to ${toEmail}`);
    return { ok: true };
  } catch (err: any) {
    console.error(`SES SMTP dispatch error to ${toEmail}:`, err);
    return { ok: false, error: err.message || String(err) };
  }
}

serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL") || "";
    const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") || "";
    const appOrigin = Deno.env.get("APP_URL") || "https://www.ubifinder.org";

    // 1. AWS SES REST API credentials
    const awsAccessKeyId = (Deno.env.get("AWS_ACCESS_KEY_ID") || "").trim();
    const awsSecretAccessKey = (Deno.env.get("AWS_SECRET_ACCESS_KEY") || "").trim();
    const awsRegion = (Deno.env.get("AWS_REGION") || Deno.env.get("SES_REGION") || "us-east-1").trim();

    // 2. SMTP Credentials (reusing Supabase Auth SMTP or SES SMTP variables)
    const rawSmtpHost = Deno.env.get("SES_SMTP_HOST") || Deno.env.get("SMTP_HOST") || `email-smtp.${awsRegion}.amazonaws.com`;
    const smtpHost = rawSmtpHost.trim();
    const smtpPort = Number((Deno.env.get("SES_SMTP_PORT") || Deno.env.get("SMTP_PORT") || "587").trim());
    const smtpUser = (Deno.env.get("SES_SMTP_USER") || Deno.env.get("SMTP_USER") || Deno.env.get("SMTP_USERNAME") || "").trim();
    const smtpPass = (Deno.env.get("SES_SMTP_PASSWORD") || Deno.env.get("SMTP_PASS") || Deno.env.get("SMTP_PASSWORD") || "").trim();

    // Sender identity (must be verified in Amazon SES)
    const rawFromEmail = Deno.env.get("SES_FROM_EMAIL") || Deno.env.get("SMTP_ADMIN_EMAIL") || Deno.env.get("SMTP_SENDER_NAME") || "UBI Finder <notifications@ubifinder.org>";
    const fromEmail = rawFromEmail.trim();

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

    // Fetch all admins and owners
    const { data: admins, error: adminsError } = await supabase
      .from("users")
      .select("email, full_name, role")
      .in("role", ["admin", "owner"]);

    if (adminsError) {
      console.error("Error fetching admins:", adminsError);
      throw adminsError;
    }

    const adminEmails = (admins || [])
      .map((a) => ({ email: a.email, role: a.role, name: a.full_name }))
      .filter((a): a is { email: string; role: string; name: string } => Boolean(a.email && a.email.includes("@")));

    console.log(`Found ${adminEmails.length} admin/owner recipients:`, adminEmails);

    const reviewUrl = `${origin.replace(/\/$/, "")}/admin/submissions${program_id ? `?id=${program_id}` : ""}`;

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
                <div class="item"><strong>Submission ID:</strong> #${program_id || "Pending"}</div>
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
    const dispatchResults: Array<{ recipient: string; role: string; method: string; success: boolean; error?: string }> = [];

    const hasAwsApiKeys = Boolean(awsAccessKeyId && awsSecretAccessKey);
    const hasSmtpCredentials = Boolean(smtpUser && smtpPass);

    for (const recipient of adminEmails) {
      let sent = false;
      let usedMethod = "none";
      let errorMsg: string | undefined;

      // Method 1: AWS SES REST API (Primary)
      if (hasAwsApiKeys) {
        const apiRes = await sendViaAwsSesApi({
          accessKeyId: awsAccessKeyId,
          secretAccessKey: awsSecretAccessKey,
          region: awsRegion,
          fromEmail: fromEmail,
          toEmail: recipient.email,
          subject: emailSubject,
          htmlBody: emailHtml,
        });
        if (apiRes.ok) {
          sent = true;
          usedMethod = "aws_ses_api";
        } else {
          errorMsg = `AWS API Error: ${apiRes.error}`;
        }
      }

      // Method 2: SES SMTP / Auth SMTP (Fallback)
      if (!sent && hasSmtpCredentials) {
        const smtpRes = await sendViaSmtp({
          host: smtpHost,
          port: smtpPort,
          user: smtpUser,
          pass: smtpPass,
          fromEmail: fromEmail,
          toEmail: recipient.email,
          subject: emailSubject,
          htmlBody: emailHtml,
        });
        if (smtpRes.ok) {
          sent = true;
          usedMethod = "ses_smtp";
          errorMsg = undefined;
        } else {
          errorMsg = (errorMsg ? `${errorMsg}; ` : "") + `SMTP Error: ${smtpRes.error}`;
        }
      }

      if (sent) {
        emailsSent++;
      }

      dispatchResults.push({
        recipient: recipient.email,
        role: recipient.role,
        method: usedMethod,
        success: sent,
        error: errorMsg,
      });
    }

    console.log(`[Dispatch Summary] Sent ${emailsSent}/${adminEmails.length} emails. Results:`, dispatchResults);

    return new Response(
      JSON.stringify({
        success: true,
        recipients_count: adminEmails.length,
        recipients: adminEmails.map((a) => ({ email: a.email, role: a.role })),
        emails_sent: emailsSent,
        dispatch_results: dispatchResults,
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
