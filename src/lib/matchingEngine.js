/**
 * UBI Finder Intelligent Matching & Ranking Engine
 * Evaluates demographic, economic, geographic, and delivery rail fit
 * Produces weighted fit scores (0-100%) and categorizes matches into actionable tiers.
 */

export const INCOME_MAP = {
  "0-20k": 20000,
  "20k-40k": 40000,
  "40k-60k": 60000,
  "60k+": 999999,
};

export const TIERS = {
  TIER_1_GUARANTEED: "tier_1_guaranteed", // Guaranteed recurring cash disbursements
  TIER_2_DAILY_CLAIM: "tier_2_daily_claim", // Web3 / Daily claim protocols (GoodDollar, Circles)
  TIER_3_LOTTERY: "tier_3_lottery", // Community raffles & lotteries (Mein Grundeinkommen)
  TIER_4_WAITLIST: "tier_4_waitlist", // Upcoming pilots & waitlist programs
};

export function getIncomeUpperLimit(range) {
  if (!range) return Infinity;
  return INCOME_MAP[range] || Infinity;
}

/**
 * Check whether a profile has all necessary information to evaluate eligibility
 */
export function isProfileComplete(profile) {
  if (!profile) return false;
  const hasCountry = Boolean(profile.country && String(profile.country).trim());
  const hasHousehold = Number(profile.household_size) >= 1;
  const hasIncome = Boolean(profile.income_range);
  const hasGender = Boolean(profile.gender || profile.women_count !== undefined);
  const needsState = ["United States", "Canada"].includes(profile.country);
  const hasState = !needsState || Boolean(profile.state || profile.state_province);
  return hasCountry && hasHousehold && hasIncome && hasGender && hasState;
}

/**
 * Evaluate precision eligibility and compute a 0-100% weighted fit score
 */
