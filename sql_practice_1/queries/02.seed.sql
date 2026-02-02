-- 02_seed.sql (PostgreSQL)
-- Seed data: enough variety for joins, windows, cohorts, shipping delays, returns.

BEGIN;

-- Customers (12)
INSERT INTO customers (customer_id, full_name, email, city, signup_date) VALUES
  (1,  'Halil Kaya',      'halil.kaya@example.com',      'Mersin',     '2025-10-02'),
  (2,  'Elif Demir',      'elif.demir@example.com',      'Istanbul',   '2025-10-15'),
  (3,  'Mert Yilmaz',     'mert.yilmaz@example.com',     'Ankara',     '2025-11-05'),
  (4,  'Zeynep Aydin',    'zeynep.aydin@example.com',    'Izmir',      '2025-11-18'),
  (5,  'Ahmet Sahin',     'ahmet.sahin@example.com',     'Bursa',      '2025-12-01'),
  (6,  'Ayse Koc',        'ayse.koc@example.com',        'Antalya',    '2025-12-12'),
  (7,  'Can Yasar',       'can.yasar@example.com',       'Adana',      '2025-12-20'),
  (8,  'Ece Arslan',      'ece.arslan@example.com',      'Konya',      '2026-01-02'),
  (9,  'Ozan Celik',      'ozan.celik@example.com',      'Gaziantep',  '2026-01-05'),
  (10, 'Selin Yuce',      'selin.yuce@example.com',      'Mersin',     '2026-01-08'),
  (11, 'Burak Aksoy',     'burak.aksoy@example.com',     'Istanbul',   '2026-01-10'),
  (12, 'Derya Gunes',     'derya.gunes@example.com',     'Ankara',     '2026-01-12');

-- Products (15) - mix categories, brands
INSERT INTO products (product_id, category, brand, product_name, price) VALUES
  (1,  'electronics', 'anker',      'PowerBank 10k',         899.90),
  (2,  'electronics', 'logitech',   'Wireless Mouse',        749.90),
  (3,  'electronics', 'xiaomi',     'Smart Band',            999.90),

  (4,  'home',        'ikea',       'Desk Lamp',             499.90),
  (5,  'home',        'philips',    'Air Fryer',            3499.90),
  (6,  'home',        'karaca',     'Coffee Mug Set',        399.90),

  (7,  'fashion',     'defacto',    'Hoodie',                599.90),
  (8,  'fashion',     'mavi',       'Jeans',                 999.90),
  (9,  'fashion',     'nike',       'Running Shoes',        2799.90),

  (10, 'beauty',      'loreal',     'Shampoo',               199.90),
  (11, 'beauty',      'nivea',      'Face Cream',            249.90),
  (12, 'beauty',      'the_ordinary','Niacinamide Serum',    449.90),

  (13, 'grocery',     'torku',      'Chocolate Box',         179.90),
  (14, 'grocery',     'dardanel',   'Tuna Pack',             229.90),
  (15, 'grocery',     'kurukahveci','Turkish Coffee',        159.90);

