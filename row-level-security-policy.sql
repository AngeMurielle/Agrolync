-- Row Level Security policies for AgroLync
-- Run this file after supabase_schema.sql in your Supabase project.

-- 1. Enable RLS on every table that stores user-specific or sensitive data.
alter table if exists public.users enable row level security;
alter table if exists public.addresses enable row level security;
alter table if exists public.products enable row level security;
alter table if exists public.orders enable row level security;
alter table if exists public.order_items enable row level security;
alter table if exists public.wallet_transactions enable row level security;
alter table if exists public.logistics_jobs enable row level security;
alter table if exists public.logistics_routes enable row level security;
alter table if exists public.ratings enable row level security;

-- 2. USERS: only authenticated users can read and modify their own profile.
create policy users_select_own_profile on public.users
  for select using (auth.uid() = id);
create policy users_insert_own_profile on public.users
  for insert with check (auth.uid() = id);
create policy users_update_own_profile on public.users
  for update using (auth.uid() = id)
  with check (auth.uid() = id);
create policy users_delete_own_profile on public.users
  for delete using (auth.uid() = id);

-- 3. ADDRESSES: each row belongs to a single user.
create policy addresses_select_own on public.addresses
  for select using (user_id = auth.uid());
create policy addresses_insert_own on public.addresses
  for insert with check (user_id = auth.uid());
create policy addresses_update_own on public.addresses
  for update using (user_id = auth.uid())
  with check (user_id = auth.uid());
create policy addresses_delete_own on public.addresses
  for delete using (user_id = auth.uid());

-- 4. PRODUCTS: all authenticated users may browse active products.
create policy products_select_active on public.products
  for select using (status = 'ACTIVE' OR seller_id = auth.uid());
create policy products_insert_seller on public.products
  for insert with check (seller_id = auth.uid());
create policy products_update_seller on public.products
  for update using (seller_id = auth.uid())
  with check (seller_id = auth.uid());
create policy products_delete_seller on public.products
  for delete using (seller_id = auth.uid());

-- 5. ORDERS: buyers can only read and manage their own orders.
create policy orders_select_own on public.orders
  for select using (user_id = auth.uid());
create policy orders_insert_own on public.orders
  for insert with check (user_id = auth.uid());
create policy orders_update_own on public.orders
  for update using (user_id = auth.uid())
  with check (user_id = auth.uid());
create policy orders_delete_own on public.orders
  for delete using (user_id = auth.uid());

-- 6. ORDER_ITEMS: only order owners may access items from their order.
create policy order_items_select_order_owner on public.order_items
  for select using (
    exists(
      select 1 from public.orders
      where public.orders.id = order_items.order_id
        and public.orders.user_id = auth.uid()
    )
  );
create policy order_items_insert_order_owner on public.order_items
  for insert with check (
    exists(
      select 1 from public.orders
      where public.orders.id = order_items.order_id
        and public.orders.user_id = auth.uid()
    )
  );
create policy order_items_update_order_owner on public.order_items
  for update using (
    exists(
      select 1 from public.orders
      where public.orders.id = order_items.order_id
        and public.orders.user_id = auth.uid()
    )
  ) with check (
    exists(
      select 1 from public.orders
      where public.orders.id = order_items.order_id
        and public.orders.user_id = auth.uid()
    )
  );
create policy order_items_delete_order_owner on public.order_items
  for delete using (
    exists(
      select 1 from public.orders
      where public.orders.id = order_items.order_id
        and public.orders.user_id = auth.uid()
    )
  );

-- 7. WALLET_TRANSACTIONS: only the wallet owner may see or add their history.
create policy wallet_transactions_select_own on public.wallet_transactions
  for select using (user_id = auth.uid());
create policy wallet_transactions_insert_own on public.wallet_transactions
  for insert with check (user_id = auth.uid());
create policy wallet_transactions_update_own on public.wallet_transactions
  for update using (user_id = auth.uid())
  with check (user_id = auth.uid());
create policy wallet_transactions_delete_own on public.wallet_transactions
  for delete using (user_id = auth.uid());

-- 8. LOGISTICS_JOBS: all authenticated users can browse available jobs.
create policy logistics_jobs_select_public on public.logistics_jobs
  for select using (true);

-- 9. LOGISTICS_ROUTES: drivers may see and manage only their own routes.
create policy logistics_routes_select_driver on public.logistics_routes
  for select using (driver_id = auth.uid());
create policy logistics_routes_insert_driver on public.logistics_routes
  for insert with check (driver_id = auth.uid());
create policy logistics_routes_update_driver on public.logistics_routes
  for update using (driver_id = auth.uid())
  with check (driver_id = auth.uid());
create policy logistics_routes_delete_driver on public.logistics_routes
  for delete using (driver_id = auth.uid());

-- 10. RATINGS: reviewers and reviewees can access their own ratings.
create policy ratings_select_own on public.ratings
  for select using (reviewer_id = auth.uid() OR reviewee_id = auth.uid());
create policy ratings_insert_reviewer on public.ratings
  for insert with check (reviewer_id = auth.uid());
create policy ratings_update_reviewer on public.ratings
  for update using (reviewer_id = auth.uid())
  with check (reviewer_id = auth.uid());
create policy ratings_delete_reviewer on public.ratings
  for delete using (reviewer_id = auth.uid());

-- 11. Final safety: do not allow unexpected anonymous write access.
-- Keep policy-based access management and do not create broad public write policies.

commit;
