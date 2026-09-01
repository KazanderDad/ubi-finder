import { describe, expect, it } from "vitest";
import { matchesProgramStatus } from "@/lib/programStatus";

describe("matchesProgramStatus", () => {
  it.each([
    [{ status: "active_open" }, "accepting_applications", true],
    [{ application_status: "Accepting applications" }, "accepting_applications", true],
    [{ status: "active" }, "accepting_applications", true],
    [{ distribution_type: "daily_claim_protocol" }, "accepting_applications", true],
    [{ distribution_type: "lottery_raffle" }, "accepting_applications", true],
    [{ status: "planned" }, "planned", true],
    [{ application_status: "Planned launch" }, "planned", true],
    [{ status: "upcoming" }, "planned", true],
    [{ status: "closed" }, "closed_historical", true],
    [{ status: "completed" }, "closed_historical", true],
    [{ application_status: "Pilot completed" }, "closed_historical", true],
    [{ payout_status: "Completed" }, "closed_historical", true],
    [{ status: "active_closed" }, "closed_ongoing", true],
    [{ application_status: "Referral enrollment only" }, "closed_ongoing", true],
    [{ payout_status: "Ongoing", application_status: "No longer accepting" }, "closed_ongoing", true],
    [{ status: "active_open" }, "all", true],
    [{ status: "active_open" }, "unknown", true],
  ])("classifies %o as %s", (program, filter, expected) => {
    expect(matchesProgramStatus(program, filter)).toBe(expected);
  });

  it("does not classify planned, historical, or closed programs as accepting", () => {
    expect(matchesProgramStatus({ status: "planned" }, "accepting_applications")).toBe(false);
    expect(matchesProgramStatus({ status: "completed" }, "accepting_applications")).toBe(false);
    expect(matchesProgramStatus({ application_status: "No longer accepting" }, "accepting_applications")).toBe(false);
    expect(matchesProgramStatus({ status: "active" }, "planned")).toBe(false);
  });
});