-- Orders (24) - spread dates, statuses, payment methods, multiple orders per customer
-- total_amount here is just items total (shipping is in shipments table)
INSERT INTO orders (order_id, customer_id, order_date, status, payment_method, total_amount) VALUES
  (1001,  1, '2025-12-28 10:12', 'delivered', 'card',              1649.80),
  (1002,  2, '2025-12-29 19:40', 'delivered', 'wallet',            999.90),
  (1003,  3, '2025-12-31 09:05', 'returned',  'card',             2799.90),
  (1004,  4, '2026-01-01 14:22', 'delivered', 'bank_transfer',    3499.90),
  (1005,  5, '2026-01-02 11:11', 'cancelled', 'card',              599.90),
  (1006,  6, '2026-01-03 16:55', 'delivered', 'cash_on_delivery',  579.70),
  (1007,  7, '2026-01-04 13:30', 'delivered', 'card',             2999.70),
  (1008,  8, '2026-01-05 18:10', 'shipped',   'wallet',           1499.80),
  (1009,  9, '2026-01-06 20:45', 'delivered', 'card',              399.90),
  (1010, 10, '2026-01-07 08:25', 'returned',  'bank_transfer',     499.90),
  (1011, 11, '2026-01-08 12:00', 'delivered', 'card',             2999.70),
  (1012, 12, '2026-01-09 21:15', 'delivered', 'wallet',            629.70),

  (1013,  1, '2026-01-10 10:40', 'delivered', 'card',             1099.80),
  (1014,  2, '2026-01-11 17:05', 'delivered', 'card',              449.90),
  (1015,  3, '2026-01-12 09:50', 'delivered', 'wallet',           3699.80),
  (1016,  4, '2026-01-13 22:10', 'delivered', 'card',             1999.80),
  (1017,  5, '2026-01-15 11:35', 'delivered', 'bank_transfer',    4499.80),
  (1018,  6, '2026-01-16 15:20', 'shipped',   'card',              999.80),
  (1019,  7, '2026-01-18 18:00', 'delivered', 'cash_on_delivery',  159.90),
  (1020,  8, '2026-01-19 09:10', 'delivered', 'wallet',           1299.80),
  (1021,  9, '2026-01-20 13:55', 'delivered', 'card',             5999.60),
  (1022, 10, '2026-01-22 16:45', 'delivered', 'card',              399.80),
  (1023, 11, '2026-01-24 20:30', 'delivered', 'wallet',            539.80),
  (1024, 12, '2026-01-26 10:05', 'placed',    'card',              179.90);

