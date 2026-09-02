import { describe, expect, it, vi } from "vitest";
import {
  TIERS,
  evaluateEligibility,
  generateUserMatchReport,
  getIncomeUpperLimit,
  isProfileComplete,
} from "@/lib/matchingEngine";

const profile = {
  country: "United States",
  state: "California",
  municipality: "Stockton",
  gender: "female",
  age: 30,
  income_range: "0-20k",
  accepts_digital_currency: true,
};

const program = {
  program_id: 1,
  name: "Open Cash Program",
  available_regions: ["United States"],
  state_province: "California",
  status: "active_open",
  application_status: "Accepting applications",
  payment_method: "standard",
  monthly_amount_usd: 500,
  internal_status: "active",
};

describe("matching helpers", () => {
  it("maps known income ranges and treats missing or unknown ranges as unbounded", () => {
    expect(getIncomeUpperLimit("0-20k")).toBe(20_000);
    expect(getIncomeUpperLimit("60k+")).toBe(999_999);
    expect(getIncomeUpperLimit()).toBe(Infinity);
    expect(getIncomeUpperLimit("unknown")).toBe(Infinity);
  });

  it("requires country and state only for the United States and Canada", () => {
    expect(isProfileComplete()).toBe(false);
    expect(isProfileComplete({ country: "" })).toBe(false);
    expect(isProfileComplete({ country: "United States" })).toBe(false);
    expect(isProfileComplete({ country: "Canada", state_province: "Ontario" })).toBe(true);
    expect(isProfileComplete({ country: "Germany" })).toBe(true);
  });
});

describe("evaluateEligibility", () => {
  it("rejects missing, deleted, and incomplete inputs", () => {
    expect(evaluateEligibility(null, profile)).toMatchObject({ eligible: false, score: 0, tier: null });
    expect(evaluateEligibility({ ...program, internal_status: "deleted" }, profile).eligible).toBe(false);
    expect(evaluateEligibility(program, { country: "United States" })).toMatchObject({
      eligible: false,
      score: 0,
      fitBreakdown: { geographic: 0, economic: 0, value: 0, rail: 0, status: 0 },
    });
  });

  it("qualifies a global, unconditional, open cash program", () => {
    const result = evaluateEligibility({ ...program, available_regions: [], state_province: "" }, profile);
    expect(result).toMatchObject({ eligible: true, score: 100, tier: TIERS.TIER_1_GUARANTEED });
    expect(result.fitBreakdown).toMatchObject({ geographic: 25, economic: 20, rail: 15, status: 15 });
  });

  it("handles country, municipality, and state boundaries", () => {
    expect(evaluateEligibility({ ...program, available_regions: ["Canada"] }, profile).reasons[0]).toContain("Restricted to Canada");

    const cityProgram = { ...program, municipalities: ["Stockton"] };
    expect(evaluateEligibility(cityProgram, profile).fitBreakdown.geographic).toBe(30);
    expect(evaluateEligibility(cityProgram, { ...profile, municipality: "Other / Not listed" }).eligible).toBe(false);
    expect(evaluateEligibility(cityProgram, { ...profile, municipality: null }).fitBreakdown.geographic).toBe(20);

    expect(evaluateEligibility({ ...program, state_province: "California" }, profile).fitBreakdown.geographic).toBe(25);
    expect(evaluateEligibility({ ...program, state_province: "Texas" }, profile).eligible).toBe(false);
    expect(evaluateEligibility({ ...program, state_province: "" }, profile).fitBreakdown.geographic).toBe(22);
  });

  it("evaluates gender and age criteria", () => {
    const restricted = { ...program, gender_requirement: "female", min_age: 25, max_age: 40 };
    expect(evaluateEligibility(restricted, profile).eligible).toBe(true);
    expect(evaluateEligibility(restricted, { ...profile, gender: "male" }).eligible).toBe(false);
    expect(evaluateEligibility(restricted, { ...profile, gender: "abstain" }).eligible).toBe(true);
    expect(evaluateEligibility(restricted, { ...profile, gender: "male", women_count: "1" }).eligible).toBe(true);
    expect(evaluateEligibility(restricted, { ...profile, age: 20 }).reasons[0]).toContain("Minimum age");
    expect(evaluateEligibility(restricted, { ...profile, age: 50 }).reasons[0]).toContain("Maximum age");
    expect(evaluateEligibility(restricted, { ...profile, age: "30" }).eligible).toBe(true);
    expect(evaluateEligibility(restricted, { ...profile, age: null }).diagnostics.some(({ label }) => label === "Age Fit")).toBe(true);
  });

  it("evaluates income and payout compatibility", () => {
    const capped = { ...program, max_household_income_usd: 30_000 };
    expect(evaluateEligibility(capped, profile).fitBreakdown.economic).toBe(25);
    expect(evaluateEligibility(capped, { ...profile, income_range: "40k-60k" }).eligible).toBe(false);

    const digital = { ...program, payment_method: "digital", payout_rail: "crypto_wallet" };
    expect(evaluateEligibility(digital, { ...profile, accepts_digital_currency: false }).fitBreakdown.rail).toBe(0);
    expect(evaluateEligibility(digital, profile).fitBreakdown.rail).toBe(15);
  });

  it("classifies planned, historical, closed, daily-claim, and lottery programs", () => {
    expect(evaluateEligibility({ ...program, status: "planned", application_status: "Planned" }, profile)).toMatchObject({ eligible: false, tier: null });
    expect(evaluateEligibility({ ...program, status: "completed", payout_status: "Completed" }, profile).reasons[0]).toContain("completed historical");
    expect(evaluateEligibility({ ...program, status: "active_closed", application_status: "No longer accepting" }, profile).reasons[0]).toContain("no longer accepting");
    expect(evaluateEligibility({ ...program, name: "GoodDollar", distribution_type: "daily_claim_protocol" }, profile).tier).toBe(TIERS.TIER_2_DAILY_CLAIM);
    expect(evaluateEligibility({ ...program, name: "Community Draw", distribution_type: "lottery_raffle" }, profile).tier).toBe(TIERS.TIER_3_LOTTERY);
  });
});

