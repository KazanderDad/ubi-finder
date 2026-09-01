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
| Testing strategy | Pass — lint, repository-wide JavaScript checking, deterministic unit coverage, build, local browser acceptance, and database replay/lint responsibilities are documented and scripted. |
| Local acceptance harness | Implemented — three Chromium scenarios cover public discovery, eligibility persistence, authentication, dashboard, and report behavior against local-only fixtures; exact runtime execution remains coordinator-gated. |
| Coverage governance | Pass — 40 deterministic tests cover the selected core modules and enforce 80% statements, branches, functions, and lines; the latest branch run exceeds every threshold. |
| Lint | Pass — `npm run lint` completed successfully on 2026-09-01. |
| Typecheck | Pass — [#9](https://github.com/ubi-labs/ubi-finder/issues/9) established repository-wide `checkJs` coverage with zero diagnostics and no suppression directives or broad source exclusions. |
| Build | Pass locally — the explicit-environment production build succeeds; CI requires install, lint, typecheck, governed coverage, and build. |
| CI coverage | Implemented — pull requests require lint, typecheck, governed coverage, build, and path-scoped Supabase reset/seed/lint validation. Branch CI evidence is pending publication. |
| Supabase edge-function access criterion | Not applicable — this is a single frontend, not an MCP or multi-frontend platform; `CONTRIBUTING.md` explicitly permits direct Supabase client access subject to RLS. |
| Supabase migration source | Pass — root `supabase/` is the sole migration, seed, function, and configuration source. |
| Supabase PR migration validation | Implemented — affected pull requests use CLI 2.116.0 to start an isolated runtime, replay migrations and the canonical seed, and run database linting. |
| Supabase dev delivery | Not applicable — the repository has no `dev` branch or documented dev Supabase environment. |
| Supabase production delivery | Implemented, not deployment proof — main changes use CLI 2.116.0 and require Production-scoped token, password, and project ID with no repository fallback. |
| Supabase environment contract | Pass — local and remote Vite modes require explicit URL/key files; the browser client fails clearly rather than inferring a project or substituting credentials. |
| Git and artifact hygiene | Pass on branch — raw reconstruction material, unused runtime duplicates, redundant seed, and tracked CLI state are removed; precise ignore rules preserve legitimate Python/CJS/MJS tooling; recoverable scratch cleanup is manifested. |
| Versioning automation | Not applicable — releases are not versioned independently; branch-scoped session logs and PR integration evidence are in place. |
