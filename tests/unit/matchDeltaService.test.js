import { beforeEach, describe, expect, it, vi } from "vitest";

const { fromMock, reportMock } = vi.hoisted(() => ({
  fromMock: vi.fn(),
  reportMock: vi.fn(),
}));

vi.mock("@/lib/supabaseClient", () => ({
  supabase: { from: fromMock },
}));

vi.mock("@/lib/matchingEngine", () => ({
  generateUserMatchReport: reportMock,
}));

import {
  getUserNotifications,
  markNotificationsAsRead,
  syncMatchSnapshotAndDetectDeltas,
} from "@/lib/matchDeltaService";

function query(result = { data: [], error: null }) {
  const chain = {
    select: vi.fn(() => chain),
    eq: vi.fn(() => chain),
    order: vi.fn(() => chain),
    limit: vi.fn(() => chain),
    insert: vi.fn(() => chain),
    update: vi.fn(() => chain),
    in: vi.fn(() => chain),
    then: (resolve, reject) => Promise.resolve(result).then(resolve, reject),
  };
  return chain;
}

function report(programs = []) {
  return {
    rankedMatches: programs,
    tierSummary: {
      tier_1_guaranteed: programs.filter(({ tier }) => tier === "tier_1_guaranteed"),
      tier_2_daily_claim: programs.filter(({ tier }) => tier === "tier_2_daily_claim"),
      tier_3_lottery: [],
    },
    totalPotentialMonthlyUsd: programs.reduce((sum, item) => sum + Number(item.monthly_amount_usd || 0), 0),
  };
}

beforeEach(() => {
  const values = new Map();
  vi.stubGlobal("localStorage", {
    getItem: vi.fn((key) => values.get(key) ?? null),
    setItem: vi.fn((key, value) => values.set(key, value)),
  });
  fromMock.mockImplementation(() => query());
  reportMock.mockReset();
});

describe("syncMatchSnapshotAndDetectDeltas", () => {
  it("returns null without programs and stops on an incomplete profile", async () => {
    expect(await syncMatchSnapshotAndDetectDeltas(null, {}, [])).toBeNull();
    reportMock.mockReturnValue({ incompleteProfile: true, rankedMatches: [] });
    await expect(syncMatchSnapshotAndDetectDeltas(null, {}, [{}])).resolves.toEqual({
      currentReport: { incompleteProfile: true, rankedMatches: [] },
      deltas: [],
    });
  });

  it("stores a first anonymous snapshot without producing deltas", async () => {
    const current = report([{ program_id: 1, name: "Cash", matchScore: 90, status: "active", monthly_amount_usd: 100, tier: "tier_1_guaranteed" }]);
    reportMock.mockReturnValue(current);
    const result = await syncMatchSnapshotAndDetectDeltas(null, { country: "Canada" }, [{}]);
    expect(result.deltas).toEqual([]);
    expect(result.newAlerts).toEqual([]);
    expect(localStorage.setItem).toHaveBeenCalledOnce();
    expect(fromMock).not.toHaveBeenCalled();
  });

  it("detects new, demoted, and status-changed programs from local history", async () => {
    localStorage.getItem.mockReturnValue(JSON.stringify({
      matched_program_ids: [1, 2],
      match_scores: { 1: 80, 2: 70 },
      status_map: { 1: "planned", 2: "active" },
    }));
    const current = report([
      { program_id: 1, name: "Changed", matchScore: 95, status: "active", monthly_amount_usd: 100, tier: "tier_1_guaranteed" },
      { program_id: 3, name: "New", matchScore: 88, application_status: "Accepting", monthly_amount_usd: 50, tier: "tier_2_daily_claim" },
    ]);
    reportMock.mockReturnValue(current);

    const result = await syncMatchSnapshotAndDetectDeltas(null, {}, [
      { program_id: 1, name: "Changed" },
      { program_id: 2, name: "Removed" },
      { program_id: 3, name: "New" },
    ]);

    expect(result.deltas.map(({ type }) => type)).toEqual([
      "new_program_available",
      "program_demoted",
      "status_changed",
    ]);
    expect(result.newAlerts).toHaveLength(3);
  });

  it("uses the remote snapshot and persists authenticated snapshots and alerts", async () => {
    const snapshotQuery = query({
      data: [{ matched_program_ids: [9], match_scores: {}, status_map: {} }],
      error: null,
    });
    const inserts = [];
    fromMock.mockImplementation((table) => {
      if (table === "user_match_snapshots" && fromMock.mock.calls.filter(([name]) => name === table).length === 1) return snapshotQuery;
      const chain = query();
      chain.insert.mockImplementation((rows) => {
        inserts.push([table, rows]);
        return chain;
      });
      return chain;
    });
    reportMock.mockReturnValue(report([
      { program_id: 10, name: "Authenticated", matchScore: 91, status: "active", monthly_amount_usd: 75, tier: "tier_1_guaranteed" },
    ]));

    const result = await syncMatchSnapshotAndDetectDeltas({ id: "user-1" }, { id: "profile-1" }, [{ program_id: 9, name: "Old" }]);
    expect(result.deltas).toHaveLength(2);
    expect(inserts.map(([table]) => table)).toEqual(["user_match_snapshots", "user_notifications"]);
  });

  it("survives unreadable local storage and database failures", async () => {
    localStorage.getItem.mockReturnValue("not-json");
    localStorage.setItem.mockImplementation(() => { throw new Error("quota"); });
    const failing = query();
    failing.then = (resolve, reject) => Promise.reject(new Error("offline")).then(resolve, reject);
    fromMock.mockReturnValue(failing);
    reportMock.mockReturnValue(report([{ program_id: 1, name: "Cash", matchScore: 90, status: "active", tier: "tier_1_guaranteed" }]));

    await expect(syncMatchSnapshotAndDetectDeltas({ id: "user-1" }, {}, [{}])).resolves.toMatchObject({ deltas: [] });
  });
});

describe("notification helpers", () => {
  it("returns no notifications without a user or when the query fails", async () => {
    expect(await getUserNotifications(null)).toEqual([]);
    const failing = query({ data: null, error: new Error("denied") });
    fromMock.mockReturnValue(failing);
    expect(await getUserNotifications({ id: "user-1" })).toEqual([]);
  });

  it("returns recent notifications", async () => {
    fromMock.mockReturnValue(query({ data: [{ id: 1 }], error: null }));
    expect(await getUserNotifications({ id: "user-1" })).toEqual([{ id: 1 }]);
  });

  it("marks selected or all notifications read and ignores missing users", async () => {
    await expect(markNotificationsAsRead(null, [1])).resolves.toBeUndefined();

    const selected = query();
    fromMock.mockReturnValue(selected);
    await markNotificationsAsRead({ id: "user-1" }, [1, 2]);
    expect(selected.in).toHaveBeenCalledWith("id", [1, 2]);

    const all = query();
    fromMock.mockReturnValue(all);
    await markNotificationsAsRead({ id: "user-1" });
    expect(all.in).not.toHaveBeenCalled();

    const failing = query();
    failing.then = (resolve, reject) => Promise.reject(new Error("offline")).then(resolve, reject);
    fromMock.mockReturnValue(failing);
    await expect(markNotificationsAsRead({ id: "user-1" }, [1])).resolves.toBeUndefined();
  });
});
