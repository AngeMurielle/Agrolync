-- Supabase SQL migration generated from app mock data schema
-- Run this in Supabase SQL Editor or migrations to create all tables.
--
-- RELATIONSHIP MAP:
-- users 1:N addresses
-- users 1:N products (seller_id)
-- users 1:N orders (buyer)
-- orders 1:N order_items
-- products 1:N order_items
-- users 1:N wallet_transactions
-- logistics_jobs is independent catalogue
-- logistics_routes N:1 logistics_jobs
-- logistics_routes N:1 users (driver)
-- users 1:N ratings (reviewer and reviewee)
-- orders 1:N ratings

-- users table (auth users extended profile)
create table if not exists users (
  id uuid primary key,
  full_name text not null,
  email text not null unique,
  phone_number text,
  profile_image text,
  address text,
  role text not null default 'Buyer',
  wallet_balance numeric not null default 0,
  favorite_product_ids text[],
  is_verified boolean not null default false,
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now()
);

-- addresses for users
create table if not exists addresses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references users(id) on delete cascade,
  type text,
  address text not null,
  latitude numeric,
  longitude numeric,
  is_default boolean not null default false,
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now()
);

-- products table
create table if not exists products (
  id text primary key,
  name text not null,
  category text not null,
  description text,
  price numeric not null,
  unit text not null,
  seller_id uuid not null references users(id) on delete cascade,
  seller_name text not null,
  location text,
  stock text,
  status text not null default 'ACTIVE',
  image text,
  is_favorite boolean not null default false,
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now()
);

-- orders table
create table if not exists orders (
  id text primary key,
  user_id uuid not null references users(id) on delete cascade,
  date timestamp with time zone not null,
  subtotal numeric not null,
  shipping_fee numeric not null,
  tax numeric not null,
  total_amount numeric not null,
  status text not null default 'pending',
  delivery_address text,
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now()
);

-- order_items table
create table if not exists order_items (
  id uuid primary key default gen_random_uuid(),
  order_id text not null references orders(id) on delete cascade,
  product_id text references products(id) on delete set null,
  product_name text not null,
  product_image text,
  seller_name text not null,
  quantity int not null,
  price_at_purchase numeric not null,
  created_at timestamp with time zone not null default now()
);

-- wallet_transactions table
create table if not exists wallet_transactions (
  id text primary key,
  user_id uuid not null references users(id) on delete cascade,
  title text not null,
  product_name text,
  product_image text,
  amount numeric not null,
  is_credit boolean not null,
  date timestamp with time zone not null,
  status text not null,
  source text,
  created_at timestamp with time zone not null default now()
);

-- logistics_jobs table
create table if not exists logistics_jobs (
  id text primary key,
  title text not null,
  pickup text not null,
  dropoff text not null,
  price numeric not null,
  distance_km numeric,
  weight_kg numeric,
  duration_hours numeric,
  tag text,
  location_lat numeric,
  location_lng numeric,
  status text not null default 'available',
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now()
);

-- logistics_routes table
create table if not exists logistics_routes (
  id text primary key,
  job_id text not null references logistics_jobs(id) on delete cascade,
  driver_id uuid not null references users(id) on delete cascade,
  pickup_time timestamp with time zone,
  dropoff_time timestamp with time zone,
  status text not null default 'in_progress',
  current_lat numeric,
  current_lng numeric,
  eta text,
  created_at timestamp with time zone not null default now()
);

-- ratings table
create table if not exists ratings (
  id text primary key,
  reviewer_id uuid not null references users(id) on delete cascade,
  reviewee_id uuid not null references users(id) on delete cascade,
  order_id text references orders(id) on delete set null,
  rating int not null check (rating >= 1 and rating <= 5),
  comment text,
  created_at timestamp with time zone not null default now()
);

-- triggers to maintain updated_at timestamps
create function update_updated_at() returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger users_updated_at
  before update on users
  for each row execute procedure update_updated_at();

create trigger addresses_updated_at
  before update on addresses
  for each row execute procedure update_updated_at();

create trigger products_updated_at
  before update on products
  for each row execute procedure update_updated_at();

create trigger orders_updated_at
  before update on orders
  for each row execute procedure update_updated_at();

create trigger logistics_jobs_updated_at
  before update on logistics_jobs
  for each row execute procedure update_updated_at();
