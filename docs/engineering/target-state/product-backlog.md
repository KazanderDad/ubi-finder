# UBI Finder — Product & Technical Ideas

This is target-state reference material, not an active backlog. Work becomes active only when it is represented by a vetted issue in the [UBI Finder Project](https://github.com/orgs/ubi-labs/projects/1).

The ideas below were inferred from an earlier institutional schema analysis and have not been approved for implementation.

---

## 🔬 Capability 2: Academic Evidence, Objectives & Impact Tracking

### Objective
Transform UBI Finder into the definitive global research aggregator for policymakers, academics, journalists, think tanks, and philanthropic funders by capturing empirical research rigor, measured outcomes, and study publications.

### Inferred Schema Entities
* `ref_evidence_level`: Classification of study rigor
  * *RCT (Randomized Controlled Trial)* (e.g. Stockton SEED, GiveDirectly Kenya)
  * *Quasi-Experimental Pilot*
  * *Observational Cohort Study*
  * *Qualitative / Case-Based Study*
  * *Universal Statutory Policy* (e.g. Alaska Permanent Fund)
* `ref_data_quality`: Level of verification and auditability (Tier 1 Peer-reviewed, Tier 2 Institutional Report, Tier 3 Self-reported).
* `ref_measurement_method`: Methodologies used (Panel surveys, administrative tax records, biometric health tracking, banking telemetry).
* `ref_program_objective`: Target outcomes targeted by the pilot:
  * *Poverty Alleviation & Basic Needs*
  * *Child Nutrition & Maternal Health*
  * *Labor Market & Entrepreneurship*
  * *Mental Health & Subjective Well-being*
  * *Educational Attainment*
* `program_measurements` & `program_objectives`: Junction relationships linking programs to specific evaluated outcomes.

### Proposed UI/UX Features
1. **"Research & Impact" Tab on Program Details:**
   * Embedded whitepapers, published academic papers, and DOI links.
   * Visual outcome metrics (e.g., *+12% full-time employment retention, -38% food insecurity*).
2. **Filter by Research Rigor:**
   * Filter program catalog by "RCT Only", "Peer-Reviewed Studies Available", or "Ongoing Active Evaluation".
3. **Downloadable Research Dataset:**
   * Export standardized CSV/JSON datasets for economists and data scientists.

---

## 🏛️ Capability 3: Policy, Legislative Tracking & Governance

### Objective
Provide transparency into the full legislative and political lifecycle of basic income initiatives, allowing citizens and advocacy groups to track proposed bills before funding, participate in public comment, and review ended historical trials.

### Inferred Schema Entities
* `ref_legislation_status`: Lifecycle phase of statutory proposals:
  * `bill_drafted` — Legislative proposal drafted
  * `in_committee` — Under consideration in legislative committee
  * `floor_vote_scheduled` — Scheduled for municipal/state vote
  * `enacted_into_law` — Passed and funded into municipal/state statute
  * `executive_order` — Initiated via mayoral/gubernatorial directive
  * `citizen_referendum` — Direct ballot initiative
  * `sunset_completed` — Time-limited experiment successfully concluded
* `ref_status_workflow`: Workflow stages for live program tracking.
* `program_legislation_statuses`: Historical audit log of status progressions for a given initiative.

### Proposed UI/UX Features
1. **Policy & Legislation Tracker (`/Policy`):**
   * Feed of proposed basic income bills across US states, Canadian provinces, and international parliaments.
   * Status meters showing bill progression through chambers.
2. **Historical Experiments Archive:**
   * Filter to view completed historical pilots (e.g. *Mincome Manitoba 1974, Finland Basic Income Experiment 2017–2018, Ontario Pilot 2017*).
3. **Civic Action & Alerts:**
   * "Follow this Bill" opt-in for email alerts when key votes or public hearings are scheduled.
   * Contact links for local legislative representatives sponsoring basic income bills.
