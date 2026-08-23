import { supabase } from "@/lib/supabaseClient";

/**
 * Dispatches a notification to all administrators and owners when a new program is submitted.
 * Calls the Supabase Edge Function 'notify-new-submission' and logs to public.admin_notifications.
 *
 * @param {Object} programData - Program details
 * @returns {Promise<{ success: boolean, notified: boolean }>}
 */
export async function notifyAdminsOfNewSubmission(programData) {
  try {
    const origin = typeof window !== "undefined" ? window.location.origin : "https://www.ubifinder.org";
    
    const payload = {
      program_id: programData.program_id,
      name: programData.name,
      organization: programData.organization,
      submitter_email: programData.submitter_email,
      amount_description: programData.amount_description,
      monthly_amount_usd: programData.monthly_amount_usd,
      available_regions: programData.available_regions,
      website: programData.website,
      origin: origin,
    };

    // 1. Insert into public.admin_notifications table for real-time admin portal awareness
    try {
      await supabase.from("admin_notifications").insert([
        {
          type: "new_program_submission",
          program_id: programData.program_id,
          program_name: programData.name,
          submitter_email: programData.submitter_email,
          payload: payload,
        },
      ]);
    } catch (dbErr) {
      console.warn("Could not insert admin_notification record:", dbErr);
    }

    // 2. Invoke Supabase Edge Function for email dispatch
    try {
      const { data, error } = await supabase.functions.invoke("notify-new-submission", {
        body: payload,
      });

      if (error) {
        console.warn("Edge function notify-new-submission invocation error:", error);
      } else {
        console.log("Edge function notify-new-submission response:", data);
      }
    } catch (funcErr) {
      console.warn("Edge function invocation failed (fallback active):", funcErr);
    }

    return { success: true, notified: true };
  } catch (err) {
    console.error("notifyAdminsOfNewSubmission error:", err);
    return { success: false, error: err };
  }
}
