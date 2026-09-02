# Current Architecture

UBI Finder is a single React 18 application built with Vite 6. React Router owns client-side navigation, React Context owns authentication state, and TanStack Query provides request caching. Tailwind and Radix-based primitives provide the UI layer.

The browser uses the Supabase JavaScript client for authentication and Row Level Security-protected access to PostgreSQL and Storage. This single-frontend design intentionally permits direct client access; sensitive authorization remains enforced in database policies. The `notify-new-submission` Edge Function handles the server-side notification integration for submitted programs.

The root `supabase/` directory is canonical for local configuration, ordered migrations, seed data, and Edge Functions. `src/lib/supabaseClient.js` is the frontend client boundary. Environment selection is explicit: local development points to an allocated local Supabase runtime, while remote development and builds require configured hosted credentials.

Public routes include the home page, program directory and details, informational pages, claims, services, and ecosystem content. Authentication gates dashboards, profiles, reports, program management, submission, and administrative review routes.

GitHub Actions validates application quality on pull requests. Main-branch changes to canonical migrations or functions use the production deployment workflow, whose environment approval and secrets are separate from local or PR validation.
