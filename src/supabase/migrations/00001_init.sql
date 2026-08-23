-- ============================================================================
-- UBI Finder — Supabase / PostgreSQL initial migration
-- Creates all tables, enums, indexes, triggers, and RLS policies.
-- Run with: supabase db push  (or psql -f this file)
-- ============================================================================


-- ---------- Extensions -------------------------------------------------------
create extension if not exists "pgcrypto";   -- gen_random_uuid()
create extension if not exists "uuid-ossp";  -- uuid_generate_v4() (fallback)


-- ---------- Enums ------------------------------------------------------------
do $$ begin
 create type user_gender as enum ('female', 'male', 'abstain');
exception when duplicate_object then null; end $$;


do $$ begin
 create type income_range as enum ('0-20k', '20k-40k', '40k-60k', '60k+');
exception when duplicate_object then null; end $$;


do $$ begin
 create type program_gender_requirement as enum ('female', 'male', 'other');
exception when duplicate_object then null; end $$;


do $$ begin
 create type payment_method as enum ('standard', 'digital', 'both');
exception when duplicate_object then null; end $$;


do $$ begin
 create type program_status as enum ('active', 'active_open', 'active_closed', 'upcoming', 'closed', 'pending_approval');
exception when duplicate_object then null; end $$;


do $$ begin
 create type crypto_blockchain as enum (
   'ethereum', 'bitcoin', 'solana', 'polygon',
   'avalanche', 'binance_smart_chain', 'other'
 );
exception when duplicate_object then null; end $$;


do $$ begin
 create type program_manager_role as enum ('owner', 'admin');
exception when duplicate_object then null; end $$;


do $$ begin
 create type application_status as enum ('pending', 'approved', 'rejected');
exception when duplicate_object then null; end $$;


do $$ begin
 create type user_role as enum ('admin', 'user');
exception when duplicate_object then null; end $$;


-- ---------- Reusable: updated_at trigger -------------------------------------
create or replace function set_updated_at()
returns trigger as $$
begin
 new.updated_date = now();
 return new;
end;
$$ language plpgsql;


-- ============================================================================
-- Users (mirrors the built-in Base44 auth user)
-- ============================================================================
create table if not exists public.users (
 id            uuid primary key default gen_random_uuid(),
 email         text unique not null,
 full_name     text,
 role          user_role not null default 'user',
 created_date  timestamptz not null default now(),
 updated_date  timestamptz not null default now()
);


create or replace view public.profiles as select * from public.users;


-- ============================================================================
-- User Profiles
-- ============================================================================
create table if not exists public.user_profiles (
 id                       uuid primary key default gen_random_uuid(),
 name                     text not null,
 gender                   user_gender not null,
 country                  text not null,
 state                    text,
 currency                 text not null default 'USD',
 accepts_digital_currency boolean not null default true,
 accepts_foreign_currency boolean not null default true,
 household_size           integer not null check (household_size >= 1),
 income_range             income_range not null,
 min_monthly_payment      numeric(12, 2),
 profile_picture          text,
 dismissed_program_info   boolean not null default false,
 is_public                boolean not null default false,
 -- built-in audit fields
 created_by_id            uuid references public.users(id) on delete set null,
 created_date             timestamptz not null default now(),
 updated_date             timestamptz not null default now()
);


create index if not exists idx_user_profiles_created_by
 on public.user_profiles(created_by_id);


create index if not exists idx_user_profiles_country
 on public.user_profiles(country);


create trigger trg_user_profiles_updated_at
 before update on public.user_profiles
 for each row execute function set_updated_at();


