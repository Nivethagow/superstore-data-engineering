-- ============================================================
-- Data Warehouse: Dimension Tables
-- Source: Star_Schema_sales.mwb / Star_Schema_shipping.mwb
-- ============================================================

CREATE TABLE dim_customer (
  customer_id INT NOT NULL,
  first_name  VARCHAR(30),
  last_name   VARCHAR(30),
  customer_type VARCHAR(30),
  PRIMARY KEY (customer_id)
);

CREATE TABLE dim_product (
  product_id   INT NOT NULL,
  product_name VARCHAR(30),
  category     VARCHAR(30),
  subcategory  VARCHAR(30),
  PRIMARY KEY (product_id)
);

CREATE TABLE dim_date (
  date_id    INT NOT NULL,
  day        INT,
  day_name   VARCHAR(30),
  month      INT,
  month_name VARCHAR(30),
  quarter    INT,
  year       INT,
  is_weekend TINYINT(1),
  PRIMARY KEY (date_id)
);

CREATE TABLE dim_region (
  region_id INT NOT NULL,
  region    VARCHAR(30),
  zip       INT,
  city      VARCHAR(30),
  state     VARCHAR(30),
  PRIMARY KEY (region_id)
);

CREATE TABLE dim_order (
  order_id   INT NOT NULL,
  order_date DATE,
  ship_date  DATE,
  PRIMARY KEY (order_id)
);

CREATE TABLE dim_manufacturer (
  manufactory_id INT NOT NULL,
  manufactory    VARCHAR(30),
  active_status  VARCHAR(10),
  PRIMARY KEY (manufactory_id)
);
