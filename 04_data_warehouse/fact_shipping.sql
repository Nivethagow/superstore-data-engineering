-- ============================================================
-- Data Warehouse: fact_shipping
-- Source: Star_Schema_shipping.mwb
-- ============================================================

CREATE TABLE fact_shipping (
  shipping_id         INT NOT NULL,
  customer_id         INT NOT NULL,
  date_id             INT NOT NULL,
  manufactory_id      INT NOT NULL,
  order_id            INT NOT NULL,
  shipping_days       INT,
  delayed_flag        TINYINT(1),
  total_items_shipped INT,
  PRIMARY KEY (shipping_id),
  FOREIGN KEY (customer_id)    REFERENCES dim_customer(customer_id),
  FOREIGN KEY (date_id)        REFERENCES dim_date(date_id),
  FOREIGN KEY (manufactory_id) REFERENCES dim_manufacturer(manufactory_id),
  FOREIGN KEY (order_id)       REFERENCES dim_order(order_id)
);