export function evaluateEligibility(program, profile) {
  if (!program || program.internal_status === "deleted") {
    return { eligible: false, reasons: ["Program is inactive or deleted"], score: 0, tier: null };
  }

  // If user profile is not complete, do not falsely qualify them
  if (!isProfileComplete(profile)) {
    return {
      eligible: false,
      reasons: ["Profile incomplete. Please fill out your profile details to evaluate eligibility."],
      score: 0,
      fitBreakdown: { geographic: 0, economic: 0, value: 0, rail: 0, status: 0 },
      tier: null,
      diagnostics: [
        { label: "Profile Required", passed: false, text: "Complete your profile to view eligibility" }
      ]
    };
  }

  const diagnostics = [];
  const disqualifiers = [];
  let score = 0;
  const fitBreakdown = { geographic: 0, economic: 0, value: 0, rail: 0, status: 0 };

  // 1. Geographic Hierarchy Evaluation (Up to 30 points)
  const regions = program.available_regions || [];
  const isGlobal = regions.length === 0 || regions.includes("Global") || regions.includes("Worldwide");
  const matchesCountry = isGlobal || (profile.country && regions.includes(profile.country));

  let geoScore = 0;
  if (!matchesCountry) {
    disqualifiers.push(`Restricted to ${regions.join(", ")} (Your location: ${profile.country || "Unspecified"})`);
    diagnostics.push({ label: "Location", passed: false, text: `Available only in ${regions.join(", ")}` });
  } else {
    // Check Municipal & State level precision
    const stateProvince = profile.state || profile.state_province;
    const municipality = profile.municipality;

    if (program.municipalities && program.municipalities.length > 0) {
      if (municipality && program.municipalities.includes(municipality)) {
        geoScore = 30; // Direct city/municipality match!
        diagnostics.push({ label: "Hyper-Local Match", passed: true, text: `Directly targeted to residents of ${municipality}` });
      } else if (municipality === "Other / Not listed") {
        // Restricted to municipal boundaries within the state
        disqualifiers.push(`Restricted to city boundaries: ${program.municipalities.join(", ")}`);
        diagnostics.push({ label: "Municipal Boundary", passed: false, text: `Limited to ${program.municipalities.join(", ")}` });
      } else {
        geoScore = 20;
        diagnostics.push({ label: "Regional Match", passed: true, text: `Located in your region` });
      }
    } else if (program.state_province && stateProvince) {
      if (program.state_province.toLowerCase() === stateProvince.toLowerCase()) {
        geoScore = 25; // State match
        diagnostics.push({ label: "State/Province Match", passed: true, text: `Statewide program for ${stateProvince}` });
      } else {
        geoScore = 15;
      }
    } else if (isGlobal) {
      geoScore = 20;
      diagnostics.push({ label: "Global Access", passed: true, text: "Open worldwide without residency restrictions" });
    } else {
      geoScore = 22;
      diagnostics.push({ label: "Country Match", passed: true, text: `Nationwide program in ${profile.country}` });
    }
  }
  fitBreakdown.geographic = geoScore;
  score += geoScore;

  // 2. Gender & Family Composition Evaluation (Up to 15 points)
  if (program.gender_requirement && program.gender_requirement !== "any") {
    const userGender = profile.gender;
    const womenCount = parseInt(profile.women_count || "0", 10);
    const householdSize = parseInt(profile.household_size || "1", 10);

    const isWoman = userGender === "female" || womenCount > 0;

    if (program.gender_requirement === "female" && !isWoman && userGender !== "abstain") {
      disqualifiers.push("Program is specifically designated for women/female-led households");
      diagnostics.push({ label: "Gender Requirement", passed: false, text: "Designated for women/mothers" });
    } else {
      diagnostics.push({ label: "Demographic Fit", passed: true, text: "Meets household qualification" });
      score += 15;
    }
  } else {
    diagnostics.push({ label: "Demographics", passed: true, text: "Universal qualification (No gender restrictions)" });
    score += 15;
  }

  // 3. Economic & Income Threshold Evaluation (Up to 25 points)
  const userIncomeNum = getIncomeUpperLimit(profile.income_range);
  const maxIncomeAllowed = program.max_household_income_usd;

  if (maxIncomeAllowed && userIncomeNum > maxIncomeAllowed) {
    disqualifiers.push(`Income cap is $${maxIncomeAllowed.toLocaleString()}/yr (Your tier: ${profile.income_range})`);
    diagnostics.push({ label: "Income Limit", passed: false, text: `Exceeds max income limit of $${maxIncomeAllowed.toLocaleString()}` });
  } else if (maxIncomeAllowed) {
    // Under income cap
    fitBreakdown.economic = 25;
    score += 25;
    diagnostics.push({ label: "Income Verified", passed: true, text: `Income fits within the $${maxIncomeAllowed.toLocaleString()} threshold` });
  } else {
    // True unconditional universal program
    fitBreakdown.economic = 20;
    score += 20;
    diagnostics.push({ label: "Unconditional", passed: true, text: "No income caps or means testing required" });
  }

  // 4. Payout Delivery Rail Compatibility (Up to 15 points)
  const isDigitalPayout = program.payment_method === "digital" || program.payout_rail === "crypto_wallet";
  const userAcceptsDigital = profile.accepts_digital_currency !== false;

  if (isDigitalPayout && !userAcceptsDigital) {
    // User explicitly opts out of digital currency
    score += 2;
    diagnostics.push({ label: "Payment Rail", passed: false, text: "Requires crypto wallet or digital payout" });
  } else {
    fitBreakdown.rail = 15;
    score += 15;
    diagnostics.push({ 
      label: "Payout Rail", 
      passed: true, 
      text: program.payout_rail === "crypto_wallet" ? "Compatible with Web3 wallet preference" : "Compatible with standard bank/card delivery" 
    });
  }

  // 5. Monthly Value & Application Status Evaluation (Up to 15 points)
  const isClosed = 
    program.status === "closed" || 
    program.status === "active_closed" || 
    (program.application_status && program.application_status.toLowerCase().includes("no longer accepting"));

  if (isClosed) {
    disqualifiers.push("Program is no longer accepting new applications");
    diagnostics.push({ 
      label: "Application Status", 
      passed: false, 
      text: "Applications are currently closed" 
    });
    fitBreakdown.status = 0;
  } else if (program.status === "active_open" || program.application_status === "Accepting applications") {
    fitBreakdown.status = 15;
    score += 15;
    diagnostics.push({ 
      label: "Application Status", 
      passed: true, 
      text: "Actively accepting applications" 
    });
  } else if (program.status === "upcoming" || program.application_status === "Accepting waitlist") {
    fitBreakdown.status = 8;
    score += 8;
    diagnostics.push({ 
      label: "Application Status", 
      passed: true, 
      text: "Accepting waitlist entries" 
    });
  } else {
    fitBreakdown.status = 5;
    score += 5;
  }

  // Final score clamping
  const finalScore = Math.min(100, Math.max(10, score));

  // Determine Tier
  let tier = TIERS.TIER_1_GUARANTEED;
  if (isClosed) {
    tier = null;
  } else if (program.status === "upcoming" || program.application_status === "Accepting waitlist") {
    tier = TIERS.TIER_4_WAITLIST;
  } else if (program.distribution_type === "daily_claim_protocol") {
    tier = TIERS.TIER_2_DAILY_CLAIM;
  } else if (program.distribution_type === "lottery_raffle") {
    tier = TIERS.TIER_3_LOTTERY;
  }

  const isEligible = disqualifiers.length === 0;

  return {
    eligible: isEligible,
    reasons: disqualifiers,
    score: isEligible ? finalScore : Math.min(25, finalScore),
    fitBreakdown,
    tier,
    diagnostics
  };
}

