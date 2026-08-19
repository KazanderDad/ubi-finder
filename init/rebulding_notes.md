# UBI Finder — Rebuild Instructions for Agent


This document instructs an agent on how to unpack the bundled dump files and reconstruct the UBI Finder project. It does **not** duplicate content already present in the dumps or the project guide; it references them.


---


## File Inventory (editable)


The table below lists every source artifact the agent has to work with. Edit the left column if you rename or relocate a file; the right column is the short reference used throughout this document.


| File | Ref | Contains / Role |
|---|---|---|
| `init/project guide.md` | **[PG]** | Functional, structural, operational, technical description of the app. Read first. |
| `init/pages dump 1_core.txt` | **[P1]** | Core user pages: `Home.jsx`, `Dashboard.jsx`, `About.jsx`. |
| `init/pages dump 2.txt` | **[P2]** | Program catalog pages: `Programs.jsx`, `program-details.jsx`, `SubmitProgram.jsx`. |
| `init/pages dump 3.txt` | **[P3]** | Program management pages: `Submit-Program.jsx`, `Manage-Program.jsx`, `My-Programs.jsx`. |
| `init/pages dump 4.txt` | **[P4]** | Profile editor + blog listing: `EditProfile.jsx`, `Profile.jsx`, `Blog.jsx`. |
| `init/pages dump 5.txt` | **[P5]** | Blog post, community, legal pages: `BlogPost.jsx`, `Community.jsx`, `Terms.jsx`, `Privacy.jsx`, `Cookie-Policy.jsx`, `Disclaimer.jsx`, `Accessibility.jsx`. |
| `init/dump A.txt` | **[A]** | App root + infra: `App.jsx`, `main.jsx`, `index.css`, `Layout.jsx`, `api/base44Client.js`, `lib/*`, `hooks/*`, and start of `components/`. |
| `init/dump B.txt` | **[B]** | Rest of `components/` (TopNavBar, Footer, UserForm, banking/, dashboard/, markdown/, ScrollToTop, ProtectedRoute, UserNotRegisteredError) + start of `components/ui/`. |
| `init/dump C.txt` | **[C]** | `components/ui/` primitives (continued). |
| `init/dump D.txt` | **[D]** | `components/ui/` primitives (final). |
| `init/dump E.txt` | **[E]** | Config + entities: `src/utils/index.ts`, all `base44/entities/*.jsonc`, `package.json`, `vite.config.js`, `tailwind.config.js`, `postcss.config.js`, `components.json`, `jsconfig.json`, `index.html`, `base44/config.jsonc`, plus rebuild notes. |
| `supabase/migrations/00001_init.sql` | **[MIG]** | SQL DDL for all tables (schema). |
| `supabase/seed.sql` | **[SEED]** | Seed `INSERT`s for `programs` (17 rows) and `blog_posts` (10 rows). |


> The dump files are plain-text concatenations. Each file section is delimited by a header block of the form `LOCATION: <dir>` / `FILE: <name>`. The agent parses these delimiters to split a dump back into individual files.


---


## Approach


### 0. Read the guide
Open **[PG]** and internalize sections 1–4. Do not proceed to unpacking until you understand the entity model (§2), routing (§2), data-access pattern (§3), and conventions (§4). You will make decisions that depend on this.


### 1. Scaffold the project shell
Create the repository skeleton exactly as **[E]** specifies: `package.json`, `vite.config.js`, `tailwind.config.js`, `postcss.config.js`, `components.json`, `jsconfig.json`, `index.html`, `base44/config.jsonc`. These are verbatim in **[E]** — copy them unchanged. Run `npm install` to materialize the dependency tree listed in `package.json`.


Do **not** hand-write `src/api/base44Client.js`, `src/lib/*`, or `src/hooks/*` from memory — take them verbatim from **[A]**. Likewise `src/utils/index.ts` comes from **[E]**.


### 2. Restore the design system
`src/index.css` (in **[A]**) defines the CSS-variable tokens; `tailwind.config.js` (in **[E]**) maps them to Tailwind classes. Restore both. The token system and the rule "components consume mapped classes, never hardcoded hex" are described in **[PG]** §4 — follow it.