describe("generateUserMatchReport", () => {
  it("returns an incomplete report while preserving visible programs", () => {
    vi.useFakeTimers();
    vi.setSystemTime(new Date("2026-09-01T00:00:00Z"));
    const result = generateUserMatchReport({ country: "United States" }, [program, { ...program, program_id: 2, internal_status: "deleted" }]);
    expect(result).toMatchObject({ incompleteProfile: true, totalEligibleCount: 0, averageScore: 0 });
    expect(result.demotedOrIneligible).toHaveLength(1);
    expect(result.generatedAt).toBe("2026-09-01T00:00:00.000Z");
    vi.useRealTimers();
  });

  it("ranks eligible matches, separates ineligible programs, and totals cash tiers", () => {
    const programs = [
      { ...program, program_id: 1, monthly_amount_usd: 100 },
      { ...program, program_id: 2, monthly_amount_usd: 900 },
      { ...program, program_id: 3, name: "GoodDollar", distribution_type: "daily_claim_protocol", monthly_amount_usd: 25 },
      { ...program, program_id: 4, available_regions: ["Canada"] },
      { ...program, program_id: 5, internal_status: "deleted" },
    ];
    const result = generateUserMatchReport(profile, programs);
    expect(result.totalEligibleCount).toBe(3);
    expect(result.rankedMatches.map(({ program_id }) => program_id)).toEqual([2, 1, 3]);
    expect(result.demotedOrIneligible).toHaveLength(1);
    expect(result.totalPotentialMonthlyUsd).toBe(1025);
    expect(result.averageScore).toBeGreaterThan(0);
    expect(result.tierSummary[TIERS.TIER_2_DAILY_CLAIM]).toHaveLength(1);
  });

  it("returns zero aggregate values when no program is eligible", () => {
    const result = generateUserMatchReport(profile, [{ ...program, available_regions: ["Canada"] }]);
    expect(result).toMatchObject({ totalEligibleCount: 0, averageScore: 0, totalPotentialMonthlyUsd: 0 });
  });
});
