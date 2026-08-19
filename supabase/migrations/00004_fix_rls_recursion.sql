-- ============================================================================
-- Fix: infinite recursion in users_admin_all RLS policy
-- The original policy did:
--   exists (select 1 from public.users u where u.id = auth.uid() and u.role = 'admin')
-- This causes infinite recursion because querying public.users triggers the
-- same policy again. We replace it with a security-definer function that
-- bypasses RLS, then use that in the policy.
-- ============================================================================

-- Drop the recursive policy
drop policy if exists "users_admin_all" on public.users;

-- Create a helper function that checks admin role WITHOUT going through RLS
create or replace function public.is_admin()
  returns boolean
  language sql
  security definer
  stable
  set search_path = public
as $$
  select exists (
    select 1 from public.users
    where id = auth.uid() and role = 'admin'
  );
$$;

-- Recreate the policy using the safe function
create policy "users_admin_all" on public.users
  for all using (public.is_admin());

-- Also fix blog_author_write which has the same recursive admin check
drop policy if exists "blog_author_write" on public.blog_posts;
create policy "blog_author_write" on public.blog_posts
  for all using (
    created_by_id = auth.uid()
    or public.is_admin()
  )
  with check (
    created_by_id = auth.uid()
    or public.is_admin()
  );

-- Fix comments_author_write same pattern
drop policy if exists "comments_author_write" on public.comments;
create policy "comments_author_write" on public.comments
  for all using (
    created_by_id = auth.uid()
    or public.is_admin()
  )
  with check (
    created_by_id = auth.uid()
    or public.is_admin()
  );
