-- Migration 00008: User Match Snapshots & Real-time Notification Delta Engine

-- 1. Create user_match_snapshots table
CREATE TABLE IF NOT EXISTS public.user_match_snapshots (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    profile_id UUID REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    matched_program_ids INT[] NOT NULL DEFAULT '{}',
    match_scores JSONB NOT NULL DEFAULT '{}'::jsonb,
    tier_summary JSONB NOT NULL DEFAULT '{}'::jsonb,
    total_potential_monthly_usd NUMERIC(10,2) DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Index for fast lookup by user
CREATE INDEX IF NOT EXISTS idx_match_snapshots_user_created ON public.user_match_snapshots(user_id, created_at DESC);

-- 2. Create user_notifications table
CREATE TABLE IF NOT EXISTS public.user_notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL, -- 'new_program_available', 'program_demoted', 'status_changed', 'payout_updated', 'milestone'
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    program_id INT,
    program_name TEXT,
    severity VARCHAR(20) DEFAULT 'info', -- 'info', 'success', 'warning', 'urgent'
    read BOOLEAN NOT NULL DEFAULT FALSE,
    action_url TEXT,
    metadata JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Index for fast user notification querying
CREATE INDEX IF NOT EXISTS idx_user_notifications_user_read ON public.user_notifications(user_id, read, created_at DESC);

-- Enable RLS
ALTER TABLE public.user_match_snapshots ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_notifications ENABLE ROW LEVEL SECURITY;

-- RLS Policies for user_match_snapshots
CREATE POLICY "Users can manage their own match snapshots"
    ON public.user_match_snapshots
    FOR ALL
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- RLS Policies for user_notifications
CREATE POLICY "Users can manage their own notifications"
    ON public.user_notifications
    FOR ALL
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
