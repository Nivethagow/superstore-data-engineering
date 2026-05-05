# Normalization Notes

## Goal: Third Normal Form (3NF)

The Superstore database was designed to achieve 3NF to eliminate redundancy and ensure data integrity.

## Normal Form Definitions

| Form | Requirement |
|---|---|
| 1NF | All columns are atomic; no repeating groups |
| 2NF | 1NF + no partial dependencies on composite keys |
| 3NF | 2NF + no transitive dependencies |

## Key Normalization Decisions

### Geographic Hierarchy Decomposition

**Before normalization (flat):**
```
Customer(customer_id, name, city, state, region, zip)
```
Here, `region` depends on `state`, not on `customer_id` — a transitive dependency.

**After normalization (3NF):**
```
Customer(customer_id, name, City_city_id)
City(city_id, city, state, zip)
State(state, region_id)
Region(region_id, region)
```

Each table holds only attributes that depend on its primary key.

### Product Category Hierarchy

**Before:**
```
Product(product_id, name, subcategory, category, manufacturer)
```
`category` depends on `subcategory`, not directly on `product_id`.

**After:**
```
Product(product_id, name, subcategory_id, manufactory_id)
Subcategory(subcategory_id, subcategory, category_id)
Category(category_id, category)
Manufactory(manufactory_id, manufactory)
```

### Order Details

Sales metrics (sales, profit, discount, quantity) are stored in `Orders_detail`, not in `Orders`, because they vary per line item, not per order.

## Benefits

- No duplicate state/region data per customer row
- No duplicate category data per product row
- Easy to update region names or category labels in one place
- Clean foreign key constraints enforce referential integrity throughout
