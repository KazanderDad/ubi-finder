-- ============================================================================
-- Migration: Add min_age and max_age to programs, and birth_year to user_profiles
-- ============================================================================

-- 1. Add age limits to programs table
alter table public.programs
  add column if not exists min_age integer check (min_age >= 0),
  add column if not exists max_age integer check (max_age >= 0);

-- 2. Add birth_year to user_profiles table
alter table public.user_profiles
  add column if not exists birth_year integer check (birth_year >= 1900 and birth_year <= 2100);

-- 3. Create indices for age filtering
create index if not exists idx_programs_min_age on public.programs(min_age);
create index if not exists idx_programs_max_age on public.programs(max_age);
create index if not exists idx_user_profiles_birth_year on public.user_profiles(birth_year);