-- ============================================================================
-- Programs
-- ============================================================================
create table if not exists public.programs (
 id                       uuid primary key default gen_random_uuid(),
 program_id               integer not null unique check (program_id >= 1),
 name                     text not null,
 organization             text not null,
 description              text not null,
 gender_requirement       program_gender_requirement,
 monthly_amount_usd       numeric(12, 2) not null check (monthly_amount_usd >= 0),
 currency                 text not null default 'USD',
 available_regions        text[] not null default '{}',
 required_states          text[] default '{}',
 payment_method           payment_method not null,
 amount_description       text not null,
 max_household_income_usd numeric(12, 2),
 eligibility              text,
 status                   program_status not null,
 website                  text,
 verified                 boolean not null default false,
 submitter_email          text,
 -- built-in audit fields
 created_by_id            uuid references public.users(id) on delete set null,
 created_date             timestamptz not null default now(),
 updated_date             timestamptz not null default now()
);


create index if not exists idx_programs_program_id   on public.programs(program_id);
create index if not exists idx_programs_status        on public.programs(status);
create index if not exists idx_programs_currency     on public.programs(currency);
create index if not exists idx_programs_regions      on public.programs using gin (available_regions);
create index if not exists idx_programs_states        on public.programs using gin (required_states);


create trigger trg_programs_updated_at
 before update on public.programs
 for each row execute function set_updated_at();


-- ============================================================================
-- Program Managers (per-user access + favorites)
-- ============================================================================
create table if not exists public.program_managers (
 id               uuid primary key default gen_random_uuid(),
 program_id       integer not null references public.programs(program_id) on delete cascade,
 user_email       text not null,
 user_profile_id  uuid references public.user_profiles(id) on delete cascade,
 role             program_manager_role not null,
 is_favorite      boolean not null default false,
 added_date       timestamptz not null default now(),
 -- built-in audit fields
 created_by_id    uuid references public.users(id) on delete set null,
 created_date     timestamptz not null default now(),
 updated_date     timestamptz not null default now(),
 unique (program_id, user_email)
);


create index if not exists idx_pm_program_id      on public.program_managers(program_id);
create index if not exists idx_pm_user_email       on public.program_managers(user_email);
create index if not exists idx_pm_user_profile_id on public.program_managers(user_profile_id);
create index if not exists idx_pm_favorites        on public.program_managers(user_email) where is_favorite = true;


create trigger trg_program_managers_updated_at
 before update on public.program_managers
 for each row execute function set_updated_at();


-- ============================================================================
-- Applications
-- ============================================================================
create table if not exists public.applications (
 id               uuid primary key default gen_random_uuid(),
 program_id       integer not null references public.programs(program_id) on delete cascade,
 user_email       text not null,
 user_profile_id  uuid references public.user_profiles(id) on delete cascade,
 status           application_status not null default 'pending',
 submitted_date   timestamptz not null default now(),
 -- built-in audit fields
 created_by_id    uuid references public.users(id) on delete set null,
 created_date     timestamptz not null default now(),
 updated_date     timestamptz not null default now()
);


create index if not exists idx_app_program_id      on public.applications(program_id);
create index if not exists idx_app_user_email       on public.applications(user_email);
create index if not exists idx_app_user_profile_id on public.applications(user_profile_id);
create index if not exists idx_app_status          on public.applications(status);


create trigger trg_applications_updated_at
 before update on public.applications
 for each row execute function set_updated_at();


-- ============================================================================
-- Bank Accounts
-- ============================================================================
create table if not exists public.bank_accounts (
 id                  uuid primary key default gen_random_uuid(),
 user_profile_id     uuid not null references public.user_profiles(id) on delete cascade,
 bank_name           text not null,
 account_number      text not null,
 routing_number      text,
 iban                text,
 swift_code          text,
 country             text not null,
 account_holder_name text not null,
 is_primary          boolean not null default false,
 -- built-in audit fields
 created_by_id       uuid references public.users(id) on delete set null,
 created_date        timestamptz not null default now(),
 updated_date        timestamptz not null default now()
);


create index if not exists idx_bank_user_profile_id on public.bank_accounts(user_profile_id);
create index if not exists idx_bank_primary        on public.bank_accounts(user_profile_id) where is_primary = true;


create trigger trg_bank_accounts_updated_at
 before update on public.bank_accounts
 for each row execute function set_updated_at();


