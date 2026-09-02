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

## 2026-09-01T18:25:00Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `d0182eddfea813b2a9cf0782dbe901fc6cd65612`
- **issue:** [#11 Normalize and validate the Supabase delivery contract](https://github.com/ubi-labs/ubi-finder/issues/11)
- **summary:** Made root `supabase/` the sole database source; removed the byte-identical application migration mirror and tracked hosted fallback; added explicit local/remote Vite modes and examples; made missing browser configuration fail clearly; assigned the coordinator-reserved `6032x` local port family; pinned production and PR validation to Supabase CLI 2.116.0; removed the production project fallback; added clean reset, seed, and database-lint PR validation; repaired the deferred program-status enum comparison exposed by the first isolated replay.
- **validation:** `diff -qr supabase src/supabase` established migration/seed identity before deletion; `npm run lint`; `npm run typecheck`; production build with explicit non-secret CI placeholders; `git diff --check`; coordinator confirmed no host/Docker bindings on ports 60320–60329 and reserved the family for `ubi-finder`.
- **follow-ups:** Runtime reset, seed, database lint, and browser acceptance remain queued behind shared stack capacity. The exact committed checkout must be copied to a Colima-visible `/Users/botmaster/...` path before the coordinator can grant the bounded lease.

## 2026-09-01T18:40:00Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `3265b761647d3992253183bec3d81627099c6fc2`
- **issue:** [#12 Remove disposable artifacts and runtime duplicates](https://github.com/ubi-labs/ubi-finder/issues/12)
- **summary:** Removed raw Base44 reconstruction inputs after provenance preservation; removed the unused Layout and legacy SubmitProgram implementations, redundant community seed, and tracked Supabase CLI state; replaced broad root script/environment ignores with targeted generated-state rules; manifested and moved the 56 live ignored scratch scripts/logs to recoverable Trash. The plan's expected count was 57, but only 56 existed at cleanup time.
- **validation:** Exact-filename reference searches; modification-time inventory (all scratch artifacts dated 2026-08-19 or earlier); root scratch count before/after (`56`/`0`); Trash count (`56`); canonical seed/config checks; `npm run lint`; `npm run typecheck`; `npm run test:coverage`; explicit-environment production build; `git diff --check`.
- **follow-ups:** Complete the coordinator-granted runtime validation, publish the PR, wait for green CI, request review once, and leave the Goal and Tasks in review until merge.

## 2026-09-01T19:00:34Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `7dcda9c77024323a6c618a912b51172501517b30`
- **issue:** [#7 Establish the UBI Finder engineering baseline](https://github.com/ubi-labs/ubi-finder/issues/7)
- **summary:** Aligned the documented and enforced runtime baseline on Node.js 22 after the isolated CI acceptance environment demonstrated that the current Supabase client requires native WebSocket support. The shared application CI and isolated Supabase acceptance workflow now use the same Node version.
- **validation:** `npm install --package-lock-only --ignore-scripts`; `npm run lint`; zero-error `npm run typecheck`; `npm run test:coverage` (40 tests; 99.61% statements, 86.72% branches, 100% functions, 99.59% lines); explicit-environment `npm run build`; `git diff --check`.
- **follow-ups:** Re-run GitHub CI, including the three Playwright scenarios against the workflow-owned isolated Supabase runtime; leave PR #13 unmerged for review.

## 2026-09-01T19:06:22Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `ddb6e221588c1302be6c70bf624ae76fb28eac08`
- **issue:** [#10 Govern unit coverage and local browser acceptance](https://github.com/ubi-labs/ubi-finder/issues/10)
- **summary:** Tightened browser acceptance selectors after the first isolated CI execution reached the real UI: the authentication submit now resolves exactly, and catalog acceptance asserts the default list view before selecting an actual program.
- **validation:** GitHub Actions run `33547152829` proved clean migration replay, seed, and database lint before executing all three browser scenarios; one scenario passed and two failed only at the corrected selectors. `npx playwright test --config playwright.config.js --list` confirms the three-test harness remains discoverable.
- **follow-ups:** Re-run the workflow-owned isolated Supabase and Chromium acceptance gate; leave PR #13 unmerged for review.

## 2026-09-01T19:10:48Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `64f8c0d7ae22b2e7dfba6b0a5418df8af617de75`
- **issue:** [#10 Govern unit coverage and local browser acceptance](https://github.com/ubi-labs/ubi-finder/issues/10)
- **summary:** Replaced two remaining text-role assumptions with the actual rendered contracts exposed by CI: the list-view card title is visible text rather than a semantic heading, and the protected report heading is `Personalized UBI Income Portfolio`.
- **validation:** GitHub Actions run `33547650725` completed migration replay, seed, database lint, authentication, dashboard navigation, and report navigation; one browser scenario passed, the authenticated scenario reached the protected report and was retry-pass/flaky, and the catalog scenario stopped only at the corrected title role.
- **follow-ups:** Re-run the workflow-owned acceptance gate and require all three scenarios to pass without retries; leave PR #13 unmerged for review.

## 2026-09-01T19:15:10Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `70e20f7adf8566fd720945b91322fb27e0f2afe9`
- **issue:** [#10 Govern unit coverage and local browser acceptance](https://github.com/ubi-labs/ubi-finder/issues/10)
- **summary:** Corrected the final catalog-detail assertion to match the card-title primitive's rendered text contract after CI proved navigation to the selected program detail route.
- **validation:** GitHub Actions run `33548068254` completed database reset, seed, lint, authentication, protected dashboard/report navigation, eligibility persistence, catalog loading, program selection, and detail-route navigation; two scenarios passed and the remaining scenario stopped only at the corrected semantic-role assumption.
- **follow-ups:** Re-run the isolated acceptance gate and require all three scenarios to pass; leave PR #13 unmerged for review.

## 2026-09-01T19:21:25Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `22bbf9e7d2bf31bedcb45f28b83071ecaaa6e78f`
- **issue:** [#11 Normalize the Supabase migration and environment contract](https://github.com/ubi-labs/ubi-finder/issues/11)
- **summary:** Removed the final byte-identical migration residue under `src/supabase`; the 569,366-byte migration remains unchanged in canonical root `supabase/migrations`, leaving root `supabase/` as the sole backend source.
- **validation:** `cmp` proved byte identity before deletion; `git ls-files src/supabase` is empty afterward; final [Supabase validation and acceptance run](https://github.com/ubi-labs/ubi-finder/actions/runs/33548466944) passed isolated reset, seed, database lint, and all three Chromium scenarios before the canonicality residue correction.
- **follow-ups:** Re-run the green required checks on the final canonical tree; leave PR #13 unmerged for review.

## 2026-09-01T19:27:49Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `e440e885f9606289068f3f7053ef6a35f5ec79f4`
- **issue:** [#8 Normalize repository foundation and engineering documentation](https://github.com/ubi-labs/ubi-finder/issues/8)
- **summary:** Strengthened the repository implementation contract so every behavior change must add requisite automated coverage and/or update the affected existing tests. Implementations with genuinely impractical automated coverage must record the reason and specific alternative validation in both the session log and pull request.
- **validation:** Reviewed the rule in context with the existing lint, typecheck, coverage, build, acceptance, and migration gates; `git diff --check` passed.
- **follow-ups:** Re-run required PR checks after folding the documentation follow-up into the existing five-commit review structure; leave PR #13 unmerged.

## 2026-09-02T00:29:53Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `3d2aabb29445953d89aae991985135ba5c0e3ba3`
- **issue:** [#7 Establish the UBI Finder engineering baseline](https://github.com/ubi-labs/ubi-finder/issues/7)
- **summary:** Rebased the five-commit engineering baseline onto `origin/main` at `c3820c785ec43263004d9d16410d31c8c55f56a6`. Preserved main's supporter/donation and participation work while retaining the `createPageUrl` import required by repository-wide typechecking; kept Supabase CLI state untracked by resolving the modified/deleted `supabase/.temp/cli-latest` conflict as a deletion.
- **validation:** Clean `npm ci`; `npm run lint`; zero-error `npm run typecheck`; `npm run test:coverage` (40 tests; 99.61% statements, 86.72% branches, 100% functions, 99.59% lines); explicit-environment `npm run build`; `git diff --check`; conflict-marker scan.
- **follow-ups:** Force-push with lease protection, wait for final PR CI and isolated Supabase/browser acceptance, keep Goal #7 and Tasks #8-#12 `In Review`, and leave PR #13 unmerged.

## 2026-09-02T00:33:34Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `442a12b2f0f55af9825fa59f2854248f13d4fad1`
- **issue:** [#11 Normalize the Supabase migration and environment contract](https://github.com/ubi-labs/ubi-finder/issues/11)
- **summary:** Resolved the post-rebase migration-version collision by renumbering the branch's trigger-repair migration from `00018` to the next version after main, `00028`. The SQL bytes are unchanged; main's `00018_add_participation_status_to_user_self_applications.sql` and migrations `00019`-`00027` remain intact.
- **validation:** GitHub Actions run `33575607921` isolated the duplicate `schema_migrations` version failure; SHA-256 before/after rename matched; the migration-version inventory contains no duplicates; application CI and Vercel passed on the rebased head.
- **follow-ups:** Force-push the narrow migration rename, require clean reset/seed/lint and all three Chromium scenarios in CI, keep Goal #7 and Tasks #8-#12 `In Review`, and leave PR #13 unmerged.

## 2026-09-02T00:37:23Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `0ddb5ee4f6772bdbf345216c190b606afdaf27e8`
- **issue:** [#11 Normalize the Supabase migration and environment contract](https://github.com/ubi-labs/ubi-finder/issues/11)
- **summary:** Corrected malformed PL/pgSQL dollar quoting in main's `00020_ingest_all_unmatched_stanford_experiments.sql`, where shell expansion had replaced both `$$` delimiters with process ID `33517`. The function body and all data statements remain unchanged.
- **validation:** GitHub Actions run `33575863175` replayed migrations through `00019` and isolated the syntax error at `AS 33517`; `git diff --check` passed; a repository-wide migration scan found no remaining numeric function delimiters.
- **follow-ups:** Fold the correction into the Supabase contract commit, rerun isolated reset/seed/database lint and all Chromium scenarios, keep Goal #7 and Tasks #8-#12 `In Review`, and leave PR #13 unmerged.

## 2026-09-02T00:40:05Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `94684f6c9179d438d1904e0a811f1c98d2d4d815`
- **issue:** [#11 Normalize the Supabase migration and environment contract](https://github.com/ubi-labs/ubi-finder/issues/11)
- **summary:** Added explicit `TEXT[]` casts to all 50 empty `municipalities` arrays in main's generated migration `00020`. This preserves the intended empty values while making their PostgreSQL type deterministic during clean replay.
- **validation:** GitHub Actions run `33576117986` replayed migrations through statement 81 in `00020` and isolated the first untyped array; inspection confirmed every affected value occupies the `municipalities` column; the repository-wide untyped-empty-array scan is now clear; `git diff --check` passed.
- **follow-ups:** Fold the casts into the Supabase contract commit, rerun the workflow-owned isolated database and browser acceptance gate, keep Goal #7 and Tasks #8-#12 `In Review`, and leave PR #13 unmerged.

## 2026-09-02T00:43:06Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `af99bae6ed26ebaa6166093dc885437f9d3343ec`
- **issue:** [#11 Normalize the Supabase migration and environment contract](https://github.com/ubi-labs/ubi-finder/issues/11)
- **summary:** Removed the explicit `program_id` collision between main migrations `00020` and `00022` by moving the 18 universal-demogrant records from IDs `360`-`377` to the unused range `382`-`399`. Migration `00020` retains IDs `101`-`374`, and `00023` retains IDs `378`-`381`; record content and name-based idempotency guards are unchanged.
- **validation:** GitHub Actions run `33576300218` replayed migrations through `00021` and isolated duplicate ID `360` at `00022`; extracted program-ID inventories now have no overlap across `00020`, `00022`, and `00023`; no later migration references the old numeric IDs; `git diff --check` passed.
- **follow-ups:** Fold the ID correction into the Supabase contract commit, rerun isolated reset/seed/database lint and browser acceptance, keep Goal #7 and Tasks #8-#12 `In Review`, and leave PR #13 unmerged.

## 2026-09-02T00:47:54Z

- **agent:** Codex
- **branch:** `codex/repository-engineering-baseline`
- **head:** `85d768acb5590fcfe536eb2911e403a962fb23e8`
- **issue:** [#10 Govern unit coverage and local browser acceptance](https://github.com/ubi-labs/ubi-finder/issues/10)
- **summary:** Updated public catalog acceptance for the rebased UI by relying on the catalog's default all-programs state and explicitly waiting for the first rendered program. This removes the stale exact-name dependency on an `All` button whose accessible name now includes its live count.
- **validation:** GitHub Actions run `33576503073` passed clean migration replay, seed, database lint, authentication, protected dashboard/report navigation, and eligibility persistence; the catalog scenario failed only at the stale exact button name. `npm run test:acceptance:local -- --list` discovers all three Chromium scenarios; `git diff --check` passed.
- **follow-ups:** Fold the assertion update into the acceptance commit, rerun all required PR checks, keep Goal #7 and Tasks #8-#12 `In Review`, and leave PR #13 unmerged.
