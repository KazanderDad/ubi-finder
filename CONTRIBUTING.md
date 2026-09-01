# Contributing to UBI Finder 🌱

Thank you for your interest in contributing to UBI Finder! Together, we can make universal basic income opportunities transparent, verifiable, and accessible to everyone.

Use the [canonical repository](https://github.com/ubi-labs/ubi-finder), its [issue queue](https://github.com/ubi-labs/ubi-finder/issues), and the [UBI Finder Project](https://github.com/orgs/ubi-labs/projects/1) for active work.

---

## 🛠️ Development Workflow

1. **Fork and Clone:**
   ```bash
   git clone https://github.com/ubi-labs/ubi-finder.git
   cd ubi-finder
   ```

2. **Create a Feature Branch:**
   ```bash
   git checkout -b feat/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

3. **Install Dependencies:**
   ```bash
   npm ci
   ```

4. **Configure Environment:**
   Copy `.env.local-supabase.example` to `.env.local-supabase.local`, or copy `.env.remote-supabase.example` to `.env.remote-supabase.local`, and populate both public Supabase variables.

5. **Start Dev Server:**
   ```bash
   npm run dev:local
   ```

6. **Run Required Checks:**
   Before pushing, run the same application contract enforced by CI:
   ```bash
   npm run lint
   npm run typecheck
   npm run test:coverage
   npm run build
   ```

   Run `npm run test:acceptance:local` for route, authentication, eligibility, program discovery, report, or Supabase-backed flow changes. Acquire a local-Supabase coordinator lease before using the shared runtime.

7. **Commit & Push:**
   Use clear and conventional commit messages (e.g. `feat: add filter for regional grants`, `fix: handle null gender requirement in matching engine`).

8. **Submit a Pull Request:**
   Open a pull request against [`ubi-labs/ubi-finder`](https://github.com/ubi-labs/ubi-finder/pulls) describing the change, motivation, linked issue, and verification steps performed.

---

## 📋 Coding Standards

* **Components:** Keep UI components modular, reusable, and accessible using Tailwind CSS and Radix primitives.
* **Database & Auth:** Use native Supabase client queries (`supabase.from(...)`) and native authentication. Never query sensitive user tables without enforcing Row Level Security (RLS).
* **Responsive Design:** Ensure all pages render cleanly on both mobile viewport (<640px) and desktop screens.
