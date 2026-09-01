import { afterEach, describe, expect, it, vi } from "vitest";

afterEach(() => {
  vi.unstubAllGlobals();
  vi.resetModules();
});

describe("utility helpers", () => {
  it("merges conditional Tailwind classes deterministically", async () => {
    const { cn } = await import("@/lib/utils");
    const shouldHide = false;
    expect(cn("px-2", shouldHide && "hidden", "px-4", ["text-sm"])).toBe("px-4 text-sm");
  });

  it("is safe outside a browser", async () => {
    vi.stubGlobal("window", undefined);
    const { isIframe } = await import("@/lib/utils");
    expect(isIframe).toBe(false);
  });

  it("detects an embedded browser context", async () => {
    vi.stubGlobal("window", { self: {}, top: {} });
    const { isIframe } = await import("@/lib/utils");
    expect(isIframe).toBe(true);
  });
});
