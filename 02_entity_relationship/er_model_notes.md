# Entity Relationship Model

## Entities & Attributes

| Entity | Primary Key | Key Attributes |
|---|---|---|
| `Customer` | customer_id (INT) | customer_name, segment, City_city_id |
| `Orders` | order_id (VARCHAR 30) | order_date, ship_date, customer_id, city |
| `Orders_detail` | orders_detail_id (INT) | customer_id, product_id, quantity, discount, sales, profit, profit_margin |
| `Product` | product_id (INT) | product_name, subcategory_id, manufactory_id |
| `Subcategory` | subcategory_id (INT) | subcategory, category_id |
| `Category` | category_id (INT) | category |
| `Manufactory` | manufactory_id (INT) | manufactory |
| `City` | city_id (INT) | city, state, zip |
| `State` | state (VARCHAR 30) | region_id |
| `Region` | region_id (INT) | region |

## Relationships

| Relationship | Cardinality | Description |
|---|---|---|
| Customer → Orders | 1 to Many | One customer can place many orders |
| Orders → Orders_detail | 1 to Many | One order contains many line items |
| Orders_detail → Product | Many to 1 | Many line items reference one product |
| Product → Subcategory | Many to 1 | Many products in one subcategory |
| Subcategory → Category | Many to 1 | Many subcategories under one category |
| Product → Manufactory | Many to 1 | Many products from one manufacturer |
| Customer → City | Many to 1 | Many customers in one city |
| City → State | Many to 1 | Many cities in one state |
| State → Region | Many to 1 | Many states in one region |

## ER Diagram

See `ERD.png` in this folder for the full visual diagram.