### 3. Restore entity schemas
For each entity in **[E]** (`UserProfile`, `Program`, `BankAccount`, `CryptoWallet`, `BlogPost`, `Comment`, `ProgramManager`, `Application`), write the corresponding `base44/entities/<Name>.jsonc` file verbatim. The `User` entity is built-in — do **not** create it (see **[PG]** §2 and the notes at the bottom of **[E]**). These schemas are what the Base44 platform reads to generate the `@/entities/*` imports the pages use; without them the imports resolve to nothing.


### 4. Restore the database schema and seed
Apply **[MIG]** to create the tables, then apply **[SEED]** to populate `programs` and `blog_posts`. If a column type in **[MIG]** differs from the array cast assumed in **[SEED]** (e.g. JSONB vs `TEXT[]`), adjust the `ARRAY[...]::text[]` expressions in **[SEED]** to match — the header comment in **[SEED]** calls this out. Other entities (`UserProfile`, `BankAccount`, etc.) start empty; users create their own records at runtime.


### 5. Restore UI primitives
Unpack `components/ui/` from **[C]** and **[D]** (and any ui tail at the end of **[B]**). These are the shadcn/ui primitives the pages import. They must all be present before any page compiles. The alias config in `jsconfig.json` (**[E]**) and `components.json` (**[E]**) makes `@/components/ui/...` resolve.


### 6. Restore shared components
Unpack `TopNavBar`, `Footer`, `UserForm`, `ScrollToTop`, `ProtectedRoute`, `UserNotRegisteredError`, the `banking/` forms, the `dashboard/` sub-components, and `markdown/MarkdownContent` from **[A]** and **[B]**. Their roles are listed in **[PG]** §2 (Directory Layout). Each is a default export named after its file.


### 7. Restore pages
Unpack the pages in this order, each from its dump:
- **[P1]** → `Home.jsx`, `Dashboard.jsx`, `About.jsx`
- **[P2]** → `Programs.jsx`, `program-details.jsx`, `SubmitProgram.jsx`
- **[P3]** → `Submit-Program.jsx`, `Manage-Program.jsx`, `My-Programs.jsx`
- **[P4]** → `EditProfile.jsx`, `Profile.jsx`, `Blog.jsx`
- **[P5]** → `BlogPost.jsx`, `Community.jsx`, `Terms.jsx`, `Privacy.jsx`, `Cookie-Policy.jsx`, `Disclaimer.jsx`, `Accessibility.jsx`


Place each at the path stated in its `LOCATION:`/`FILE:` header. Do not rename — `App.jsx` imports them by these exact names (see **[A]**).


### 8. Restore the router
`src/App.jsx` (from **[A]**) already contains every `<Route>` and import. After unpacking all pages, verify each import in `App.jsx` resolves to a file you restored in step 7. The routing model (explicit routes, auth gate via `AuthProvider`/`useAuth`, home at `/`) is described in **[PG]** §2 — do not restructure it.


### 9. Wire environment
The app cannot run from source alone; it needs a Base44 app backing it. Set the env vars noted at the bottom of **[E]** (`VITE_BASE44_APP_ID`, `VITE_BASE44_APP_BASE_URL`, `VITE_BASE44_FUNCTIONS_VERSION`) from the Base44 dashboard. Auth, hosting, and the entity runtime are platform-managed (**[PG]** §3). The `@/entities/*` and `@/integrations/Core` imports are platform-provided from the schemas in step 3 — they are not files you write.


### 10. Verify
- `npm run build` should succeed with no unresolved imports.
- Every route in `App.jsx` should render its page.
- The seed data from **[SEED]** should appear on `/Programs` and `/Blog`.
- Profile creation, program matching, and the legal pages should behave per **[PG]** §1 and §3.


---


## Rules for the agent
- **Copy verbatim.** Dump contents are the source of truth; do not "improve" them. If a file looks stale, flag it rather than silently rewriting.
- **Respect the `LOCATION:`/`FILE:` delimiters** when splitting a dump — they are the only reliable boundary between files.
- **Do not create `User.jsonc`** or any auth backend logic (**[PG]** §3, **[E]** notes).
- **Keep file names exact**, including hyphenated ones (`Submit-Program.jsx`, `Cookie-Policy.jsx`); `App.jsx` imports them by these identifiers.
- **Refer to [PG]** for any "why" question (matching logic, roles, conventions) before improvising.
- If a dump and **[PG]** disagree on structure, prefer the dump (it is the actual code) and note the discrepancy.

