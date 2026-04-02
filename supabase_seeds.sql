-- Supabase seed data for Agrolync mock dataset
-- Run after supabase_schema.sql setup

-- 1) Create sample user
insert into users (id, full_name, email, phone_number, profile_image, address, role, wallet_balance, favorite_product_ids, is_verified)
values (
  '5e5f778f-1b8c-4d96-8b2f-a9fbbb110001',
  'Ange Murielle',
  'murielle@agrolync.cm',
  '+237 600 000 000',
  'assets/images/user_avatar.png',
  'Douala, Cameroon',
  'Buyer',
  250000,
  array['p3','p6','p9'],
  true
);

-- 2) Addresses for this user
insert into addresses (id, user_id, type, address, latitude, longitude, is_default)
values
  ('2390700b-9bc6-4f2b-8c96-fd1da8d10001', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110001', 'Home', '123 Green Valley, Molyko, Buea', 4.1560, 9.2435, true),
  ('2390700b-9bc6-4f2b-8c96-fd1da8d10002', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110001', 'Work', 'Jongo Hub, Opposite UB, Buea', 4.1511, 9.2714, false);

-- 3) Seed Products
insert into products (id, name, category, description, price, unit, seller_id, seller_name, location, status, image)
values
  ('p1', 'White Maize', 'Grains', 'Dried white maize, perfect for flour or poultry feed. Grade A quality.', 25000, 'Bag (50kg)', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110001', 'Agro-North Group', 'Garoua, North Region', 'ACTIVE', 'assets/images/white maize.jpg'),
  ('p2', 'Yellow Maize', 'Grains', 'Premium yellow maize for animal feed and human consumption.', 28000, 'Bag (50kg)', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110002', 'Farmers Cooperative', 'Bamenda, North West', 'ACTIVE', 'assets/images/maize.jpg'),
  ('p3', 'Rice Paddy', 'Grains', 'High-quality local rice paddy, ready for milling.', 35000, 'Bag (100kg)', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110003', 'Rice Farmers Union', 'Yagoua, Far North', 'ACTIVE', 'assets/images/rice paddy.jpg'),
  ('p4', 'Millet Grains', 'Grains', 'Traditional millet grains, rich in nutrients and gluten-free.', 22000, 'Bag (25kg)', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110004', 'Sahel Grains Ltd', 'Maroua, Far North', 'ACTIVE', 'assets/images/millet grain.jpg'),
  ('p5', 'Fresh Tomatoes', 'Vegetables', 'High-quality organic tomatoes sourced directly from Foumbot. Harvested within 24 hours.', 5000, 'Basket', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110005', 'Farmer Moussa', 'Foumbot, West Region', 'ACTIVE', 'assets/images/tomato.jpg'),
  ('p6', 'Red Onions', 'Vegetables', 'Sharp and fresh red onions from the Far North. Long shelf life.', 12000, 'Bag', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110006', 'Mamma Sali', 'Maroua, Far North', 'ACTIVE', 'assets/images/onions.jpg'),
  ('p7', 'Bell Peppers', 'Vegetables', 'Colorful bell peppers, perfect for cooking and salads.', 8000, 'Basket', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110007', 'Green Valley Farms', 'Buea, South West', 'ACTIVE', 'assets/images/pepperseed.jpg'),
  ('p8', 'Fresh Lettuce', 'Vegetables', 'Crisp, fresh lettuce leaves harvested daily.', 3000, 'Bundle', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110008', 'Urban Gardens', 'Yaounde, Center', 'ACTIVE', 'assets/images/fresh lettuce.jpg'),
  ('p9', 'Export Bananas', 'Fruits', 'Sweet Cavendish bananas, ready for local consumption or shipping.', 3500, 'Bunch', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110009', 'CDC South', 'Tiko, South West', 'ACTIVE', 'assets/images/banana.jpg'),
  ('p10', 'Pineapples', 'Fruits', 'Juicy, sweet pineapples from the coastal regions.', 6000, 'Piece', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110010', 'Coastal Fruits Ltd', 'Limbe, South West', 'ACTIVE', 'assets/images/pineapple.jpg');

-- 4) Seed Logistics Jobs
insert into logistics_jobs (id, title, pickup, dropoff, price, distance_km, weight_kg, duration_hours, tag, location_lat, location_lng)
values
  ('job1', 'Potato Transport - 15 Tons', 'Bafoussam Market', 'Douala Port', 250000, 265, 15000, 6.0, 'EXPRESS', 5.4777, 10.4176),
  ('job2', 'Coffee Beans Shipment', 'Bamenda Coffee Hub', 'Douala Export Port', 280000, 310, 16000, 6.5, 'PRIORITY', 5.9595, 10.1634),
  ('job3', 'Packaged Goods - Mixed', 'Bertoua Distribution Center', 'Douala Warehouse', 215000, 230, 9800, 4.5, 'STANDARD', 4.5773, 13.6848),
  ('job4', 'Cocoa Bulk Transport', 'Kumba Processing Plant', 'Yaoundé Commodity Exchange', 295000, 380, 18500, 7.2, 'HEAVY LOAD', 4.6363, 9.4469),
  ('job5', 'Fresh Produce Delivery', 'Ebolowa Farm Depot', 'Yaoundé Central Market', 190000, 185, 7200, 4.0, 'PERISHABLE', 2.9000, 11.1500);

-- 5) Create sample wallet transactions for user
insert into wallet_transactions (id, user_id, title, product_name, product_image, amount, is_credit, date, status, source)
values
  ('tx1', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110001', 'Purchase: Fertilizer X10', 'Fertilizer X10', 'assets/images/sample_product.jpg', -240000, false, now() - interval '1 day 3 hours', 'SUCCESS', 'Purchase'),
  ('tx2', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110001', 'Wallet Top-up', null, null, 1500000, true, now() - interval '2 days 5 hours', 'SUCCESS', 'Top-up'),
  ('tx3', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110001', 'Logistics Fee', null, null, -15000, false, now() - interval '3 days 2 hours', 'SUCCESS', 'Fee');

-- 6) Optional: seed a sample order and order items
insert into orders (id, user_id, date, subtotal, shipping_fee, tax, total_amount, status, delivery_address)
values ('order1', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110001', now() - interval '2 days', 58000, 3000, 2900, 63900, 'delivered', '123 Green Valley, Molyko, Buea');

insert into order_items (order_id, product_id, product_name, product_image, seller_name, quantity, price_at_purchase)
values
  ('order1', 'p1', 'White Maize', 'assets/images/white maize.jpg', 'Agro-North Group', 2, 25000),
  ('order1', 'p5', 'Fresh Tomatoes', 'assets/images/tomato.jpg', 'Farmer Moussa', 1, 5000);

-- 7) Optional: seed a rating record
insert into ratings (id, reviewer_id, reviewee_id, order_id, rating, comment)
values ('rating1', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110001', '5e5f778f-1b8c-4d96-8b2f-a9fbbb110002', 'order1', 5, 'Smooth buying experience!');