-- ============================================================================
-- Crypto Wallets
-- ============================================================================
create table if not exists public.crypto_wallets (
 id               uuid primary key default gen_random_uuid(),
 user_profile_id  uuid not null references public.user_profiles(id) on delete cascade,
 blockchain       crypto_blockchain not null,
 other_blockchain text,
 public_key       text not null,
 wallet_name      text,
 is_primary       boolean not null default false,
 -- built-in audit fields
 created_by_id    uuid references public.users(id) on delete set null,
 created_date     timestamptz not null default now(),
 updated_date     timestamptz not null default now()
);


create index if not exists idx_crypto_user_profile_id on public.crypto_wallets(user_profile_id);
create index if not exists idx_crypto_blockchain      on public.crypto_wallets(blockchain);
create index if not exists idx_crypto_primary        on public.crypto_wallets(user_profile_id) where is_primary = true;


create trigger trg_crypto_wallets_updated_at
 before update on public.crypto_wallets
 for each row execute function set_updated_at();


-- ============================================================================
-- Blog Posts
-- ============================================================================
create table if not exists public.blog_posts (
 id               uuid primary key default gen_random_uuid(),
 title            text not null,
 content          text not null,
 summary          text,
 author           text not null,
 posted_date      timestamptz not null,
 image_url        text,
 related_programs integer[] default '{}',
 tags             text[] default '{}',
 -- built-in audit fields
 created_by_id    uuid references public.users(id) on delete set null,
 created_date     timestamptz not null default now(),
 updated_date     timestamptz not null default now()
);


create index if not exists idx_blog_posted_date       on public.blog_posts(posted_date desc);
create index if not exists idx_blog_related_programs  on public.blog_posts using gin (related_programs);
create index if not exists idx_blog_tags               on public.blog_posts using gin (tags);


create trigger trg_blog_posts_updated_at
 before update on public.blog_posts
 for each row execute function set_updated_at();


-- ============================================================================
-- Comments
-- ============================================================================
create table if not exists public.comments (
 id               uuid primary key default gen_random_uuid(),
 blog_post_id     uuid not null references public.blog_posts(id) on delete cascade,
 content          text not null,
 author_name      text,
 author_email     text,
 -- built-in audit fields
 created_by_id    uuid references public.users(id) on delete set null,
 created_date     timestamptz not null default now(),
 updated_date     timestamptz not null default now()
);


create index if not exists idx_comments_blog_post_id on public.comments(blog_post_id);


create trigger trg_comments_updated_at
 before update on public.comments
 for each row execute function set_updated_at();


-- ============================================================================
-- Row-Level Security (Supabase / auth.uid())
-- ----------------------------------------------------------------------------
-- Helper: resolve the current user's email from auth.users -> public.users
-- ============================================================================
create or replace function public.current_user_email()
returns text
language sql
security definer
stable
as $$
 select coalesce(
   (select email from public.users where id = auth.uid()),
   (select email from auth.users where id = auth.uid())
 );
$$;


-- Enable RLS on every table
alter table public.users            enable row level security;
alter table public.user_profiles    enable row level security;
alter table public.programs         enable row level security;
alter table public.program_managers  enable row level security;
alter table public.applications      enable row level security;
alter table public.bank_accounts    enable row level security;
alter table public.crypto_wallets   enable row level security;
alter table public.blog_posts        enable row level security;
alter table public.comments         enable row level security;


-- Users: admins manage all; users see/patch their own row
create policy "users_select_all"   on public.users for select using (true);
create policy "users_update_self"  on public.users
 for update using (id = auth.uid());
create policy "users_admin_all"    on public.users
 for all using (
   exists (select 1 from public.users u where u.id = auth.uid() and u.role = 'admin')
 );


-- User Profiles: owner full access; others read none
create policy "profiles_read_public" on public.user_profiles
  for select using (is_public = true or created_by_id = auth.uid());

create policy "profiles_write_owner" on public.user_profiles
  for insert with check (created_by_id = auth.uid());

create policy "profiles_update_owner" on public.user_profiles
  for update using (created_by_id = auth.uid());

