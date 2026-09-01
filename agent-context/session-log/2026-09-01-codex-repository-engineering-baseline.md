# Repository Engineering Baseline

## 2026-09-01T17:17:19Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `b3b6a29bb6bac76b976adfae358eac2a84180751`
- **issue:** [#8 Normalize repository foundation and engineering documentation](https://github.com/ubi-labs/ubi-finder/issues/8)
- **summary:** Expanded repository operating rules and validation gates; standardized branch-session evidence; established current and target-state engineering documentation; corrected README and contribution workflows; preserved concise Base44 reconstruction provenance; refreshed roadmap and status guidance.
- **validation:** `git diff --check`; repository search for stale backlog paths, package-manager commands, and non-canonical GitHub links; local Markdown target inventory; live verification of merge settings and Project #1 issue hierarchy.
- **follow-ups:** Complete ordered Tasks #9–#12, then refresh this status table from final validation evidence.

## 2026-09-01T17:58:00Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `b1afa45b507377cd9559ef5bcc074c101b23e5a2`
- **issue:** [#9 Repair JavaScript typechecking and enforce quality CI](https://github.com/ubi-labs/ubi-finder/issues/9)
- **summary:** Replaced the partial JavaScript project with repository-wide `checkJs`; added Leaflet declarations; documented flexible pass-through contracts for legacy shared UI primitives; repaired all application diagnostics, including undefined legacy Base44 calls and missing imports; added lint, typecheck, coverage, and build steps to application CI.
- **validation:** `npm run typecheck` passed with zero diagnostics in the canonical worktree; `npm run lint` passed; `npm run build` passed with the existing bundle-size warning; the same checks passed in the internal scratch dependency mirror used to avoid repeated external-volume package I/O.
- **follow-ups:** Task #10 must add the governed coverage command referenced by CI. Existing bundle splitting remains tracked separately in issue #6.

## 2026-09-01T18:15:00Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `563b028`
- **issue:** [#10 Govern unit coverage and local browser acceptance](https://github.com/ubi-labs/ubi-finder/issues/10)
- **summary:** Added Vitest coverage governance for matching, match-delta, program-status, and shared utility behavior; extracted the catalog status classifier into a deterministic core module; added a Chromium Playwright harness with local-only fixture setup for public discovery, eligibility persistence, authentication, dashboard, and report paths. The harness consumes an allocated Supabase runtime and refuses hosted URLs.
- **validation:** `npm run lint`; `npm run typecheck`; `npm run test:coverage` (40 tests; 99.61% statements, 87.34% branches, 100% functions, 99.59% lines); `npx playwright test --config playwright.config.js --list` (3 Chromium tests); `git diff --check`.
- **follow-ups:** Execute the three browser scenarios after Task #11 establishes the collision-free local Supabase port family and the coordinator grants an exact-head lease.
