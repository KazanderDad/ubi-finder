-- ============================================================================
-- Migration 00014: Add 'owner' to user_role enum
-- ============================================================================

DO $$ BEGIN
  ALTER TYPE public.user_role ADD VALUE IF NOT EXISTS 'owner' BEFORE 'admin';
EXCEPTION WHEN OTHERS THEN NULL; END $$;