-- Order items (make totals match orders.total_amount)
-- 1001 total 1649.80 = (mouse 749.90*1) + (powerbank 899.90*1)
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
  (1001, 2, 1, 749.90),
  (1001, 1, 1, 899.90),

  -- 1002 total 999.90 = smart band 999.90
  (1002, 3, 1, 999.90),

  -- 1003 total 2799.90 = running shoes 2799.90
  (1003, 9, 1, 2799.90),

  -- 1004 total 3499.90 = air fryer
  (1004, 5, 1, 3499.90),

  -- 1005 cancelled total 599.90 = hoodie
  (1005, 7, 1, 599.90),

  -- 1006 total 579.70 = shampoo(199.90) + face cream(249.90) + coffee(159.90-? no coffee is 159.90 => 199.90+249.90+129.90? not exist)
  -- Let's do: shampoo 199.90 + face cream 249.90 + chocolate 129.90? not exist. Adjust: use coffee mug set 399.90 + shampoo 199.80? no.
  -- We'll set items: shampoo 199.90 + face cream 249.90 + chocolate 179.90 = 629.70 (too high). So change order 1006 to 629.70? But it's 579.70 now.
  -- Fix by using: shampoo 199.90 + face cream 249.90 + turkish coffee 159.90 = 609.70. Still off.
  -- Use: shampoo 199.90 + niacinamide 449.90 = 649.80. Off.
  -- We'll change order 1006 total_amount to 609.70 via UPDATE after items, or set items to match 579.70:
  -- Make: coffee mug set 399.90 + shampoo 179.80? can't.
  -- Easiest: adjust order 1006 to 609.70, and keep items.
  (1006, 10, 1, 199.90),
  (1006, 11, 1, 249.90),
  (1006, 15, 1, 159.90),

  -- 1007 total 2999.70 = hoodie 599.90 + jeans 999.90 + serum 449.90 + tuna 229.90 + chocolate 179.90 + coffee 159.90 + ??? too many.
  -- Let's do: shoes 2799.90 + shampoo 199.80? not.
  -- We'll adjust order 1007 to match items:
  -- Items: jeans 999.90 + shoes 2799.90 = 3799.80. Too high.
  -- Instead: shoes 2799.90 + coffee 159.90 + chocolate 179.90 = 3139.70.
  -- We'll update order 1007 to 3139.70 and use those 3.
  (1007, 9, 1, 2799.90),
  (1007, 15, 1, 159.90),
  (1007, 13, 1, 179.90),

  -- 1008 total 1499.80 = mouse 749.90*2
  (1008, 2, 2, 749.90),

  -- 1009 total 399.90 = mug set
  (1009, 6, 1, 399.90),

  -- 1010 returned total 499.90 = desk lamp
  (1010, 4, 1, 499.90),

  -- 1011 total 2999.70 = jeans 999.90*3
  (1011, 8, 3, 999.90),

  -- 1012 total 629.70 = shampoo 199.90 + face cream 249.90 + coffee 179.90? coffee is 159.90; use chocolate 179.90 => 629.70
  (1012, 10, 1, 199.90),
  (1012, 11, 1, 249.90),
  (1012, 13, 1, 179.90),

  -- 1013 total 1099.80 = serum 449.90 + smart band 999.90? too high. mouse 749.90 + shampoo 199.90 + coffee 159.90 = 1109.70.
  -- We'll do: powerbank 899.90 + face cream 249.90 = 1149.80. close.
  -- We'll set items for exact 1099.80: smart band 999.90 + coffee 99.90? no.
  -- Let's change order 1013 to 1149.80 to fit items.
  (1013, 1, 1, 899.90),
  (1013, 11, 1, 249.90),

  -- 1014 total 449.90 = serum
  (1014, 12, 1, 449.90),

  -- 1015 total 3699.80 = air fryer 3499.90 + coffee 199.90? no. add shampoo 199.90 => 3699.80
  (1015, 5, 1, 3499.90),
  (1015, 10, 1, 199.90),

  -- 1016 total 1999.80 = smart band 999.90*2
  (1016, 3, 2, 999.90),

  -- 1017 total 4499.80 = shoes 2799.90 + air fryer 1699.90? no. powerbank 899.90 + air fryer 3499.90 = 4399.80; add coffee 100? no.
  -- We'll do: air fryer 3499.90 + shoes 2799.90 = 6299.80 too high.
  -- Let's set items: air fryer 3499.90 + powerbank 899.90 + mouse 749.90 = 5149.70.
  -- We'll update order 1017 to 5149.70.
  (1017, 5, 1, 3499.90),
  (1017, 1, 1, 899.90),
  (1017, 2, 1, 749.90),

  -- 1018 total 999.80 = face cream 249.90*4 = 999.60 not. shampoo 199.90*5=999.50.
  -- We'll do: serum 449.90*2 = 899.80 + coffee 100? no.
  -- Change: 999.80 -> 999.70 for coffee(159.90)+mug(399.90)+shampoo(199.90)+facecream(249.90)=1009.60.
  -- We'll set items: powerbank 899.90 + coffee 159.90 = 1059.80 => update order 1018 to 1059.80
  (1018, 1, 1, 899.90),
  (1018, 15, 1, 159.90),

  -- 1019 total 159.90 = turkish coffee
  (1019, 15, 1, 159.90),

  -- 1020 total 1299.80 = shampoo 199.90 + mug set 399.90 + smart band 999.90 = 1599.70 no.
  -- We'll do: smart band 999.90 + shampoo 199.90 + face cream 249.90 = 1449.70.
  -- Update order 1020 to 1449.70.
  (1020, 3, 1, 999.90),
  (1020, 10, 1, 199.90),
  (1020, 11, 1, 249.90),

  -- 1021 total 5999.60 = shoes 2799.90*2 (5599.80) + face cream 249.90*1 (5849.70) + coffee 159.90 (6009.60)
  -- We'll set to 6009.60 and update order 1021.
  (1021, 9, 2, 2799.90),
  (1021, 11, 1, 249.90),
  (1021, 15, 1, 159.90),

  -- 1022 total 399.80 = shampoo 199.90*2
  (1022, 10, 2, 199.90),

  -- 1023 total 539.80 = tuna 229.90 + chocolate 179.90 + coffee 159.90 = 569.70 (off)
  -- We'll do: tuna 229.90 + coffee 159.90 + coffee mug set? 399.90 too high.
  -- Let's set items: face cream 249.90 + serum 449.90 = 699.80. Off.
  -- Use: chocolate 179.90 + tuna 229.90 + turkish coffee 159.90 = 569.70 => update order 1023 to 569.70.
  (1023, 13, 1, 179.90),
  (1023, 14, 1, 229.90),
  (1023, 15, 1, 159.90),

  -- 1024 placed total 179.90 = chocolate
  (1024, 13, 1, 179.90);

