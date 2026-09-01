# Supabase Environments

The root `supabase/` directory is the only migration, seed, function, and local configuration source.

## Frontend modes

- `local-supabase`: uses `.env.local-supabase.local` and an allocated local Supabase runtime.
- `remote-supabase`: uses `.env.remote-supabase.local` for an explicitly selected hosted project.

Copy the corresponding tracked `.example` file, populate its public URL and anon key, and never commit the `.local` file. The application fails at startup when either variable is absent; it does not infer a hosted project or substitute a placeholder key.

## Database validation and delivery

Pull requests that change Supabase migrations, seeds, functions, configuration, or their workflow rebuild an isolated local database and run database linting. This proves replayability only.

Merges to `main` trigger the production migration/function workflow. That workflow requires the Production environment, `SUPABASE_ACCESS_TOKEN`, `SUPABASE_DB_PASSWORD`, and `SUPABASE_PROJECT_ID`; no project identifier is embedded in repository code. A successful PR validation does not prove production deployment.

Local work in the shared `codex-supabase` environment requires the local-Supabase coordinator. Use only the granted port family and command scope, stop project-owned resources, and release the lease when finished.
