-- OFF: things a visitor put down (My Box). One private set per anonymous Supabase session.
create table public.off_box_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  text text not null check (char_length(btrim(text)) between 1 and 500),
  status text not null default 'open' check (status in ('open', 'done', 'gone')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

comment on table public.off_box_items is 'OFF app: things a visitor put down (My Box). One private set per anonymous session.';

create index off_box_items_user_created_idx on public.off_box_items (user_id, created_at desc);

create or replace function public.off_touch_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger off_box_items_touch
before update on public.off_box_items
for each row execute function public.off_touch_updated_at();

alter table public.off_box_items enable row level security;

create policy "own items: read" on public.off_box_items
  for select to authenticated
  using ((select auth.uid()) = user_id);

create policy "own items: add" on public.off_box_items
  for insert to authenticated
  with check ((select auth.uid()) = user_id);

create policy "own items: change" on public.off_box_items
  for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

create policy "own items: remove" on public.off_box_items
  for delete to authenticated
  using ((select auth.uid()) = user_id);

revoke all on public.off_box_items from anon;
grant select, insert, update, delete on public.off_box_items to authenticated;
