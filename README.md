# 🛒 Superstore Retail Data: From Entity Modeling to Business Intelligence


> Author Nivetha Ramasamy  


---

## 📌 Project Overview

This project transforms four years of Superstore retail transaction data into a fully normalized relational database and data warehouse, culminating in actionable business intelligence insights. The pipeline covers everything from raw CSV ingestion to BI dashboards.

**Source Dataset:** [Kaggle Superstore Sales Dataset (2019–2022)](https://www.kaggle.com/datasets/timchant/supstore-dataset-2019-2022?resource=download)

---

## 🗂️ Repository Structure

```
superstore-retail-bi/
│
├── README.md
│
├── 01_business_rules/
│   └── business_rules.md          # Defined rules governing the data model
│
├── 02_entity_relationship/
│   ├── er_diagram.png             # ER diagram screenshot
│   └── er_model_notes.md          # Entity & relationship descriptions
│
├── 03_database_design/
│   ├── schema/
│   │   ├── create_tables.sql      # DDL: CREATE TABLE statements
│   │   └── constraints.sql        # Foreign keys, checks, constraints
│   ├── etl/
│   │   └── insert_data.sql        # INSERT INTO / SELECT FROM staging
│   └── normalization_notes.md     # 3NF walkthrough
│
├── 04_data_warehouse/
│   ├── dw_schema.png              # Data warehouse diagram screenshot
│   ├── fact_sales.sql             # Fact table: fact_sales
│   ├── fact_shipping.sql          # Fact table: fact_shipping
│   └── dimensions/
│       ├── dim_customer.sql
│       ├── dim_product.sql
│       ├── dim_date.sql
│       ├── dim_region.sql
│       ├── dim_order.sql
│       └── dim_manufacturer.sql
│
├── 05_business_insights/
│   ├── insights_summary.md        # Written summary of all findings
│   └── charts/
│       ├── sales_by_category.png
│       ├── sales_by_segment.png
│       └── sales_by_state.png
│
└── 06_presentation/
    └── GBA6220-Final-Presentation.pdf
```

---

## 🏗️ Project Architecture

```
Raw CSV (Kaggle)
      ↓
SSIS ETL Pipeline
  ├── Extract:   Read from CSV source
  ├── Transform: Clean, map, and validate data
  └── Load:      Populate staging → normalized tables → data warehouse
      ↓
Normalized OLTP Database (3NF)
      ↓
Data Warehouse (Star Schema)
      ↓
Business Intelligence Dashboards
```

---

## 📐 Business Rules

Key rules that govern the data model:

- A **customer** can place multiple orders; each order belongs to exactly one customer.
- Each **order** contains one or more line items (order details) with quantity, discount, sales, and profit.
- Each **product** belongs to one subcategory → category hierarchy and is linked to one manufacturer.
- **Geographic hierarchy:** Customer → City → State → Region.
- Quantity must be > 0; sales must be positive; discount must be 0–100%.
- Ship date must be ≥ order date.
- Each customer belongs to exactly one segment: **Consumer**, **Corporate**, or **Home Office**.

See [`01_business_rules/business_rules.md`](01_business_rules/business_rules.md) for the complete list.

---

## 🗃️ Database Design

### Entities
| Entity | Description |
|---|---|
| `Customer` | Buyer info, segment, city reference |
| `Orders` | Order date, ship date, customer link |
| `Orders_detail` | Line-item sales, profit, discount, quantity |
| `Product` | Product name, subcategory, manufacturer |
| `Subcategory` | Product subcategory → category link |
| `Category` | Top-level product category |
| `Manufactory` | Manufacturer name |
| `City` | City → state link |
| `State` | State → region link |
| `Region` | Top-level geographic region |

### Normalization
The database achieves **Third Normal Form (3NF)**:
- All non-key attributes depend only on the primary key.
- No transitive dependencies.
- Geographic hierarchy is fully decomposed (no repeated state/region per customer row).

---

## 🏭 Data Warehouse

Built as a **star schema** with two fact tables:

| Fact Table | Measures |
|---|---|
| `fact_sales` | quantity_sold, sales_amount, discount_percent, profit, profit_margin, unit_price, discount_amount |
| `fact_shipping` | shipping_days, delayed_flag, total_items_shipped |

**Dimension tables:** `dim_customer`, `dim_product`, `dim_date`, `dim_region`, `dim_order`, `dim_manufacturer`

---

## 📊 Business Insights

### 1. Sales by Category
**Technology** is the top-selling category, outperforming both Furniture and Office Supplies.

### 2. Sales by Customer Segment
- **Consumer** segment leads with **$1.16M (50.56%)** of total sales.
- **Corporate** accounts for $0.71M (30.74%).
- **Home Office** is the smallest segment at $0.43M (18.7%).

### 3. Sales by State
- **California** dominates at nearly **$2M** in sales.
- **Arizona** contributes the least among the top states tracked.

---

## 🔮 Future Work

- Deeper dashboard visualizations (sub-category drilldowns, profit margin trends).
- Live sales feed integration via APIs for real-time updates.
- Customer churn prediction model using purchase frequency, inactivity periods, and loyalty tiers.

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| MySQL | Relational database & data warehouse |
| SQL (DDL/DML) | Schema creation & querying |
| SSIS (SQL Server Integration Services) | ETL pipeline — data extraction, transformation, and loading |
| Kaggle CSV | Source data |
| BI Tool (/Power BI) | Dashboards & visualizations |

---



