-- ============================================================================
-- Migration: 00012_sync_auth_users_and_fk_fix.sql
-- Purpose: Sync auth.users to public.users automatically, add insert policy,
--          and ensure foreign key constraints on public.users succeed.
-- ============================================================================

-- 1. Ensure public.users has RLS policy allowing authenticated users to insert/upsert their own record
DO $$ BEGIN
  DROP POLICY IF EXISTS "users_insert_self" ON public.users;
  CREATE POLICY "users_insert_self" ON public.users 
    FOR INSERT TO authenticated 
    WITH CHECK (id = auth.uid());
EXCEPTION WHEN OTHERS THEN NULL; END $$;

DO $$ BEGIN
  DROP POLICY IF EXISTS "users_update_self" ON public.users;
  CREATE POLICY "users_update_self" ON public.users 
    FOR UPDATE TO authenticated 
    USING (id = auth.uid())
    WITH CHECK (id = auth.uid());
EXCEPTION WHEN OTHERS THEN NULL; END $$;

-- 2. Automatic trigger function to sync auth.users into public.users
CREATE OR REPLACE FUNCTION public.handle_new_auth_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.users (id, email, full_name, role)
  VALUES (
    new.id,
    coalesce(new.email, new.id::text || '@ubifinder.org'),
    coalesce(new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'name', 'Member'),
    'user'
  )
  ON CONFLICT (id) DO UPDATE
  SET 
    email = coalesce(excluded.email, public.users.email),
    full_name = coalesce(excluded.full_name, public.users.full_name);
  RETURN new;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT OR UPDATE ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_auth_user();

-- 3. Backfill any existing auth users into public.users
INSERT INTO public.users (id, email, full_name, role)
SELECT 
  id,
  coalesce(email, id::text || '@ubifinder.org'),
  coalesce(raw_user_meta_data->>'full_name', raw_user_meta_data->>'name', 'Member'),
  'user'
FROM auth.users
ON CONFLICT (id) DO NOTHING;