/**
 * Generate a complete, ranked custom match report
 */
export function generateUserMatchReport(profile, allPrograms = []) {
  if (!isProfileComplete(profile)) {
    return {
      incompleteProfile: true,
      rankedMatches: [],
      demotedOrIneligible: (allPrograms || []).filter(p => p.internal_status !== 'deleted').map(p => ({
        ...p,
        matchScore: 0,
        isEligible: false,
        disqualifiers: ["Profile incomplete. Fill out the form to evaluate eligibility."],
        diagnostics: [{ label: "Profile Required", passed: false, text: "Complete your profile to see eligibility" }]
      })),
      tierSummary: {
        [TIERS.TIER_1_GUARANTEED]: [],
        [TIERS.TIER_2_DAILY_CLAIM]: [],
        [TIERS.TIER_3_LOTTERY]: [],
        [TIERS.TIER_4_WAITLIST]: [],
      },
      totalPotentialMonthlyUsd: 0,
      averageScore: 0,
      totalEligibleCount: 0,
      generatedAt: new Date().toISOString()
    };
  }

  const rankedMatches = [];
  const demotedOrIneligible = [];

  const tierSummary = {
    [TIERS.TIER_1_GUARANTEED]: [],
    [TIERS.TIER_2_DAILY_CLAIM]: [],
    [TIERS.TIER_3_LOTTERY]: [],
    [TIERS.TIER_4_WAITLIST]: [],
  };

  let totalPotentialMonthlyUsd = 0;

  (allPrograms || []).forEach(program => {
    if (program.internal_status === "deleted") return;

    const evaluation = evaluateEligibility(program, profile);

    const enriched = {
      ...program,
      matchScore: evaluation.score,
      isEligible: evaluation.eligible,
      disqualifiers: evaluation.reasons,
      diagnostics: evaluation.diagnostics,
      tier: evaluation.tier,
      fitBreakdown: evaluation.fitBreakdown
    };

    if (evaluation.eligible) {
      rankedMatches.push(enriched);
      if (tierSummary[evaluation.tier]) {
        tierSummary[evaluation.tier].push(enriched);
      }
      
      // Calculate potential cash floor (Guaranteed + Daily Claims)
      if (evaluation.tier === TIERS.TIER_1_GUARANTEED || evaluation.tier === TIERS.TIER_2_DAILY_CLAIM) {
        totalPotentialMonthlyUsd += Number(program.monthly_amount_usd || 0);
      }
    } else {
      demotedOrIneligible.push(enriched);
    }
  });

  // Sort ranked matches by score DESC, then monthly amount DESC
  rankedMatches.sort((a, b) => {
    if (b.matchScore !== a.matchScore) {
      return b.matchScore - a.matchScore;
    }
    return (Number(b.monthly_amount_usd) || 0) - (Number(a.monthly_amount_usd) || 0);
  });

  // Calculate average score of top matches
  const topScores = rankedMatches.slice(0, 5).map(m => m.matchScore);
  const averageScore = topScores.length > 0 
    ? Math.round(topScores.reduce((acc, s) => acc + s, 0) / topScores.length) 
    : 0;

  return {
    rankedMatches,
    demotedOrIneligible,
    tierSummary,
    totalPotentialMonthlyUsd: Math.round(totalPotentialMonthlyUsd),
    averageScore,
    totalEligibleCount: rankedMatches.length,
    generatedAt: new Date().toISOString()
  };
}
