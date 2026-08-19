create table public.services_intake (
    id uuid primary key default gen_random_uuid(),
    created_at timestamptz default now() not null,
    name text not null,
    email text not null,
    organization text,
    message text not null,
    status text default 'new' not null
);

alter table public.services_intake enable row level security;

create policy "Allow public inserts on services_intake"
    on public.services_intake for insert
    with check (true);
