# Contributing to UBI Finder 🌱

Thank you for your interest in contributing to UBI Finder! Together, we can make universal basic income opportunities transparent, verifiable, and accessible to everyone.

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
   npm install
   ```

4. **Configure Environment:**
   Copy `.env.example` to `.env` and configure your local or remote Supabase credentials.

5. **Start Dev Server:**
   ```bash
   npm run dev
   ```

6. **Verify Build & Types:**
   Before pushing, verify that the production build completes without errors:
   ```bash
   npm run build
   ```

7. **Commit & Push:**
   Use clear and conventional commit messages (e.g. `feat: add filter for regional grants`, `fix: handle null gender requirement in matching engine`).

8. **Submit a Pull Request:**
   Open a pull request describing the change, motivation, and any verification steps performed.

---

## 📋 Coding Standards

* **Components:** Keep UI components modular, reusable, and accessible using Tailwind CSS and Radix primitives.
* **Database & Auth:** Use native Supabase client queries (`supabase.from(...)`) and native authentication. Never query sensitive user tables without enforcing Row Level Security (RLS).
* **Responsive Design:** Ensure all pages render cleanly on both mobile viewport (<640px) and desktop screens.
