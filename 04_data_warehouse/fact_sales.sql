 ============================================================
-- Data Warehouse: fact_sales
-- Source: Star_Schema_sales.mwb
-- ============================================================

CREATE TABLE fact_sales (
  sales_id        INT NOT NULL,
  customer_id     INT NOT NULL,
  date_id         INT NOT NULL,
  region_id       INT NOT NULL,
  product_id      INT NOT NULL,
  order_id        INT NOT NULL,
  quantity_sold   INT,
  sales_amount    FLOAT,
  discount_percent FLOAT,
  profit          FLOAT,
  profit_margin   FLOAT,
  unit_price      FLOAT,
  discount_amount FLOAT,
  PRIMARY KEY (sales_id),
  FOREIGN KEY (customer_id)  REFERENCES dim_customer(customer_id),
  FOREIGN KEY (date_id)      REFERENCES dim_date(date_id),
  FOREIGN KEY (region_id)    REFERENCES dim_region(region_id),
  FOREIGN KEY (product_id)   REFERENCES dim_product(product_id),
  FOREIGN KEY (order_id)     REFERENCES dim_order(order_id)
);
