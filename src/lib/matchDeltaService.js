import { supabase } from "@/lib/supabaseClient";
import { generateUserMatchReport } from "@/lib/matchingEngine";

const SNAPSHOT_LOCAL_KEY = "ubi_last_match_snapshot";

/**
 * Service to calculate deltas between match snapshots and generate notifications
 */
export async function syncMatchSnapshotAndDetectDeltas(user, profile, allPrograms = []) {
  if (!allPrograms || allPrograms.length === 0) return null;

  // 1. Generate current live match report
  const currentReport = generateUserMatchReport(profile, allPrograms);
  if (currentReport.incompleteProfile) {
    return { currentReport, deltas: [] };
  }

  const currentProgramIds = currentReport.rankedMatches.map(p => p.program_id);
  const currentScoresMap = {};
  const currentStatusMap = {};
  const currentPayoutMap = {};

  currentReport.rankedMatches.forEach(p => {
    currentScoresMap[p.program_id] = p.matchScore;
    currentStatusMap[p.program_id] = p.application_status || p.status;
    currentPayoutMap[p.program_id] = p.monthly_amount_usd;
  });

  // 2. Fetch last snapshot
  let previousSnapshot = null;

  if (user?.id) {
    try {
      const { data, error } = await supabase
        .from("user_match_snapshots")
        .select("*")
        .eq("user_id", user.id)
        .order("created_at", { ascending: false })
        .limit(1);

      if (!error && data && data.length > 0) {
        previousSnapshot = data[0];
      }
    } catch (err) {
      console.warn("Could not fetch remote match snapshot, falling back to local storage:", err);
    }
  }

  // Fallback to localStorage if no DB snapshot found
  if (!previousSnapshot) {
    try {
      const local = localStorage.getItem(SNAPSHOT_LOCAL_KEY);
      if (local) previousSnapshot = JSON.parse(local);
    } catch (e) {
      console.warn("Could not parse local snapshot", e);
    }
  }

  const detectedDeltas = [];
  const notificationsToCreate = [];

  // 3. Compute Deltas if a previous snapshot exists
  if (previousSnapshot && previousSnapshot.matched_program_ids) {
    const prevIds = new Set(previousSnapshot.matched_program_ids || []);
    const prevScores = previousSnapshot.match_scores || {};
    const prevStatuses = previousSnapshot.status_map || {};

    // A. Check for Newly Available Programs
    currentReport.rankedMatches.forEach(prog => {
      if (!prevIds.has(prog.program_id)) {
        detectedDeltas.push({
          type: "new_program_available",
          programId: prog.program_id,
          programName: prog.name,
          message: `A new program matching your criteria is available: ${prog.name} ($${prog.monthly_amount_usd || 0}/mo).`
        });

        notificationsToCreate.push({
          type: "new_program_available",
          title: "New Program Available",
          message: `${prog.name} is now open and matched to your profile with a ${prog.matchScore}% fit.`,
          program_id: prog.program_id,
          program_name: prog.name,
          severity: "success",
          action_url: `/program-details`
        });
      }
    });

    // B. Check for Demoted or Disqualified Programs
    prevIds.forEach(prevId => {
      if (!currentProgramIds.includes(prevId)) {
        const prog = allPrograms.find(p => p.program_id === prevId);
        const name = prog ? prog.name : `Program #${prevId}`;
        
        detectedDeltas.push({
          type: "program_demoted",
          programId: prevId,
          programName: name,
          message: `You may no longer qualify for ${name} based on updated criteria.`
        });

        notificationsToCreate.push({
          type: "program_demoted",
          title: "Eligibility Updated",
          message: `Your match criteria changed and ${name} was demoted from your top recommendations.`,
          program_id: prevId,
          program_name: name,
          severity: "warning",
          action_url: `/My-Report`
        });
      }
    });

    // C. Check for Status or Payout Changes in existing matches
    currentReport.rankedMatches.forEach(prog => {
      if (prevIds.has(prog.program_id)) {
        const prevStatus = prevStatuses[prog.program_id];
        const currentStatus = prog.application_status || prog.status;

        if (prevStatus && prevStatus !== currentStatus) {
          detectedDeltas.push({
            type: "status_changed",
            programId: prog.program_id,
            programName: prog.name,
            message: `${prog.name} application status changed from "${prevStatus}" to "${currentStatus}".`
          });

          notificationsToCreate.push({
            type: "status_changed",
            title: "Application Status Changed",
            message: `${prog.name} is now marked as "${currentStatus}".`,
            program_id: prog.program_id,
            program_name: prog.name,
            severity: currentStatus.includes("closed") || currentStatus.includes("No longer") ? "urgent" : "info",
            action_url: `/program-details`
          });
        }
      }
    });
  }

  // 4. Save new snapshot
  const snapshotPayload = {
    matched_program_ids: currentProgramIds,
    match_scores: currentScoresMap,
    status_map: currentStatusMap,
    payout_map: currentPayoutMap,
    total_potential_monthly_usd: currentReport.totalPotentialMonthlyUsd,
    tier_summary: {
      guaranteed_count: currentReport.tierSummary.tier_1_guaranteed?.length || 0,
      daily_claim_count: currentReport.tierSummary.tier_2_daily_claim?.length || 0,
      lottery_count: currentReport.tierSummary.tier_3_lottery?.length || 0,
    },
    created_at: new Date().toISOString()
  };

  // Always update localStorage
  try {
    localStorage.setItem(SNAPSHOT_LOCAL_KEY, JSON.stringify(snapshotPayload));
  } catch (e) {
    console.warn("Could not save snapshot to localStorage:", e);
  }

  // If user is authenticated, save snapshot and notifications to Supabase
  if (user?.id) {
    try {
      await supabase.from("user_match_snapshots").insert([{
        user_id: user.id,
        profile_id: profile?.id || null,
        matched_program_ids: currentProgramIds,
        match_scores: currentScoresMap,
        tier_summary: snapshotPayload.tier_summary,
        total_potential_monthly_usd: currentReport.totalPotentialMonthlyUsd
      }]);

      if (notificationsToCreate.length > 0) {
        const rows = notificationsToCreate.map(n => ({
          ...n,
          user_id: user.id
        }));
        await supabase.from("user_notifications").insert(rows);
      }
    } catch (dbErr) {
      console.warn("Error saving match snapshot to database:", dbErr);
    }
  }

  return {
    currentReport,
    deltas: detectedDeltas,
    newAlerts: notificationsToCreate
  };
}

/**
 * Fetch recent user notifications
 */
export async function getUserNotifications(user) {
  if (!user?.id) return [];

  try {
    const { data, error } = await supabase
      .from("user_notifications")
      .select("*")
      .eq("user_id", user.id)
      .order("created_at", { ascending: false })
      .limit(20);

    if (error) throw error;
    return data || [];
  } catch (err) {
    console.error("Error fetching user notifications:", err);
    return [];
  }
}

/**
 * Mark notifications as read
 */
export async function markNotificationsAsRead(user, notificationIds = []) {
  if (!user?.id) return;

  try {
    if (notificationIds.length > 0) {
      await supabase
        .from("user_notifications")
        .update({ read: true })
        .eq("user_id", user.id)
        .in("id", notificationIds);
    } else {
      // Mark all read
      await supabase
        .from("user_notifications")
        .update({ read: true })
        .eq("user_id", user.id);
    }
  } catch (err) {
    console.error("Error marking notifications read:", err);
  }
}
