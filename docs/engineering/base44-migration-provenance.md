# Base44 Migration Provenance

UBI Finder was reconstructed from Base44 exports before being migrated to the current React/Vite and Supabase implementation. The initial repository retained raw page/component dumps under `init/` and legacy Base44 entity/configuration files under `base44/` as reconstruction inputs.

Those files are not runtime dependencies: the current package has no Base44 SDK or Vite plugin, application data access uses `src/lib/supabaseClient.js`, and the implemented schema lives in root `supabase/`. The raw inputs were removed during repository cleanup because they duplicated or contradicted the implemented system. Git history remains the authoritative source if forensic access to the original exports is ever required.
