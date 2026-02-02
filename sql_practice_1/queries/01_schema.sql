BEGIN;

DROP TABLE IF EXISTS returns;
DROP TABLE IF EXISTS shipments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id BIGSERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT UNIQUE,
    city TEXT NOT NULL,
    signup_date DATE NOT NULL
);

CREATE TABLE products (
  product_id    BIGSERIAL PRIMARY KEY,
  category      TEXT NOT NULL,
  brand         TEXT NOT NULL,
  product_name  TEXT NOT NULL,
  price         NUMERIC(10,2) NOT NULL CHECK (price >= 0)
);

-- Orders
CREATE TABLE orders (
  order_id        BIGSERIAL PRIMARY KEY,
  customer_id     BIGINT NOT NULL REFERENCES customers(customer_id) ON DELETE RESTRICT,
  order_date      TIMESTAMP NOT NULL,
  status          TEXT NOT NULL CHECK (status IN ('placed','paid','shipped','delivered','cancelled','returned')),
  payment_method  TEXT NOT NULL CHECK (payment_method IN ('card','bank_transfer','cash_on_delivery','wallet')),
  total_amount    NUMERIC(12,2) NOT NULL CHECK (total_amount >= 0)
);

-- Order Items (line items)
CREATE TABLE order_items (
  order_id     BIGINT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
  product_id   BIGINT NOT NULL REFERENCES products(product_id) ON DELETE RESTRICT,
  quantity     INT NOT NULL CHECK (quantity > 0),
  unit_price   NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
  PRIMARY KEY (order_id, product_id)
);

-- Shipments (1 shipment per order for simplicity)
CREATE TABLE shipments (
  shipment_id    BIGSERIAL PRIMARY KEY,
  order_id       BIGINT NOT NULL UNIQUE REFERENCES orders(order_id) ON DELETE CASCADE,
  carrier        TEXT NOT NULL CHECK (carrier IN ('yurtici','aras','mng','ptt','surat')),
  shipped_at     TIMESTAMP NOT NULL,
  delivered_at   TIMESTAMP,
  shipping_fee   NUMERIC(10,2) NOT NULL CHECK (shipping_fee >= 0),
  CHECK (delivered_at IS NULL OR delivered_at >= shipped_at)
);

-- Returns (0 or 1 return per order for simplicity)
CREATE TABLE returns (
  return_id      BIGSERIAL PRIMARY KEY,
  order_id       BIGINT NOT NULL UNIQUE REFERENCES orders(order_id) ON DELETE CASCADE,
  return_date    DATE NOT NULL,
  reason         TEXT NOT NULL CHECK (reason IN ('damaged','late_delivery','wrong_item','changed_mind','size_issue','other')),
  refund_amount  NUMERIC(12,2) NOT NULL CHECK (refund_amount >= 0)
);

-- Helpful indexes for analytics
CREATE INDEX idx_orders_customer_date ON orders(customer_id, order_date);
CREATE INDEX idx_orders_status_date   ON orders(status, order_date);
CREATE INDEX idx_products_category    ON products(category);
CREATE INDEX idx_shipments_carrier    ON shipments(carrier);
CREATE INDEX idx_returns_reason       ON returns(reason);

COMMIT;