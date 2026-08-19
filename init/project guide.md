# UBI Finder — Project Guide


> Discover personalized income support programs tailored to your unique circumstances. UBI Finder connects you with verified financial assistance initiatives across different regions.


This document describes the UBI Finder application across four dimensions: **functional**, **structural**, **operational**, and **technical**.


---


## 1. Functional Description


### Purpose
UBI Finder helps individuals discover income-support (UBI / guaranteed-income / cash-assistance) programs that match their personal circumstances. Users build a profile, receive tailored program recommendations, track applications, and stay informed through a news feed of relevant blog posts.


### Core Capabilities


| Capability | Description |
|---|---|
| **Profile Management** | Users create a profile capturing gender, country, state, household size, income range, currency preferences, and minimum desired monthly payment. Profiles drive program matching. |
| **Program Discovery** | The Dashboard surfaces programs that match the user's profile (gender, region, income, payment method) plus any programs the user has favorited. |
| **Program Catalog** | A public `Programs` page lists all programs with filtering by region, payment method, status, and currency. |
| **Program Submission** | External contributors can submit new programs via `SubmitProgram` / `Submit-Program`; program owners can manage them via `Manage-Program` and view their portfolio in `My-Programs`. |
| **Application Tracking** | Users can apply to programs and track application status (`pending`, `approved`, `rejected`) from the Dashboard. |
| **Favorites & Ownership** | The `ProgramManager` entity records per-user ownership/admin roles and favorites per program. |
| **Financial Accounts** | Users can store bank accounts and crypto wallets linked to their profile for payment routing. |
| **News & Updates** | A `Blog` / `BlogPost` system with comments delivers news relevant to each user's eligible programs. |
| **Community** | A `Community` page provides a hub for discussion (forum features are planned). |
| **Static Legal Pages** | Terms, Privacy, Cookie Policy, Disclaimer, and Accessibility pages are rendered from markdown via a shared `MarkdownContent` component. |


### User Roles
- **App user** — creates a profile, receives recommendations, applies to programs, favorites programs, manages financial accounts.
- **Program owner/admin** — granted via `ProgramManager` records; can manage specific programs and view them in `My-Programs`.
- **Admin** — built-in Base44 role; can invite users and manage other users.


### Eligibility Matching Logic
Matching on the Dashboard considers:
- **Gender requirement** — program's `gender_requirement` vs. user's gender (or "abstain" to skip gender-specific programs).
- **Region** — program's `available_regions` / `required_states` vs. user's country and state.
- **Income** — program's `max_household_income_usd` vs. user's `income_range`.
- **Payment method** — program's `payment_method` (standard/digital) vs. user's `accepts_digital_currency` / `accepts_foreign_currency`.
- **Currency** — program currency vs. user's preferred currency, auto-mapped from the user's country selection.


---


## 2. Structural Description


### High-Level Architecture
```
Browser  →  React SPA (Vite)  →  Base44 BaaS (Auth + DB + Integrations + Hosting)
```
- **Frontend**: React 18 + Tailwind CSS + shadcn/ui, bundled by Vite.
- **Backend**: Base44 platform — managed auth, entity storage (NoSQL-like documents), server-side integrations (LLM, email, file upload, image/video/speech generation), and hosting.
- **No custom server code**: all data access goes through the pre-initialized Base44 SDK client (`@/api/base44Client`).


