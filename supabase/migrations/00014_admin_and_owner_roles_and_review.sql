-- ============================================================================
-- Migration 00014: Admin & Owner Role Identifiers, Protection, and Submission Notifications
-- ============================================================================

-- 1. Add 'owner' value to user_role enum
DO $$ BEGIN
  ALTER TYPE public.user_role ADD VALUE IF NOT EXISTS 'owner' BEFORE 'admin';
EXCEPTION WHEN OTHERS THEN NULL; END $$;

-- 2. Update is_admin() and create is_owner() helper functions (using role::text for transactional enum safety)
CREATE OR REPLACE FUNCTION public.is_admin()
  RETURNS boolean
  LANGUAGE sql
  SECURITY DEFINER
  STABLE
  SET search_path = public
AS $$
  SELECT exists (
    SELECT 1 FROM public.users
    WHERE id = auth.uid() AND (role::text = 'admin' OR role::text = 'owner')
  );
$$;

CREATE OR REPLACE FUNCTION public.is_owner()
  RETURNS boolean
  LANGUAGE sql
  SECURITY DEFINER
  STABLE
  SET search_path = public
AS $$
  SELECT exists (
    SELECT 1 FROM public.users
    WHERE id = auth.uid() AND role::text = 'owner'
  );
$$;

-- 3. Owner & Role Protection Trigger
CREATE OR REPLACE FUNCTION public.protect_owner_role()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  -- If the target row is currently an owner and someone attempts to change their role
  IF OLD.role::text = 'owner' AND NEW.role::text != 'owner' THEN
    RAISE EXCEPTION 'Owners cannot be demoted or removed from the owner role.';
  END IF;

  -- If non-owner tries to modify any owner account data
  IF OLD.role::text = 'owner' AND NOT public.is_owner() AND auth.uid() IS NOT NULL THEN
    RAISE EXCEPTION 'Only owners can modify owner accounts.';
  END IF;

  -- If non-admin tries to change any role
  IF OLD.role::text != NEW.role::text AND NOT public.is_admin() AND auth.uid() IS NOT NULL THEN
    RAISE EXCEPTION 'Only administrators can change user roles.';
  END IF;

  -- If non-owner tries to promote someone to owner
  IF NEW.role::text = 'owner' AND OLD.role::text != 'owner' AND NOT public.is_owner() AND auth.uid() IS NOT NULL THEN
    RAISE EXCEPTION 'Only owners can promote users to the owner role.';
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_protect_owner_role ON public.users;
CREATE TRIGGER trg_protect_owner_role
  BEFORE UPDATE ON public.users
  FOR EACH ROW EXECUTE FUNCTION public.protect_owner_role();

-- Prevent deletion of owners
CREATE OR REPLACE FUNCTION public.protect_owner_delete()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF OLD.role::text = 'owner' THEN
    RAISE EXCEPTION 'Owner accounts cannot be deleted.';
  END IF;
  RETURN OLD;
END;
$$;

DROP TRIGGER IF EXISTS trg_protect_owner_delete ON public.users;
CREATE TRIGGER trg_protect_owner_delete
  BEFORE DELETE ON public.users
  FOR EACH ROW EXECUTE FUNCTION public.protect_owner_delete();

-- 4. RPC to safely elevate/demote user roles
CREATE OR REPLACE FUNCTION public.set_user_role(target_user_id uuid, new_role text)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  caller_is_admin boolean;
  caller_is_owner boolean;
  target_current_role text;
BEGIN
  caller_is_admin := public.is_admin();
  IF NOT caller_is_admin THEN
    RAISE EXCEPTION 'Unauthorized: Only admins can manage roles.';
  END IF;

  caller_is_owner := public.is_owner();

  SELECT role::text INTO target_current_role FROM public.users WHERE id = target_user_id;
  IF target_current_role IS NULL THEN
    RAISE EXCEPTION 'User not found.';
  END IF;

  IF target_current_role = 'owner' AND new_role != 'owner' THEN
    RAISE EXCEPTION 'Cannot demote or remove an owner.';
  END IF;

  IF new_role = 'owner' AND NOT caller_is_owner THEN
    RAISE EXCEPTION 'Only existing owners can promote someone to owner.';
  END IF;

  IF new_role NOT IN ('owner', 'admin', 'user') THEN
    RAISE EXCEPTION 'Invalid role: %', new_role;
  END IF;

  UPDATE public.users
  SET role = new_role::user_role, updated_date = now()
  WHERE id = target_user_id;

  RETURN json_build_object('success', true, 'user_id', target_user_id, 'new_role', new_role);
END;
$$;

-- 5. Programs table admin access
DO $$ BEGIN
  DROP POLICY IF EXISTS "programs_admin_all" ON public.programs;
  CREATE POLICY "programs_admin_all" ON public.programs
    FOR ALL USING (public.is_admin())
    WITH CHECK (public.is_admin());
EXCEPTION WHEN OTHERS THEN NULL; END $$;

-- 6. Admin notifications table for new program submissions
CREATE TABLE IF NOT EXISTS public.admin_notifications (
  id uuid primary key default gen_random_uuid(),
  type text not null default 'new_program_submission',
  program_id integer,
  program_name text,
  submitter_email text,
  payload jsonb,
  read_by uuid[] default '{}',
  created_at timestamptz default now()
);

ALTER TABLE public.admin_notifications ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  DROP POLICY IF EXISTS "admin_notifications_admin_all" ON public.admin_notifications;
  CREATE POLICY "admin_notifications_admin_all" ON public.admin_notifications
    FOR ALL USING (public.is_admin())
    WITH CHECK (public.is_admin());
EXCEPTION WHEN OTHERS THEN NULL; END $$;

-- Trigger to record submission notifications
CREATE OR REPLACE FUNCTION public.handle_new_program_submission()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.admin_notifications (type, program_id, program_name, submitter_email, payload)
  VALUES (
    'new_program_submission',
    NEW.program_id,
    NEW.name,
    NEW.submitter_email,
    json_build_object(
      'program_id', NEW.program_id,
      'name', NEW.name,
      'organization', NEW.organization,
      'submitter_email', NEW.submitter_email,
      'amount_description', NEW.amount_description,
      'created_at', now()
    )::jsonb
  );

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_on_program_submitted ON public.programs;
CREATE TRIGGER trg_on_program_submitted
  AFTER INSERT ON public.programs
  FOR EACH ROW
  WHEN (NEW.verified = false OR NEW.internal_status = 'pending_review')
  EXECUTE FUNCTION public.handle_new_program_submission();

-- 7. Ensure at least one owner exists
UPDATE public.users
SET role = 'owner'
WHERE role = 'admin' OR email ILIKE '%noak%' OR email ILIKE '%@firebelly.xyz';

UPDATE public.users
SET role = 'owner'
WHERE id = (SELECT id FROM public.users ORDER BY created_date ASC LIMIT 1)
  AND NOT EXISTS (SELECT 1 FROM public.users WHERE role = 'owner');
