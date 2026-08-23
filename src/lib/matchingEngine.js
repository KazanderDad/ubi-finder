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
  const needsState = ["United States", "Canada"].includes(profile.country);
  const hasState = !needsState || Boolean(profile.state || profile.state_province);
  return hasCountry && hasState;
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
  const progName = program.name || "";
  const progMunicipalities = program.municipalities || [];
  const progState = program.state_province || "";

  const isGlobal = 
    regions.length === 0 || 
    regions.some(r => /^(global|worldwide|international|all)$/i.test(r)) ||
    progMunicipalities.some(m => /^(global|worldwide|international|all)$/i.test(m)) ||
    /^(global|worldwide|international|all)$/i.test(progState) ||
    /GoodDollar|FundLoop|Mein Grundeinkommen|World WLD|Circles/i.test(progName);

  const matchesCountry = isGlobal || (profile.country && regions.includes(profile.country));

  let geoScore = 0;
  if (!matchesCountry) {
    disqualifiers.push(`Restricted to ${regions.join(", ")} (Your location: ${profile.country || "Unspecified"})`);
    diagnostics.push({ label: "Location", passed: false, text: `Available only in ${regions.join(", ")}` });
  } else if (isGlobal) {
    geoScore = 25;
    diagnostics.push({ label: "Global Access", passed: true, text: "Open worldwide without residency restrictions" });
  } else {
    // Regional & Municipal Precision Evaluation for Local Programs
    const stateProvince = profile.state || profile.state_province;
    const municipality = profile.municipality;

    const hasCitySpecifics = progMunicipalities.length > 0 && !progMunicipalities.some(m => /^(global|statewide|nationwide|all|other)$/i.test(m));

    if (hasCitySpecifics) {
      if (municipality && progMunicipalities.includes(municipality)) {
        geoScore = 30; // Direct city/municipality match!
        diagnostics.push({ label: "Hyper-Local Match", passed: true, text: `Directly targeted to residents of ${municipality}` });
      } else if (municipality === "Other / Not listed" || (municipality && !progMunicipalities.includes(municipality))) {
        // Restricted to specific municipal boundaries
        disqualifiers.push(`Restricted to city boundaries: ${progMunicipalities.join(", ")}`);
        diagnostics.push({ label: "Municipal Boundary", passed: false, text: `Limited to ${progMunicipalities.join(", ")}` });
      } else {
        geoScore = 20;
        diagnostics.push({ label: "Regional Match", passed: true, text: `Located in your region` });
      }
    } else if (program.state_province && stateProvince && !/^(global|all|nationwide)$/i.test(program.state_province)) {
      if (program.state_province.toLowerCase() === stateProvince.toLowerCase()) {
        geoScore = 25; // State match
        diagnostics.push({ label: "State/Province Match", passed: true, text: `Statewide program for ${stateProvince}` });
      } else {
        disqualifiers.push(`Restricted to ${program.state_province} (Your location: ${stateProvince})`);
        diagnostics.push({ label: "State Boundary", passed: false, text: `Limited to ${program.state_province}` });
      }
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

    const isWoman = userGender === "female" || womenCount > 0;

    if (program.gender_requirement === "female" && !isWoman && userGender !== "abstain") {
      disqualifiers.push("Program is specifically designated for women/female-led households");
      diagnostics.push({ label: "Gender Requirement", passed: false, text: "Designated for women/mothers" });
    } else {
      diagnostics.push({ label: "Demographic Fit", passed: true, text: "Meets household qualification" });
      score += 15;
    }
  } else {
    diagnostics.push({ label: "Gender", passed: true, text: "Universal qualification (No gender restrictions)" });
    score += 15;
  }

  // 2b. Age Criteria Evaluation (Up to 10 points)
  const currentYear = new Date().getFullYear();
  const userAge = profile.birth_year && !isNaN(parseInt(profile.birth_year, 10))
    ? currentYear - parseInt(profile.birth_year, 10)
    : (profile.age && !isNaN(parseInt(profile.age, 10)) ? parseInt(profile.age, 10) : null);

  const minAge = program.min_age !== null && program.min_age !== undefined ? Number(program.min_age) : null;
  const maxAge = program.max_age !== null && program.max_age !== undefined ? Number(program.max_age) : null;

  if (userAge !== null) {
    if (minAge !== null && userAge < minAge) {
      disqualifiers.push(`Minimum age requirement is ${minAge} (Your age: ${userAge})`);
      diagnostics.push({ label: "Age Requirement", passed: false, text: `Minimum age is ${minAge}` });
    } else if (maxAge !== null && userAge > maxAge) {
      disqualifiers.push(`Maximum age requirement is ${maxAge} (Your age: ${userAge})`);
      diagnostics.push({ label: "Age Requirement", passed: false, text: `Maximum age is ${maxAge}` });
    } else if (minAge !== null || maxAge !== null) {
      score += 10;
      diagnostics.push({ 
        label: "Age Fit", 
        passed: true, 
        text: `Meets age criteria (${minAge ? `${minAge}+` : ''}${minAge && maxAge ? ' – ' : ''}${maxAge ? `up to ${maxAge}` : ''})` 
      });
    } else {
      score += 10;
      diagnostics.push({ label: "Age Fit", passed: true, text: "Universal qualification (No age restrictions)" });
    }
  } else {
    diagnostics.push({ label: "Age Fit", passed: true, text: minAge || maxAge ? `Age criteria: ${minAge ? `${minAge}+` : ''}${maxAge ? ` (max ${maxAge})` : ''}` : "No age restrictions" });
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
  const isDigitalPayout = program.payment_method === "digital" || program.payout_rail === "crypto_wallet" || program.distribution_type === "daily_claim_protocol";
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
      text: (isDigitalPayout || program.payout_rail === "crypto_wallet") ? "Compatible with Web3/crypto wallet preference" : "Compatible with standard bank/card delivery" 
    });
  }  // 5. Monthly Value & Application Status Evaluation (Up to 15 points)
  // Only include protocols and programs that are currently accepting applications in the matching criteria.
  const appStatus = (program.application_status || "").toLowerCase();
  const progStatus = (program.status || "").toLowerCase();
  const payoutStatus = (program.payout_status || "").toLowerCase();

  const isPlanned = progStatus === "planned" || appStatus.includes("planned") || progStatus === "upcoming";
  const isHistorical = progStatus === "closed" || progStatus === "completed" || appStatus.includes("pilot completed") || payoutStatus.includes("completed");
  const isClosedOngoing = !isHistorical && (progStatus === "active_closed" || appStatus.includes("no longer accepting") || appStatus.includes("referral") || (payoutStatus.includes("ongoing") && appStatus.includes("no longer")));
  
  const isAcceptingApplications = !isPlanned && !isHistorical && !isClosedOngoing && (
    progStatus === "active_open" ||
    appStatus.includes("accepting") ||
    progStatus === "active" ||
    program.distribution_type === "daily_claim_protocol" ||
    program.distribution_type === "lottery_raffle"
  );

  if (!isAcceptingApplications) {
    if (isPlanned) {
      disqualifiers.push("Program is in planning stage and not yet open for applications");
      diagnostics.push({ label: "Application Status", passed: false, text: "Planned / Upcoming initiative" });
    } else if (isHistorical) {
      disqualifiers.push("Program is a completed historical initiative");
      diagnostics.push({ label: "Application Status", passed: false, text: "Closed / Completed pilot" });
    } else {
      disqualifiers.push("Program is no longer accepting new applications (Closed, ongoing cohort)");
      diagnostics.push({ label: "Application Status", passed: false, text: "No longer accepting applications" });
    }
    fitBreakdown.status = 0;
  } else {
    fitBreakdown.status = 15;
    score += 15;
    diagnostics.push({ 
      label: "Application Status", 
      passed: true, 
      text: "Actively accepting applications or claims" 
    });
  }

  // Final score clamping
  const finalScore = Math.min(100, Math.max(10, score));

  // Determine Tier
  let tier = TIERS.TIER_1_GUARANTEED;
  if (!isAcceptingApplications) {
    tier = null;
  } else if (program.distribution_type === "daily_claim_protocol" || /GoodDollar|Circles|World WLD/i.test(program.name || "")) {
    tier = TIERS.TIER_2_DAILY_CLAIM;
  } else if (program.distribution_type === "lottery_raffle" || /Mein Grundeinkommen/i.test(program.name || "")) {
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
