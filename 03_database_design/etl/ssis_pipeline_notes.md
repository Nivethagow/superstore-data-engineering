# ETL Pipeline: SSIS Details

## Tool
**SQL Server Integration Services (SSIS)** — package: `Table_Load_Package.dtsx`  
Created by: Nivetha Ramasamy | Connection: `MySQL_SSIS_64_Uni_1` (ODBC, 64-bit Unicode)

## Pipeline Overview

```
Kaggle CSV
    ↓
stg_superstore_data  ← SSIS Flat File Source (all columns ingested as strings)
    ↓                   Load_Timestamp auto-stamped on ingest
SSIS Data Flow Tasks (one per normalized table)
    ↓
Normalized OLTP Tables
```

## Data Flow Tasks (in dependency order)

| Task Name | Destination Table | Notes |
|---|---|---|
| Load Region | `region` | Loaded first — no dependencies |
| Load State | `state` | Depends on region |
| Load City | `city` | Depends on state |
| Load Category | `category` | Loaded first — no dependencies |
| Load Subcategory | `subcategory` | Depends on category |
| Load Manufactory | `manufactory` | No dependencies |
| Load Product | `product` | Depends on subcategory + manufactory |
| Load Customer | `customer` | Depends on city |
| Load Order | `orders` | Depends on customer |
| Load Order detail | `orders_detail` | Depends on orders + product |

## Precedence Constraints
Tasks are connected with **Success** precedence constraints (green arrows in SSIS) to enforce load order. No task begins until its upstream dependency completes successfully.

## Connection
- **DSN:** `MySQL_SSIS_64_Uni_1`
- **Driver:** ODBC 64-bit Unicode
- **Source DB:** MySQL (InnoDB, utf8mb4)

## Files
- `Table_Load_Package.dtsx` — the full SSIS package (open in Visual Studio with SSIS extension or SQL Server Data Tools)
