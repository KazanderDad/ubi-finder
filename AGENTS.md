# UBI Finder Agent Guide

## Canonical GitHub Surfaces

- Repository: [ubi-labs/ubi-finder](https://github.com/ubi-labs/ubi-finder)
- Active roadmap: [UBI Finder Project](https://github.com/orgs/ubi-labs/projects/1)
- Issue queue: [ubi-labs/ubi-finder/issues](https://github.com/ubi-labs/ubi-finder/issues)

Treat `ubi-labs/ubi-finder` as canonical in remotes, documentation, issue links, automation, and handoffs. Do not add references to pre-transfer repository locations.

At startup, inspect the current branch and worktree status, then review the repository issue queue and UBI Finder Project. GitHub Issues and the Project are the source of truth for active work. Existing local backlog or todo documents are historical/reference material unless the user explicitly asks to migrate or activate an item.

Parent issues are typically type `Sprint` or `Feature`, with one or more type `Goal` sub-issues. Scope Sprint and Feature issues with the `sprint-interview` skill, and prepare Goal issues with the goal skill when available. Smaller implementation work belongs in the relevant Goal or Task issue.

## Branch And Session Workflow

- `main` is the integration and release branch. Use a feature branch and pull request for shared changes.
- Preserve unrelated dirty and untracked work. Do not rewrite or discard user changes.
- Update the current branch file under `agent-context/session-log/` after each completed task and before every commit.
- Squash merging is disabled. Preserve commit history through an allowed merge or rebase workflow.

Project work moves through `Inbox`, `Scoped`, `Ready`, `In Progress`, `In Review`, `On dev`, and `On main`. This repository currently has no `dev` branch, so `On dev` is used only when a future development environment is explicitly introduced. Move executable Goal or Task issues to `In Progress` when claimed and `In Review` only after the documented local validation succeeds. Move them to `On main` after the pull request is merged and the relevant main-branch checks pass.

## Development Contract

- npm is the only supported package manager; use `npm ci` for reproducible installs.
- Every implementation must add the requisite automated tests and/or update existing tests to cover the changed behavior and its regression risk. Do not treat an implementation as complete while its affected test contract is stale. If automated coverage is genuinely impractical, document the reason and the specific alternative validation in the session log and pull request.
- Before committing application changes, run `npm run lint`, `npm run typecheck`, `npm run test:coverage`, and `npm run build`.
- Run `npm run test:acceptance:local` for changes that affect routes, authentication, eligibility, program discovery, or Supabase-backed user flows.
- Migration changes must also pass a clean local reset and `supabase db lint --local --level error`.
- Do not weaken validation with `@ts-nocheck`, disabled JavaScript checking, broad source exclusions, skipped tests, or reduced coverage thresholds without an issue and explicit approval.

## Repository Map

- `src/`: React application code.
- `supabase/`: canonical Supabase configuration, migrations, seeds, and Edge Functions.
- `docs/engineering/`: current-state technical documentation.
- `docs/engineering/target-state/`: explicitly future-facing architecture and design.
- `agent-context/`: durable agent guidance, repository status, session logs, and deferred reference material.
- `.github/workflows/`: CI and deployment automation.

## Supabase Boundary

UBI Finder is currently a single frontend rather than an MCP or multi-frontend platform, so the cleanup rule requiring all database access through Edge Functions does not apply. Direct Supabase client access is allowed when Row Level Security and authorization boundaries protect it.

Use the shared local-Supabase coordinator before starting, resetting, or otherwise operating the local Supabase stack. Stop project-only resources and release the coordinator lease at the end of the turn unless the user explicitly asks to keep them running. Hosted migrations, function deployments, credentials, and production changes retain their separate approval boundaries.

The root `supabase/` directory is the only canonical source for configuration, migrations, seeds, and Edge Functions. Use the explicit `local-supabase` or `remote-supabase` frontend environment mode; never add a hard-coded hosted project fallback. Do not treat a successful local reset, CI run, or build as proof that hosted migrations or functions were deployed.

## Documentation And History

- Put implemented, current-state technical documentation in `docs/engineering/`.
- Put proposals and unimplemented designs in `docs/engineering/target-state/` and label them as non-roadmap reference material.
- Keep GitHub Issues and the Project as the active roadmap; do not create new repository-local todo lists.
- Preserve useful historical decisions in the current branch session log. Each entry must record timestamp, agent, branch, pre-commit head, linked issue, summary, validation, and follow-ups.