### Directory Layout
```
src/
├── App.jsx                      # Router + auth gate + providers
├── main.jsx                     # React entry point
├── index.css                    # Design tokens (CSS variables) + Tailwind layers
├── Layout.jsx                   # Top nav + page wrapper (legacy wrapper)
├── api/
│   └── base44Client.js          # Pre-initialized Base44 SDK client
├── lib/
│   ├── AuthContext.jsx          # Auth state + error handling
│   ├── query-client.js          # TanStack React Query client
│   ├── utils.js                 # cn() and helpers
│   ├── app-params.js
│   └── PageNotFound.jsx
├── hooks/
│   ├── use-mobile.jsx
│   └── use-size.jsx
├── components/
│   ├── TopNavBar.jsx            # Global navigation
│   ├── Footer.jsx               # Shared footer (links to legal pages)
│   ├── ScrollToTop.jsx          # Scroll restoration on route change
│   ├── ProtectedRoute.jsx       # Auth-gated route wrapper
│   ├── UserNotRegisteredError.jsx
│   ├── UserForm.jsx             # Profile creation/editing form
│   ├── markdown/
│   │   └── MarkdownContent.jsx  # Renders markdown for static pages & blog
│   ├── dashboard/
│   │   ├── DashboardProfile.jsx
│   │   ├── ApplicationsList.jsx
│   │   ├── ProgramFilters.jsx
│   │   ├── ProgramList.jsx
│   │   └── MatchingPrograms.jsx
│   ├── banking/
│   │   ├── BankAccountForm.jsx
│   │   └── CryptoWalletForm.jsx
│   └── ui/                      # shadcn/ui primitives (button, card, dialog, …)
├── pages/
│   ├── Home.jsx                 # Landing + eligibility assessment
│   ├── Dashboard.jsx            # 3-column personalized hub
│   ├── Profile.jsx              # Read-only profile + accounts view
│   ├── EditProfile.jsx          # Full profile + accounts editor
│   ├── About.jsx
│   ├── Programs.jsx             # Public program catalog
│   ├── Blog.jsx                 # Blog listing
│   ├── BlogPost.jsx             # Single post + comments
│   ├── SubmitProgram.jsx        # Program submission (alt)
│   ├── Submit-Program.jsx       # Program submission
│   ├── Manage-Program.jsx       # Owner program management
│   ├── My-Programs.jsx          # Owner portfolio
│   ├── program-details.jsx      # Single program view
│   ├── Community.jsx            # Community hub
│   ├── Terms.jsx / Privacy.jsx / Cookie-Policy.jsx / Disclaimer.jsx / Accessibility.jsx
└── utils/
   └── index.ts


base44/
├── config.jsonc                 # App name + build/serve config
├── entities/                    # JSON-schema entity definitions (see below)
└── agents/                      # (reserved for in-app AI agents)
```


### Entity Model (Data Structures)
All entities are JSON Schema documents under `base44/entities/`. Every record includes built-ins: `id`, `created_date`, `updated_date`, `created_by_id`.


| Entity | Purpose | Key Fields |
|---|---|---|
| **UserProfile** | User's circumstances for matching | name, gender (female/male/abstain), country, state, currency, accepts_digital_currency, accepts_foreign_currency, household_size, income_range, min_monthly_payment, profile_picture, dismissed_program_info |
| **Program** | A support program | program_id, name, organization, description, gender_requirement, monthly_amount_usd, currency, available_regions, required_states, payment_method, amount_description, max_household_income_usd, eligibility, status, website, verified, submitter_email |
| **ProgramManager** | Per-user access/favorites to a program | program_id, user_email, user_profile_id, role (owner/admin), is_favorite, added_date |
| **Application** | A user's application to a program | program_id, user_email, user_profile_id, status, submitted_date |
| **BankAccount** | User's bank account | user_profile_id, bank_name, account_number, routing_number, iban, swift_code, country, account_holder_name, is_primary |
| **CryptoWallet** | User's crypto wallet | user_profile_id, blockchain, other_blockchain, public_key, wallet_name, is_primary |
| **BlogPost** | News/updates content | title, content (markdown), summary, author, posted_date, image_url, related_programs, tags |
| **Comment** | Comments on blog posts | blog_post_id, content, author_name, author_email |
| **User** | Built-in auth user (read-only) | id, email, full_name, role, created_date |


### Routing
Routes are defined explicitly in `src/App.jsx` inside `<Routes>`. Each page has one `<Route>`. Auth gating is handled by `AuthProvider` / `useAuth` and `ProtectedRoute`. The home page is served at `/`.


---


## 3. Operational Description


