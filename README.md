# UBI Finder 🌍🌱

> Discover, verify, and apply for Universal Basic Income (UBI), guaranteed income pilots, and community cash distributions worldwide.

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Vite](https://img.shields.io/badge/Vite-6.x-646CFF.svg?logo=vite&logoColor=white)](https://vitejs.org/)
[![React](https://img.shields.io/badge/React-18.x-61DAFB.svg?logo=react&logoColor=black)](https://reactjs.org/)
[![TailwindCSS](https://img.shields.io/badge/TailwindCSS-3.x-38B2AC.svg?logo=tailwind-css&logoColor=white)](https://tailwindcss.com/)
[![Supabase](https://img.shields.io/badge/Supabase-Auth%20%26%20Postgres-3ECF8E.svg?logo=supabase&logoColor=white)](https://supabase.com/)

---

## 📖 Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Architecture & Tech Stack](#architecture--tech-stack)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Environment Configuration](#environment-configuration)
  - [Supabase Setup & Migrations](#supabase-setup--migrations)
  - [Running the App](#running-the-app)
- [Project Structure](#project-structure)
- [Available Scripts](#available-scripts)
- [Repository & Roadmap](#repository--roadmap)
- [Target User Groups](#target-user-groups)
- [Contributing](#contributing)
- [License](#license)

---

## 🌟 Overview

**UBI Finder** bridges the gap between individuals seeking financial support and organizations launching Universal Basic Income or guaranteed cash experiments.

Traditional welfare programs are often burdened with bureaucratic friction, stigmatizing means-tests, and complex qualifications. UBI Finder aggregates verified fiat and crypto-powered income programs into a single searchable directory with instant eligibility matching, personalized dashboards, community discussion hubs, and builder services.

---

## 🚀 Key Features

### For Seekers (Recipients)
* 🔍 **Multi-Step Eligibility Matching:** Answer basic location, household size, and income questions to receive matching program reports.
* ⚡ **Live Program Previews:** Real-time program count hints based on your selected region.
* 📬 **Passwordless Magic Link Onboarding:** Frictionless email verification that saves and matches profile preferences automatically.
* 📊 **Personalized Dashboard:** Track saved programs, calculate Match Score percentages (e.g. `95% Match`), track application status, and view targeted news updates.
* 💬 **Community Discussion Hub:** Ask questions, share application advice, and tag conversations to specific basic income pilots.
* 📱 **Mobile-Optimized Program Details:** Clean breakdown of disbursement schedules, currency conversions, verified sources, and floating 1-click apply triggers.

### For Program Managers & Builders
* 🏢 **B2B Infrastructure Services:** Full technical consulting & deployment rails by [Firebelly.xyz](https://firebelly.xyz) for credit unions, blockchain DAOs, and municipalities.
* ✍️ **Program Submission & Management:** Self-serve program listing workflows with administrative review pipelines.
* 🛡️ **Verified Pilot Directory:** Sybil-resistant, KYC/OFAC-compliant architecture with transparent on-chain and fiat payout options.

---

## 🛠️ Architecture & Tech Stack

| Layer | Technologies |
|---|---|
| **Frontend** | React 18, Vite 6, React Router DOM 6, React Helmet Async (SEO) |
| **Styling & UI** | TailwindCSS, Radix UI Primitives, Lucide Icons, Shadcn UI Components |
| **Backend & DB** | Supabase (PostgreSQL), Supabase Auth (Passwordless OTP / Magic Links), Row Level Security (RLS) |
| **State & Cache** | React Context API (`AuthContext`), LocalStorage state persistence |

---

## 🏁 Getting Started

### Prerequisites
* **Node.js**: `v18.x` or higher (Node 20+ recommended)
* **npm** or **pnpm** / **yarn**
* **Docker** (optional, if running local Supabase CLI)

### Installation

```bash
# Clone the repository
git clone https://github.com/ubi-labs/ubi-finder.git
cd ubi-finder

# Install dependencies
npm install
```

### Environment Configuration

Create a `.env` file in the root directory:

```bash
cp .env.example .env
```

Set your Supabase project credentials:

```env
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-publishable-anon-key
```

### Supabase Setup & Migrations

If using local Supabase CLI:

```bash
# Start local Supabase instance
npx supabase start

# Apply migrations
npx supabase db push

# (Optional) Seed initial database records
npx supabase db reset
```

All SQL schema migrations are located in [`supabase/migrations/`](./supabase/migrations/).

### Running the App

```bash
# Start Vite development server
npm run dev

# Build for production
npm run build

# Preview production build locally
npm run preview
```

---

## 📁 Project Structure

```
ubi-finder/
├── .github/
│   └── workflows/          # GitHub Actions CI pipelines
├── public/                 # Static assets, robots.txt, sitemap.xml
├── src/
│   ├── components/
│   │   ├── dashboard/      # Dashboard cards, matching program lists, application tracker
│   │   ├── ui/             # Radix & Tailwind UI primitives (buttons, modals, cards, tabs)
│   │   ├── Header.jsx      # Sticky navbar with authenticated user dropdown
│   │   ├── Footer.jsx      # Global footer with ecosystem & legal links
│   │   └── UserForm.jsx    # Multi-step eligibility intake form
│   ├── lib/
│   │   ├── AuthContext.jsx # Native Supabase auth session provider
│   │   ├── supabaseClient.js # Initialized Supabase client
│   │   └── utils.js        # Class merger and formatting utilities
│   ├── pages/
│   │   ├── Home.jsx        # Landing page with hero, live featured strip & eligibility CTA
│   │   ├── Programs.jsx    # Filterable program directory with skeleton loaders
│   │   ├── program-details.jsx # Comprehensive program view with checklist & apply actions
│   │   ├── Dashboard.jsx   # Logged-in user hub with onboarding checklist
│   │   ├── Community.jsx   # Discussion forum & announcement boards
│   │   ├── Services.jsx    # Consultancy & technical infrastructure offerings
│   │   ├── Blog.jsx        # Educational insights & program news
│   │   └── Ecosystem.jsx   # External directory of basic income protocols
│   ├── App.jsx             # React router configuration & layout wrapping
│   └── main.jsx            # Entrypoint with HelmetProvider
├── supabase/
│   ├── migrations/         # PostgreSQL schema migrations
│   └── seed.sql            # Initial test and program dataset
├── .env.example            # Environment variable template
├── package.json
└── vite.config.js
```

---

## 📜 Available Scripts

- `npm run dev` — Launches the development server with Hot Module Replacement (HMR).
- `npm run build` — Compiles production-ready bundle to `/dist`.
- `npm run preview` — Locally tests the built production files.
- `npm run lint` — Runs ESLint checks.

---

## 🗺️ Repository & Roadmap

- **Canonical repository:** [ubi-labs/ubi-finder](https://github.com/ubi-labs/ubi-finder)
- **Issues:** [ubi-labs/ubi-finder/issues](https://github.com/ubi-labs/ubi-finder/issues)
- **Active roadmap:** [UBI Finder Project](https://github.com/orgs/ubi-labs/projects/1)

Use `ubi-labs/ubi-finder` for clones, links, automation, and new issue references.

---

## 👥 Target User Groups

1. **Regular Seekers:**
   Individuals seeking financial support who want to discover active cash grants or crypto basic income pilots in their region.
2. **UBI Program Managers & Protocol Builders:**
   Municipalities, non-profits, credit unions, and Web3 foundations looking to list their programs, reach verified applicants, or contract technical deployment services.

---

## 🤝 Contributing

Contributions, bug reports, and program submissions are welcome! Please review [CONTRIBUTING.md](./CONTRIBUTING.md) for details on submitting pull requests.

---

## 📄 License

This project is licensed under the [MIT License](./LICENSE).
