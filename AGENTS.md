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
