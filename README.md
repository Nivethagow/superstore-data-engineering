# 🛒 Superstore Retail Data: From Entity Modeling to Business Intelligence


> Author: Nivetha Ramasamy 


---

## 📌 Project Overview

This project transforms four years of Superstore retail transaction data into a fully normalized relational database and data warehouse, culminating in actionable business intelligence insights via Power BI.

The pipeline covers raw CSV ingestion via SSIS, a normalized OLTP database (3NF) in MySQL, two star schema data warehouses modeled in MySQL Workbench, and a Power BI dashboard for visualization.

**Source Dataset:** [Kaggle Superstore Sales Dataset (2019–2022)](https://www.kaggle.com/datasets/timchant/supstore-dataset-2019-2022?resource=download)

---

## 🗂️ Repository Structure

```
superstore-retail-bi/
│
├── README.md
│
├── 01_business_rules/
│   └── business_rules.md
│
├── 02_entity_relationship/
│   ├── er_diagram.png                        ← screenshot from MySQL Workbench
│   └── er_model_notes.md
│
├── 03_database_design/
│   ├── schema/
│   │   └── create_tables.sql                 ← full OLTP DDL (11 tables)
│   ├── etl/
│   │   ├── Table_Load_Package.dtsx           ← SSIS package (10 data flow tasks)
│   │   ├── insert_data.sql                   ← equivalent SQL reference
│   │   └── ssis_pipeline_notes.md
│   └── normalization_notes.md
│
├── 04_data_warehouse/
│   ├── Star_Schema_sales.mwb                 ← MySQL Workbench model (fact_sales)
│   ├── Star_Schema_shipping.mwb              ← MySQL Workbench model (fact_shipping)
│   ├── fact_sales.sql
│   ├── fact_shipping.sql
│   └── dimensions/
│       └── all_dimensions.sql
│
├── 05_business_insights/
│   ├── insights_summary.md
│   ├── superstore_powerbi.pbix               ← Power BI dashboard file
│   └── charts/
│       ├── sales_by_category.png             ← screenshot from Power BI
│       ├── sales_by_segment.png
│       └── sales_by_state.png
│
└── 06_presentation/
    └── Presentation.pdf
```

---

## 🏗️ Project Architecture

```
Raw CSV (Kaggle Superstore 2019–2022)
      ↓
SSIS ETL Pipeline  [Table_Load_Package.dtsx]
  ├── Extract:    Flat File Source → stg_superstore_data (staging table)
  ├── Transform:  10 Data Flow Tasks — type casting, lookups, key mapping
  └── Load:       Normalized OLTP tables via ODBC (MySQL_SSIS_64_Uni_1)
      ↓
Normalized MySQL Database (3NF) — 10 tables, ~9,986 orders, ~1,849 products
      ↓
Data Warehouse — 2 Star Schemas (MySQL Workbench)
  ├── fact_sales    + 5 dimensions
  └── fact_shipping + 4 dimensions
      ↓
Power BI Dashboard [superstore_powerbi.pbix]
```

---

## 📐 Business Rules

- A **customer** can place multiple orders; each order belongs to exactly one customer.
- Each **order** contains one or more line items with quantity, discount, sales, and profit.
- **Quantity** > 0 and **sales** must always be positive; **discount** must be 0–100%.
- **Ship date** must be ≥ order date.
- Each customer belongs to exactly one **segment**: Consumer, Corporate, or Home Office.
- **Geographic hierarchy:** Customer → City → State → Region (4 regions total).
- Each **product** belongs to one subcategory → category and one manufacturer.

See [`01_business_rules/business_rules.md`](01_business_rules/business_rules.md) for the complete list.

---

## 🗃️ Database Design (OLTP)

### Tables & Row Counts

| Table | Rows | Description |
|---|---|---|
| `region` | 4 | Central, East, South, West |
| `state` | 49 | US states |
| `city` | 632 | Cities with zip codes |
| `category` | 3 | Technology, Furniture, Office Supplies |
| `subcategory` | 17 | e.g. Chairs, Phones, Binders |
| `manufactory` | 182 | Manufacturers/brands |
| `product` | 1,849 | Unique products |
| `customer` | 4,910 | Unique customers |
| `orders` | 9,986 | Orders (2019–2022) |
| `orders_detail` | ~9,986 | Line items with sales metrics |
| `stg_superstore_data` | 9,986 | Raw staging table (SSIS target) |

### Normalization: 3NF
Transitive dependencies eliminated through full decomposition of geographic and product hierarchies. See [`03_database_design/normalization_notes.md`](03_database_design/normalization_notes.md).

---

## 🏭 Data Warehouse (Star Schema)

### fact_sales
Measures: `quantity_sold`, `sales_amount`, `discount_percent`, `profit`, `profit_margin`, `unit_price`, `discount_amount`  
Dimensions: `dim_customer`, `dim_date`, `dim_region`, `dim_product`, `dim_order`

### fact_shipping
Measures: `shipping_days`, `delayed_flag`, `total_items_shipped`  
Dimensions: `dim_customer`, `dim_date`, `dim_manufacturer`, `dim_order`

Schema files: [`Star_Schema_sales.mwb`](04_data_warehouse/Star_Schema_sales.mwb) · [`Star_Schema_shipping.mwb`](04_data_warehouse/Star_Schema_shipping.mwb)

---

## 📊 Business Insights

### Sales by Category
**Technology** leads all categories, followed by Furniture and Office Supplies.

### Sales by Customer Segment
| Segment | Sales | Share |
|---|---|---|
| Consumer | $1.16M | 50.56% |
| Corporate | $0.71M | 30.74% |
| Home Office | $0.43M | 18.70% |

### Sales by State
**California** tops all states at ~$2M. **Arizona** records the lowest sales among tracked states.

See [`05_business_insights/insights_summary.md`](05_business_insights/insights_summary.md) for full analysis.  
Dashboard: [`superstore_powerbi.pbix`](05_business_insights/superstore_powerbi.pbix)

---

## 🔮 Future Work

- Deeper sub-category and profit margin analysis
- Live sales feed integration via API for real-time dashboards
- Customer churn prediction using purchase frequency, recency, and loyalty tier

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| MySQL (InnoDB, utf8mb4) | Relational OLTP database |
| MySQL Workbench | ER modeling & data warehouse schema design (.mwb) |
| SSIS (SQL Server Integration Services) | ETL pipeline — CSV ingest, transform, load |
| Power BI | Business intelligence dashboards (.pbix) |
| Kaggle CSV | Source data (2019–2022) |

---