### How a User Flows Through the App
1. **Landing** (`/`) — visitor sees the hero, feature highlights, and an eligibility-assessment form.
2. **Onboarding** — submitting the eligibility form either prompts login (for guests) or creates a `UserProfile` and navigates to the Dashboard.
3. **Dashboard** (`/Dashboard`) — three-column hub:
  - **Left**: profile summary + applications tracker.
  - **Middle**: matching programs (profile-matched + favorites) with an "Edit Profile" shortcut.
  - **Right**: news & updates feed (blog posts relevant to the user's eligible programs).
  - Responsive: 1 column (small), 2 columns (medium), 3 columns (large).
4. **Profile editing** (`/EditProfile`) — update personal info, currency/payment preferences, and manage bank accounts and crypto wallets (modals for add/edit).
5. **Program catalog** (`/Programs`) — browse all programs; click through to `/program-details`.
6. **Apply / Favorite** — from program details or the Dashboard, users apply or favorite; favorites persist via `ProgramManager`.
7. **Program owners** — submit programs (`/Submit-Program`), manage them (`/Manage-Program`), and view their portfolio (`/My-Programs`).
8. **News** — `/Blog` lists posts; `/BlogPost` shows a post with comments.


### Authentication & Access
- Auth is fully managed by the Base44 platform (tokens, sessions, email verification). The app never implements auth backend logic.
- `AuthContext` exposes `isLoadingAuth`, `isLoadingPublicSettings`, `authError`, and `navigateToLogin`.
- Unauthenticated users are redirected to the platform login page; unregistered users see `UserNotRegisteredError`.
- Users join via admin invite (`base44.users.inviteUser(email, role)`); `User` records cannot be created directly.


### Data Access Pattern
All entity operations use the Base44 SDK on the pre-initialized client:
```js
import { base44 } from '@/api/base44Client';
base44.entities.Program.list();
base44.entities.UserProfile.filter({ created_by: userEmail });
base44.entities.Application.create({ ... });
```
- Reads run as the app user; RLS (Row-Level Security) can be configured per entity under an `rls` key in the entity schema.
- Realtime updates are available via `base44.entities.<Name>.subscribe(callback)`.


### Integrations Used
The app uses the built-in `Core` integration package:
- **InvokeLLM** — for AI-assisted features (e.g., content generation, enrichment).
- **UploadFile** / **UploadPrivateFile** — for profile pictures and document uploads.
- **GenerateImage** — for AI-generated imagery.
- **SendEmail** — for notifications to registered app users.
- **ExtractDataFromUploadedFile** — for ingesting program data from uploaded files.


### Deployment
- Frontend builds with `npm run build` (Vite) into `./dist`.
- The app is published to the Base44-hosted environment via the dashboard; the same codebase can ship to iOS/Android.
- Local development: `npm run dev` (frontend only) or `base44 dev` (full stack).


---


## 4. Technical Description


### Technology Stack
| Layer | Technology |
|---|---|
| UI Framework | React 18 |
| Build Tool | Vite 6 |
| Styling | Tailwind CSS 3 + CSS-variable design tokens |
| Component Library | shadcn/ui (Radix primitives) |
| Icons | lucide-react |
| Routing | react-router-dom 6 |
| Data Fetching / Cache | @tanstack/react-query 5 |
| Forms | react-hook-form + zod |
| Markdown | react-markdown |
| Rich Text | react-quill-new |
| Charts | recharts |
| Maps | react-leaflet |
| 3D | three.js |
| Drag & Drop | @hello-pangea/dnd |
| Animations | framer-motion |
| Backend / Auth / DB | Base44 BaaS (`@base44/sdk`) |
| Payments (available) | @stripe/react-stripe-js |


### Design Token System
- `src/index.css` defines CSS variables for `:root` (light) and `.dark` (dark) — colors, radii, fonts.
- `tailwind.config.js` maps those tokens to Tailwind classes (`bg-primary`, `font-heading`, etc.).
- Theme changes are made in `src/index.css`; components consume mapped classes, never hardcoded hex values.


### Code Conventions
- Pages and components are exported as default, named after their file.
- Small, focused files (≤ ~50 lines where possible); each new component gets its own file.
- Imports use the `@` alias (`@/components/…`, `@/lib/…`).
- shadcn/ui primitives are imported from their own files under `@/components/ui/`.
- Tailwind classes are written as literal strings (the build purges dynamic class names).
- Errors bubble up unless a user-facing form/auth flow needs inline error display.


### Key Architectural Decisions
1. **Base44 entities for all persisted data** — no custom database; CRUD via the SDK.
2. **Role-based program access via `ProgramManager`** — a join entity linking users to programs with `owner`/`admin` roles and a `is_favorite` flag.
3. **Currency auto-mapping** — the user's country selection drives their default currency; programs are filtered/matched accordingly.
4. **Program matching requires currency, payment method, and region** — ensuring accurate eligibility filtering.
5. **Static legal pages via markdown** — a shared `MarkdownContent` component renders Terms, Privacy, Cookie Policy, Disclaimer, and Accessibility; a shared `Footer` links to them.
6. **Standardized gender options** — `female`, `male`, `abstain` (abstain skips gender-specific programs in matching).
7. **Responsive Dashboard** — 1 / 2 / 3 column layouts at small / medium / large breakpoints.


### Configuration Files
| File | Role |
|---|---|
| `vite.config.js` | Vite + `@base44/vite-plugin` (SDK, HMR, analytics, visual editing) |
| `tailwind.config.js` | Tailwind theme mapping + animations |
| `postcss.config.js` | Tailwind + Autoprefixer |
| `components.json` | shadcn/ui config (aliases, styles) |
| `jsconfig.json` | IDE IntelliSense + `@` path alias |
| `eslint.config.js` | Linting rules (React, hooks, unused imports) |
| `base44/config.jsonc` | App name (`UBI Finder`) + build/serve commands |
| `index.html` | Document head, meta tags, root mount, entry script |


### Known Limitations / Future Work
- Community discussion / forum features are planned but not yet implemented.
- Application tracking UI is present; full submission workflows may be extended.
- Backend functions and in-app AI agents are available when needed (require Builder+).

