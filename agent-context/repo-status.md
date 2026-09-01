# Repository Status

Assessment date: 2026-09-01

| Requirement | Current status |
|---|---|
| Repository shape | Pass — single React 18/Vite 6 frontend backed by Supabase Auth, PostgreSQL, Storage, and one Edge Function; npm is canonical from `package-lock.json`. |
| Branch and integration workflow | Pass — `main` is the integration/release branch; `AGENTS.md` requires feature branches and pull requests for shared changes. |
| README quality | Pass — product purpose, npm setup, explicit Supabase modes, validation commands, repository structure, engineering docs, and roadmap links are documented by [#8](https://github.com/ubi-labs/ubi-finder/issues/8). |
| License | Pass — MIT license is present and matches the README badge and license section. |
| AGENTS guidance | Pass — `AGENTS.md` documents the canonical repository and Project, statuses, branch safety, validation gates, npm contract, repository map, roadmap hierarchy, session logs, documentation placement, and Supabase lifecycle. |
| Session log | Pass — canonical append-only branch log guidance includes required metadata, issue linkage, and the before-commit update rule. |
| GitHub Issues and Project | Pass — [Goal #7](https://github.com/ubi-labs/ubi-finder/issues/7) owns ordered Tasks [#8](https://github.com/ubi-labs/ubi-finder/issues/8)–[#12](https://github.com/ubi-labs/ubi-finder/issues/12) in the [UBI Finder Project](https://github.com/orgs/ubi-labs/projects/1). |
| GitHub merge settings | Pass — squash merging is disabled; merge commits and rebase merges are enabled; automatic branch deletion is disabled. |
| Active roadmap hygiene | Pass — GitHub Issues/Project are active; local product ideas and `future-ideas.md` are explicitly target-state reference only. |
| Deferred ideas reference | Pass — `agent-context/future-ideas.md` now states that deferred ideas are not the active roadmap. |
| Engineering documentation | Pass — `docs/engineering/` covers current architecture, testing, Supabase environments, and migration provenance. |
| Target-state documentation | Pass — unimplemented product ideas are isolated and labeled under `docs/engineering/target-state/`. |
| Cubid architecture | Not applicable — Cubid appears only as an external ecosystem link and is not an implemented subsystem. |
| Testing strategy | Partial — the strategy and required layers are documented; implementation remains in [#10](https://github.com/ubi-labs/ubi-finder/issues/10). |
| Local acceptance harness | Missing — no Playwright/Cypress or equivalent local end-to-end acceptance flow exists. |
| Coverage governance | Missing — no coverage tooling, thresholds, reports, or CI measurement exists; deeper coverage quality was not audited. |
| Lint | Pass — `npm run lint` completed successfully on 2026-09-01. |
| Typecheck | Missing — `npm run typecheck` exists but fails across dependencies and application code; repair is tracked by [#9](https://github.com/ubi-labs/ubi-finder/issues/9). |
| Build | Pass — `npm run build` is the only application check enforced by CI and the latest GitHub run for `main` succeeded. |
| CI coverage | Partial — pull requests and pushes to `main` run `npm ci` and build, but lint, typecheck, tests, coverage, and migration dry-run validation are absent. |
| Supabase edge-function access criterion | Not applicable — this is a single frontend, not an MCP or multi-frontend platform; `CONTRIBUTING.md` explicitly permits direct Supabase client access subject to RLS. |
| Supabase migration source | Partial — canonical `supabase/` migrations and seed are duplicated byte-for-byte under `src/supabase/`, creating drift risk. |
| Supabase PR migration validation | Missing — pull requests do not run a migration dry-run or local database validation. |
| Supabase dev delivery | Not applicable — the repository has no `dev` branch or documented dev Supabase environment. |
| Supabase production delivery | Pass — changes under canonical migrations/functions on `main` trigger production migration and Edge Function deployment; the latest relevant run succeeded on 2026-08-23. |
| Supabase environment contract | Partial — `.env.example` exists and runtime defaults distinguish localhost from hosted use, but dedicated local/remote env files and scripts are absent and the default remote project is hard-coded in the client. |
| Git and artifact hygiene | Partial — tracked state is clean and build output is ignored, but `supabase/.temp/cli-latest` is tracked and many ignored root patch/check scripts remain as disposable artifacts. |
| Versioning automation | Not applicable — the repository has not adopted branch-scoped session logs or a `dev`/`main` promotion model. |
