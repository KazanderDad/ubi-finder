-- ============================================================================
-- Migration: Add payout_status, application_status, sources, apply_url
--            and extend gender_requirement enum with 'other'
-- Safe for existing rows: all new columns are nullable with sensible defaults.
-- ============================================================================

-- 1. Add 'other' to the gender enum (cannot be done in one ALTER; use a workaround)
--    We add the new value – Postgres allows this non-destructively.
alter type program_gender_requirement add value if not exists 'other';

-- 2. Add new text columns (nullable so existing rows are unaffected)
alter table public.programs
  add column if not exists payout_status      text,
  add column if not exists application_status text,
  add column if not exists apply_url          text,
  add column if not exists sources            text[] not null default '{}';

-- 3. Backfill apply_url from existing website column where apply_url is empty
update public.programs
  set apply_url = website
  where apply_url is null and website is not null;

-- 4. Backfill payout_status from existing status enum for existing rows
update public.programs
  set payout_status = case
    when status in ('active', 'active_open', 'active_closed') then 'Ongoing'
    when status = 'upcoming'                                   then 'Planned'
    when status = 'closed'                                     then 'Ended'
    else 'Unknown'
  end
  where payout_status is null;

-- 5. Backfill application_status from existing status enum for existing rows
update public.programs
  set application_status = case
    when status = 'active_open'   then 'Accepting applications'
    when status = 'active_closed' then 'No longer accepting applications'
    when status = 'upcoming'      then 'Not open yet'
    when status = 'closed'        then 'No longer accepting applications'
    else 'Accepting applications'
  end
  where application_status is null;

-- 6. Create an index on the new status fields for filtering
create index if not exists idx_programs_payout_status      on public.programs(payout_status);
create index if not exists idx_programs_application_status on public.programs(application_status);
create index if not exists idx_programs_sources            on public.programs using gin (sources);
