# UBI Finder

UBI Finder helps people discover and evaluate Universal Basic Income, guaranteed-income, and community cash-support programs. It also provides program submission, management, community, and builder-service workflows.

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## Architecture

The repository contains one React 18/Vite 6 frontend backed by Supabase Auth, PostgreSQL, Storage, Row Level Security, and an Edge Function. The browser performs authorized Supabase reads and writes directly; database policies remain the security boundary.

See [engineering documentation](docs/engineering/README.md) for current architecture, testing, and environment contracts. Future ideas are clearly separated under `docs/engineering/target-state/` and are not the active roadmap.

## Prerequisites

- Node.js 22
- npm
- Docker and Supabase CLI 2.116.0 when validating the local database
- A local-Supabase coordinator lease when using the shared local runtime

## Install

```bash
git clone https://github.com/ubi-labs/ubi-finder.git
cd ubi-finder
npm ci
```

## Configure Supabase

Local development:

```bash
cp .env.local-supabase.example .env.local-supabase.local
npm run dev:local
```

Hosted development:

```bash
cp .env.remote-supabase.example .env.remote-supabase.local
npm run dev:remote
```

Populate both `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY`. The application does not infer a hosted project or use placeholder credentials. Never commit the `.local` files.

The local acceptance harness expects an already allocated local Supabase runtime and its public and service-role credentials. It does not start or reset shared infrastructure.

## Commands

| Command | Purpose |
|---|---|
| `npm run dev:local` | Start Vite in explicit local-Supabase mode. |
| `npm run dev:remote` | Start Vite in explicit hosted-Supabase mode. |
| `npm run lint` | Check JavaScript and JSX with ESLint. |
| `npm run typecheck` | Check JavaScript and JSX types without emitting files. |
| `npm run test:unit` | Run deterministic unit tests. |
| `npm run test:coverage` | Run governed core coverage with 80% thresholds. |
| `npm run test:acceptance:local` | Run Chromium acceptance against allocated local Supabase. |
| `npm run build` | Build the production bundle. |
| `npm run preview` | Preview the built frontend. |

For database changes, also run a clean `supabase db reset` and `supabase db lint --local --level error` in the allocated environment.

## Repository structure

```text
src/                           React application, routes, UI, and domain logic
supabase/                      Canonical config, migrations, seed, and Edge Functions
tests/unit/                    Deterministic unit coverage
tests/acceptance/              Playwright browser acceptance and fixtures
docs/engineering/              Implemented technical documentation
docs/engineering/target-state/ Unimplemented reference designs
agent-context/session-log/     Branch-scoped delivery evidence
.github/workflows/             Application, migration, and deployment CI
```

## Roadmap and contributions

- [Canonical repository](https://github.com/ubi-labs/ubi-finder)
- [Issue queue](https://github.com/ubi-labs/ubi-finder/issues)
- [UBI Finder Project](https://github.com/orgs/ubi-labs/projects/1)

GitHub Issues and the Project are the only active roadmap. See [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

## License

Licensed under the [MIT License](LICENSE).
