-- Migration 00027: Community Supporter Points and Donations
-- Tracks user usage points, IP threshold halving, single-time donation encouragements, and Stripe donations.

-- 1. Table for tracking usage points and threshold states
CREATE TABLE IF NOT EXISTS public.user_usage_points (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    ip_hash TEXT NOT NULL,
    points_total INTEGER NOT NULL DEFAULT 0,
    program_views_count INTEGER NOT NULL DEFAULT 0,
    map_views_count INTEGER NOT NULL DEFAULT 0,
    search_queries_count INTEGER NOT NULL DEFAULT 0,
    encouragement_shown BOOLEAN NOT NULL DEFAULT FALSE,
    has_donated BOOLEAN NOT NULL DEFAULT FALSE,
    total_donated_usd NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    last_action_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(user_id, ip_hash)
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_usage_points_user ON public.user_usage_points(user_id);
CREATE INDEX IF NOT EXISTS idx_usage_points_ip ON public.user_usage_points(ip_hash);
CREATE INDEX IF NOT EXISTS idx_usage_points_donated ON public.user_usage_points(has_donated);

-- 2. Donations ledger table
CREATE TABLE IF NOT EXISTS public.donations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    user_email TEXT,
    ip_hash TEXT,
    stripe_session_id TEXT UNIQUE,
    stripe_payment_intent_id TEXT,
    amount_usd NUMERIC(10,2) NOT NULL CHECK (amount_usd >= 1.00),
    status TEXT NOT NULL DEFAULT 'completed',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_donations_user ON public.donations(user_id);
CREATE INDEX IF NOT EXISTS idx_donations_ip ON public.donations(ip_hash);

-- 3. Enable RLS
ALTER TABLE public.user_usage_points ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.donations ENABLE ROW LEVEL SECURITY;

-- RLS Policies for user_usage_points
CREATE POLICY "Users can view their own usage points"
    ON public.user_usage_points
    FOR SELECT
    TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert/update their own usage points"
    ON public.user_usage_points
    FOR ALL
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Public/Anon can view and manage points by ip_hash"
    ON public.user_usage_points
    FOR ALL
    TO anon
    USING (true)
    WITH CHECK (true);

-- RLS Policies for donations
CREATE POLICY "Users can view their own donations"
    ON public.donations
    FOR SELECT
    TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "Authenticated and anon can record donations"
    ON public.donations
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);
