-- 1. Add 'pending_approval' to program_status enum
ALTER TYPE program_status ADD VALUE IF NOT EXISTS 'pending_approval';

-- 2. Add 'is_public' to user_profiles
ALTER TABLE public.user_profiles ADD COLUMN IF NOT EXISTS is_public BOOLEAN NOT NULL DEFAULT false;

-- 3. Update RLS on user_profiles
DROP POLICY IF EXISTS "profiles_owner_all" ON public.user_profiles;

CREATE POLICY "profiles_read_public" ON public.user_profiles
  FOR SELECT USING (is_public = true OR created_by_id = auth.uid());

CREATE POLICY "profiles_write_owner" ON public.user_profiles
  FOR INSERT WITH CHECK (created_by_id = auth.uid());

CREATE POLICY "profiles_update_owner" ON public.user_profiles
  FOR UPDATE USING (created_by_id = auth.uid());

CREATE POLICY "profiles_delete_owner" ON public.user_profiles
  FOR DELETE USING (created_by_id = auth.uid());

-- 4. Update RLS on program_managers
DROP POLICY IF EXISTS "program_managers_owner" ON public.program_managers;

CREATE POLICY "program_managers_select" ON public.program_managers
  FOR SELECT USING (
    created_by_id = auth.uid() 
    OR 
    EXISTS (
      SELECT 1 FROM public.program_managers pm 
      WHERE pm.program_id = program_managers.program_id 
        AND pm.created_by_id = auth.uid() 
        AND pm.role IN ('owner', 'admin')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.programs p
      WHERE p.program_id = program_managers.program_id
        AND p.created_by_id = auth.uid()
    )
  );

CREATE POLICY "program_managers_all" ON public.program_managers
  FOR ALL USING (
    created_by_id = auth.uid() 
    OR 
    EXISTS (
      SELECT 1 FROM public.program_managers pm 
      WHERE pm.program_id = program_managers.program_id 
        AND pm.created_by_id = auth.uid() 
        AND pm.role IN ('owner', 'admin')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.programs p
      WHERE p.program_id = program_managers.program_id
        AND p.created_by_id = auth.uid()
    )
  );