-- Fix totals to match items exactly (clean analytics experience)
UPDATE orders SET total_amount = 609.70  WHERE order_id = 1006;
UPDATE orders SET total_amount = 3139.70 WHERE order_id = 1007;
UPDATE orders SET total_amount = 1149.80 WHERE order_id = 1013;
UPDATE orders SET total_amount = 5149.70 WHERE order_id = 1017;
UPDATE orders SET total_amount = 1059.80 WHERE order_id = 1018;
UPDATE orders SET total_amount = 1449.70 WHERE order_id = 1020;
UPDATE orders SET total_amount = 6009.60 WHERE order_id = 1021;
UPDATE orders SET total_amount = 569.70  WHERE order_id = 1023;

-- Shipments (for all shipped/delivered/returned orders; none for cancelled; placed has none)
-- Include some "late deliveries" (e.g., >3 days) across carriers
INSERT INTO shipments (shipment_id, order_id, carrier, shipped_at, delivered_at, shipping_fee) VALUES
  (5001, 1001, 'aras',     '2025-12-28 17:00', '2025-12-30 12:10',  79.90),
  (5002, 1002, 'yurtici',  '2025-12-29 22:00', '2026-01-02 10:00',  89.90), -- late
  (5003, 1003, 'mng',      '2025-12-31 12:00', '2026-01-06 15:30',  69.90), -- late (returned)
  (5004, 1004, 'ptt',      '2026-01-01 18:00', '2026-01-05 09:20',  59.90), -- late
  (5006, 1006, 'surat',    '2026-01-03 20:00', '2026-01-04 16:10',  49.90),
  (5007, 1007, 'aras',     '2026-01-04 18:00', '2026-01-10 11:45',  79.90), -- very late
  (5008, 1008, 'mng',      '2026-01-06 09:00', NULL,                69.90), -- still shipped
  (5009, 1009, 'yurtici',  '2026-01-06 22:00', '2026-01-07 14:00',  89.90),
  (5010, 1010, 'ptt',      '2026-01-07 12:00', '2026-01-11 13:10',  59.90), -- late (returned)
  (5011, 1011, 'aras',     '2026-01-08 18:00', '2026-01-09 10:30',  79.90),
  (5012, 1012, 'surat',    '2026-01-10 09:00', '2026-01-14 17:20',  49.90), -- late
  (5013, 1013, 'yurtici',  '2026-01-10 18:00', '2026-01-12 11:00',  89.90),
  (5014, 1014, 'mng',      '2026-01-11 19:00', '2026-01-13 15:30',  69.90),
  (5015, 1015, 'ptt',      '2026-01-12 12:00', '2026-01-18 16:00',  59.90), -- late
  (5016, 1016, 'aras',     '2026-01-14 09:00', '2026-01-15 10:10',  79.90),
  (5017, 1017, 'yurtici',  '2026-01-15 18:00', '2026-01-21 13:30',  89.90), -- late
  (5018, 1018, 'mng',      '2026-01-16 18:00', NULL,                69.90), -- still shipped
  (5019, 1019, 'surat',    '2026-01-18 20:00', '2026-01-19 11:40',  49.90),
  (5020, 1020, 'aras',     '2026-01-19 12:00', '2026-01-23 09:10',  79.90), -- late
  (5021, 1021, 'ptt',      '2026-01-20 18:00', '2026-01-28 16:00',  59.90), -- very late
  (5022, 1022, 'yurtici',  '2026-01-22 20:00', '2026-01-24 10:00',  89.90),
  (5023, 1023, 'mng',      '2026-01-25 09:00', '2026-01-30 14:20',  69.90); -- late

-- Returns (for returned orders only; refund_amount usually equals items total, sometimes partial)
INSERT INTO returns (return_id, order_id, return_date, reason, refund_amount) VALUES
  (9001, 1003, '2026-01-08', 'size_issue',     2799.90),
  (9002, 1010, '2026-01-13', 'late_delivery',   499.90);

COMMIT;
