-- ============================================================================
-- Migration 00007: Add internal_status to programs and manage program visibility
-- ============================================================================

-- 1. Add internal_status column
alter table public.programs
  add column if not exists internal_status text not null default 'active';

-- 2. Create index on internal_status for performant filtering
create index if not exists idx_programs_internal_status
  on public.programs(internal_status);

-- 3. Mark any legacy mock / placeholder records as deleted
update public.programs
  set internal_status = 'deleted'
  where name in (
    'Community Support Initiative',
    'Digital Income Project',
    'Global Basic Income',
    'Women''s Empowerment Fund',
    'Youth Basic Income',
    'Rural Resilience Program',
    'Youth Opportunity Fund',
    'asdf',
    'Test 2',
    'Women''s Economic Empowerment Initiative',
    'Universal Dividend Network',
    'Senior Security Program'
  )
  and organization not in (
    'FundLoop',
    'Good DAO',
    'GoodDAO',
    'GoodDollar Foundation',
    'European Central Bank',
    'EU Digital Currency Initiative'
  );
