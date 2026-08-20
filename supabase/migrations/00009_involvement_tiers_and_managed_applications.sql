-- Migration 00009: Project Involvement Tiers, Managed Applications, and Self-Reporting

-- 1. Add involvement columns to programs
ALTER TABLE public.programs 
  ADD COLUMN IF NOT EXISTS involvement_level TEXT NOT NULL DEFAULT 'external_self_apply',
  ADD COLUMN IF NOT EXISTS custom_claim_path TEXT,
  ADD COLUMN IF NOT EXISTS managed_requirements TEXT[] DEFAULT ARRAY['full_name', 'email', 'phone', 'address', 'income_tier', 'payout_rail'];

-- 2. Create managed_applications table (Type 2: Managed Applications)
CREATE TABLE IF NOT EXISTS public.managed_applications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    program_id INT NOT NULL,
    reference_code TEXT NOT NULL UNIQUE,
    submitted_payload JSONB NOT NULL,
    consent_captured BOOLEAN NOT NULL DEFAULT TRUE,
    consent_text TEXT NOT NULL,
    consent_timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    status TEXT NOT NULL DEFAULT 'submitted', -- 'submitted', 'in_review', 'approved', 'disbursed', 'rejected'
    status_message TEXT DEFAULT 'Application submitted and queued for partner verification.',
    confirmation_receipt JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Index for fast lookup by user and program
CREATE INDEX IF NOT EXISTS idx_managed_apps_user ON public.managed_applications(user_id, program_id);
CREATE INDEX IF NOT EXISTS idx_managed_apps_ref ON public.managed_applications(reference_code);

-- 3. Create user_self_applications table (Type 1: External Self-Apply user self-reports)
CREATE TABLE IF NOT EXISTS public.user_self_applications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    program_id INT NOT NULL,
    has_applied BOOLEAN NOT NULL DEFAULT TRUE,
    applied_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(user_id, program_id)
);

CREATE INDEX IF NOT EXISTS idx_user_self_apps_user ON public.user_self_applications(user_id, program_id);

-- Enable RLS
ALTER TABLE public.managed_applications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_self_applications ENABLE ROW LEVEL SECURITY;

-- RLS Policies for managed_applications
CREATE POLICY "Users can manage their own managed applications"
    ON public.managed_applications
    FOR ALL
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- RLS Policies for user_self_applications
CREATE POLICY "Users can manage their own self applications"
    ON public.user_self_applications
    FOR ALL
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- 4. Seed initial involvement tiers across known projects
UPDATE public.programs 
SET involvement_level = 'automated_claim', custom_claim_path = '/claim/gooddollar'
WHERE name ILIKE '%GoodDollar%';

UPDATE public.programs 
SET involvement_level = 'automated_claim', custom_claim_path = '/claim/fundloop'
WHERE name ILIKE '%FundLoop%';

UPDATE public.programs 
SET involvement_level = 'automated_claim', custom_claim_path = '/claim/circles'
WHERE name ILIKE '%Circles%';

UPDATE public.programs 
SET involvement_level = 'managed_application',
    managed_requirements = ARRAY['full_name', 'email', 'phone', 'address', 'income_tier', 'payout_rail']
WHERE name ILIKE '%Stockton%' OR name ILIKE '%SEED%' OR name ILIKE '%Compton%' OR name ILIKE '%New Brunswick Youth%';