create policy "profiles_delete_owner" on public.user_profiles
  for delete using (created_by_id = auth.uid());


-- Programs: public read; submitter/admins write
create policy "programs_select_all" on public.programs
 for select using (true);
create policy "programs_insert_submitter" on public.programs
 for insert with check (created_by_id = auth.uid());
create policy "programs_update_owner" on public.programs
 for update using (
   created_by_id = auth.uid()
   or exists (
     select 1 from public.program_managers pm
     where pm.program_id = programs.program_id
       and pm.user_email = public.current_user_email()
       and pm.role in ('owner', 'admin')
   )
 );
create policy "programs_delete_owner" on public.programs
 for delete using (
   created_by_id = auth.uid()
   or exists (
     select 1 from public.program_managers pm
     where pm.program_id = programs.program_id
       and pm.user_email = public.current_user_email()
       and pm.role = 'owner'
   )
 );


-- Program Managers: owner of the record (by email) full access
create policy "pm_select" on public.program_managers
 for select using (
   user_email = public.current_user_email()
   or exists (
     select 1 from public.program_managers pm
     where pm.program_id = program_managers.program_id
       and pm.user_email = public.current_user_email()
       and pm.role in ('owner', 'admin')
   )
   or exists (
     select 1 from public.programs p
     where p.program_id = program_managers.program_id
       and p.created_by_id = auth.uid()
   )
 );

create policy "pm_all" on public.program_managers
 for all using (
   user_email = public.current_user_email()
   or exists (
     select 1 from public.program_managers pm
     where pm.program_id = program_managers.program_id
       and pm.user_email = public.current_user_email()
       and pm.role in ('owner', 'admin')
   )
   or exists (
     select 1 from public.programs p
     where p.program_id = program_managers.program_id
       and p.created_by_id = auth.uid()
   )
 )
 with check (
   user_email = public.current_user_email()
   or exists (
     select 1 from public.program_managers pm
     where pm.program_id = program_managers.program_id
       and pm.user_email = public.current_user_email()
       and pm.role in ('owner', 'admin')
   )
   or exists (
     select 1 from public.programs p
     where p.program_id = program_managers.program_id
       and p.created_by_id = auth.uid()
   )
 );


-- Applications: applicant full access
create policy "app_applicant_all" on public.applications
 for all using (user_email = public.current_user_email())
 with check (user_email = public.current_user_email());


-- Bank Accounts: profile owner full access
create policy "bank_owner_all" on public.bank_accounts
 for all using (
   exists (
     select 1 from public.user_profiles up
     where up.id = bank_accounts.user_profile_id
       and up.created_by_id = auth.uid()
   )
 )
 with check (
   exists (
     select 1 from public.user_profiles up
     where up.id = bank_accounts.user_profile_id
       and up.created_by_id = auth.uid()
   )
 );


-- Crypto Wallets: profile owner full access
create policy "crypto_owner_all" on public.crypto_wallets
 for all using (
   exists (
     select 1 from public.user_profiles up
     where up.id = crypto_wallets.user_profile_id
       and up.created_by_id = auth.uid()
   )
 )
 with check (
   exists (
     select 1 from public.user_profiles up
     where up.id = crypto_wallets.user_profile_id
       and up.created_by_id = auth.uid()
   )
 );


-- Blog Posts: public read; author/admins write
create policy "blog_select_all" on public.blog_posts
 for select using (true);
create policy "blog_author_write" on public.blog_posts
 for all using (
   created_by_id = auth.uid()
   or exists (
     select 1 from public.users u where u.id = auth.uid() and u.role = 'admin'
   )
 )
 with check (
   created_by_id = auth.uid()
   or exists (
     select 1 from public.users u where u.id = auth.uid() and u.role = 'admin'
   )
 );


-- Comments: public read; author insert/update/delete
create policy "comments_select_all" on public.comments
 for select using (true);
create policy "comments_author_write" on public.comments
 for all using (created_by_id = auth.uid())
 with check (created_by_id = auth.uid());


-- ============================================================================
