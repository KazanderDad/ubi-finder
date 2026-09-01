# Repository Engineering Baseline

## 2026-09-01T17:17:19Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `b3b6a29bb6bac76b976adfae358eac2a84180751`
- **issue:** [#8 Normalize repository foundation and engineering documentation](https://github.com/ubi-labs/ubi-finder/issues/8)
- **summary:** Expanded repository operating rules and validation gates; standardized branch-session evidence; established current and target-state engineering documentation; corrected README and contribution workflows; preserved concise Base44 reconstruction provenance; refreshed roadmap and status guidance.
- **validation:** `git diff --check`; repository search for stale backlog paths, package-manager commands, and non-canonical GitHub links; local Markdown target inventory; live verification of merge settings and Project #1 issue hierarchy.
- **follow-ups:** Complete ordered Tasks #9–#12, then refresh this status table from final validation evidence.

## 2026-09-01T19:00:34Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `7dcda9c77024323a6c618a912b51172501517b30`
- **issue:** [#7 Establish the UBI Finder engineering baseline](https://github.com/ubi-labs/ubi-finder/issues/7)
- **summary:** Aligned the documented and enforced runtime baseline on Node.js 22 after the isolated CI acceptance environment demonstrated that the current Supabase client requires native WebSocket support. The shared application CI and isolated Supabase acceptance workflow now use the same Node version.
- **validation:** `npm install --package-lock-only --ignore-scripts`; `npm run lint`; zero-error `npm run typecheck`; `npm run test:coverage` (40 tests; 99.61% statements, 86.72% branches, 100% functions, 99.59% lines); explicit-environment `npm run build`; `git diff --check`.
- **follow-ups:** Re-run GitHub CI, including the three Playwright scenarios against the workflow-owned isolated Supabase runtime; leave PR #13 unmerged for review.
