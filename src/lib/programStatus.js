/**
 * Classify a program for the catalog's quick status filters.
 *
 * @param {Record<string, any>} program
 * @param {string} statusKey
 */
export function matchesProgramStatus(program, statusKey) {
  const appStatus = (program.application_status || "").toLowerCase();
  const programStatus = (program.status || "").toLowerCase();
  const payoutStatus = (program.payout_status || "").toLowerCase();

  const isPlanned = programStatus === "planned" || appStatus.includes("planned") || programStatus === "upcoming";
  const isHistorical = programStatus === "closed" || programStatus === "completed" || appStatus.includes("pilot completed") || payoutStatus.includes("completed");
  const isClosedOngoing = !isHistorical && (
    programStatus === "active_closed" ||
    appStatus.includes("no longer accepting") ||
    appStatus.includes("referral") ||
    (payoutStatus.includes("ongoing") && appStatus.includes("no longer"))
  );
  const isAccepting = !isPlanned && !isHistorical && !isClosedOngoing && (
    programStatus === "active_open" ||
    appStatus.includes("accepting") ||
    programStatus === "active" ||
    program.distribution_type === "daily_claim_protocol" ||
    program.distribution_type === "lottery_raffle"
  );

  switch (statusKey) {
    case "accepting_applications":
      return isAccepting;
    case "planned":
      return isPlanned;
    case "closed_ongoing":
      return isClosedOngoing;
    case "closed_historical":
      return isHistorical;
    case "all":
    default:
      return true;
  }
}
