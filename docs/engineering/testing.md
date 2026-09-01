# Testing Strategy

UBI Finder uses layered validation:

1. ESLint catches invalid or unsafe JavaScript patterns.
2. TypeScript checks JavaScript and JSX without emitting files.
3. Vitest exercises deterministic domain behavior and enforces coverage on governed core modules.
4. Vite produces the deployable frontend bundle.
5. Playwright exercises public and authenticated browser flows against an allocated local Supabase runtime.
6. Supabase validation rebuilds the database from canonical migrations and seed data, then runs database linting.

The required pull-request application checks are `npm run lint`, `npm run typecheck`, `npm run test:coverage`, and `npm run build`. Route, authentication, eligibility, catalog, report, or database-facing changes also require `npm run test:acceptance:local`.

Coverage is a ratchet, not a proxy for correctness. Statements, branches, functions, and lines must each remain at or above 80% for the configured core modules. Add new deterministic domain modules to the governed set when they become part of matching, eligibility, status classification, or persisted match behavior.

The local acceptance command never starts or resets shared Supabase infrastructure. Acquire a coordinator lease, provide the runtime environment, run the harness, and release the lease. CI may start and stop its own isolated runtime.
