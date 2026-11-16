create table public.bitaqati_lesson_bank (
  owner_id uuid not null default auth.uid() references auth.users(id),
  id uuid not null, lesson jsonb not null check (jsonb_typeof(lesson)='object' and octet_length(lesson::text)<1000000),
  primary key(owner_id,id)
);
alter table public.bitaqati_lesson_bank enable row level security;
revoke all on public.bitaqati_lesson_bank from public, anon, authenticated;
grant select,insert,update on public.bitaqati_lesson_bank to authenticated;
create policy lesson_owner_select on public.bitaqati_lesson_bank for select to authenticated using(owner_id=(select auth.uid()));
create policy lesson_owner_insert on public.bitaqati_lesson_bank for insert to authenticated with check(owner_id=(select auth.uid()));
create policy lesson_owner_update on public.bitaqati_lesson_bank for update to authenticated using(owner_id=(select auth.uid())) with check(owner_id=(select auth.uid()));
