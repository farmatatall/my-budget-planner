-- My Budget Planner: private one-row-per-user cloud storage
-- Run this entire script in Supabase Dashboard -> SQL Editor -> New query.
-- This table stores the planner JSON for the signed-in owner only.

create table if not exists public.planner_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.planner_data enable row level security;

-- Remove broad client access, then grant only signed-in users the operations needed.
revoke all on table public.planner_data from anon, authenticated;
grant select, insert, update, delete on table public.planner_data to authenticated;

drop policy if exists "Users can read their own planner" on public.planner_data;
drop policy if exists "Users can create their own planner" on public.planner_data;
drop policy if exists "Users can update their own planner" on public.planner_data;
drop policy if exists "Users can delete their own planner" on public.planner_data;

create policy "Users can read their own planner"
  on public.planner_data for select to authenticated
  using ((select auth.uid()) = user_id);

create policy "Users can create their own planner"
  on public.planner_data for insert to authenticated
  with check ((select auth.uid()) = user_id);

create policy "Users can update their own planner"
  on public.planner_data for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

create policy "Users can delete their own planner"
  on public.planner_data for delete to authenticated
  using ((select auth.uid()) = user_id);

-- Enable Realtime updates so a change on one signed-in device can appear on another.
do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'planner_data'
  ) then
    execute 'alter publication supabase_realtime add table public.planner_data';
  end if;
end $$;