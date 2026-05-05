# Business Rules

This document defines the business rules that govern the Superstore Retail data model.

## Order & Customer Rules

1. A customer can place **multiple orders**, but each order is placed by **exactly one customer**.
2. Each order contains **one or more order details** (line items), capturing quantity, discount, sales, and profit.
3. The **quantity** of products in any order must be **greater than zero**.
4. The corresponding **sales value** must always be **positive**.
5. The **discount** applied to each product must be between **0% and 100%**.
6. Orders must have a **valid order date and ship date**; the ship date must **not be earlier** than the order date.

## Product Rules

7. Each order detail is linked to **one product**; each product is supplied by **one manufacturer**.
8. Products are organized in a **subcategory → category hierarchy**.
9. Each **manufacturer** can manufacture multiple products, but each product must be associated with **exactly one manufacturer**.
10. **Profit** for any product can be negative, zero, or positive (depending on discounts or costs), but **sales value must always remain positive**.

## Customer Segment Rules

11. Each customer belongs to **exactly one segment**: Consumer, Corporate, or Home Office.

## Geographic Rules

12. Each customer resides in a **city**; each city belongs to a **state**; each state maps to a **region**.
13. Each **region** contains multiple states; each state must belong to **exactly one region**.
14. An order is linked to a **city** (shipment location).

## Data Integrity Rules

15. All tables are normalized to **Third Normal Form (3NF)** — no transitive dependencies, no redundant storage of geographic or categorical data.
16. Foreign key constraints enforce referential integrity across all related tables with `ON UPDATE CASCADE ON DELETE CASCADE`.
