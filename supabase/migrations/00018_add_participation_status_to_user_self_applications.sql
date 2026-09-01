-- Migration 00018: Add participation_status to user_self_applications
ALTER TABLE public.user_self_applications 
ADD COLUMN IF NOT EXISTS participation_status TEXT DEFAULT 'applied';

COMMENT ON COLUMN public.user_self_applications.participation_status IS 'User participation level: interested, applied, rejected, participant, not_resident, considering_move, local_not_qualified';
