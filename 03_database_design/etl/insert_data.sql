-- ============================================================
-- Superstore Retail Database - ETL: INSERT FROM STAGING
-- ============================================================
-- ETL pipeline built with SSIS (SQL Server Integration Services)
-- These SQL statements represent the load phase executed within SSIS data flows.
-- Assumes staging table: stg_superstore_data

-- 1. Region
INSERT INTO Region (region)
SELECT DISTINCT region FROM stg_superstore_data;

-- 2. State
INSERT INTO State (state, region_id)
SELECT DISTINCT s.state, r.region_id
FROM stg_superstore_data s
JOIN Region r ON s.region = r.region;

-- 3. City
INSERT INTO City (city, state, zip)
SELECT DISTINCT s.city, s.state, s.postal_code
FROM stg_superstore_data s;

-- 4. Category
INSERT INTO Category (category)
SELECT DISTINCT category FROM stg_superstore_data;

-- 5. Subcategory
INSERT INTO Subcategory (subcategory, category_id)
SELECT DISTINCT s.sub_category, c.category_id
FROM stg_superstore_data s
JOIN Category c ON s.category = c.category;

-- 6. Manufactory
INSERT INTO Manufactory (manufactory)
SELECT DISTINCT manufactory FROM stg_superstore_data;

-- 7. Product
INSERT INTO Product (product_name, subcategory_id, manufactory_id)
SELECT DISTINCT
    s.product_name,
    subcat.subcategory_id,
    m.manufactory_id
FROM stg_superstore_data s
JOIN Subcategory subcat ON s.sub_category = subcat.subcategory
JOIN Manufactory m ON s.manufactory = m.manufactory;

-- 8. Customer
INSERT INTO Customer (customer_name, segment, City_city_id)
SELECT DISTINCT
    s.customer_name,
    s.segment,
    c.city_id
FROM stg_superstore_data s
JOIN City c ON s.city = c.city AND s.state = c.state;

-- 9. Orders
INSERT INTO Orders (order_id, order_date, ship_date, customer_id, city)
SELECT DISTINCT
    s.order_id,
    s.order_date,
    s.ship_date,
    cust.customer_id,
    s.city
FROM stg_superstore_data s
JOIN Customer cust ON s.customer_name = cust.customer_name;

-- 10. Orders_detail
INSERT INTO Orders_detail (customer_id, product_id, quantity, discount, sales, profit, profit_margin)
SELECT
    cust.customer_id,
    p.product_id,
    s.quantity,
    s.discount,
    s.sales,
    s.profit,
    CASE WHEN s.sales > 0 THEN s.profit / s.sales ELSE 0 END AS profit_margin
FROM stg_superstore_data s
JOIN Customer cust ON s.customer_name = cust.customer_name
JOIN Product p ON s.product_name = p.product_name;
