# Database-Systems-and-Data-Preparation

Graduate coursework in database systems and analytics-oriented data preparation: relational query design, dimensional modeling, document indexing, integration and cleaning pipelines, and graph query concepts across multiple storage paradigms.

---

## 1. Title and Summary

**Database Systems and Data Preparation (MSDS 420)**  
Northwestern University, M.S. in Data Science (Data Engineering specialization), Winter 2022.

This repository documents coursework spanning the full data lifecycle from schema design and multi-paradigm storage through scripted load/query workflows and pandas-based preparation for downstream analysis. Work is organized across four Jupyter assignments, seven SQL/Cypher scripts, five written PDF deliverables, and one committed SQLite teaching database (`data/sample/SalesCO.db`).

**Course themes**

- Relational database design, normalization, and business-intelligence SQL
- Operational vs. analytical query workloads on relational and warehouse schemas
- Document-oriented retrieval and relevance tuning with Elasticsearch
- Integration, cleaning, imputation, and reshape pipelines for municipal open data
- Property-graph modeling and Cypher query formulation for fraud detection

---

## 2. Concepts and Methods

### Relational databases and schema design

- **Entity-relationship modeling:** conceptual schema design for a business domain (`Entity Relationship Diagram.pdf`)
- **Normalization:** decomposition of relations through functional dependencies and business rules (`Normalization through Business Rules.pdf`)
- **SaleCo teaching schema (SQLite):** vendor/product/customer/invoice DDL, seed data, and practice queries (`sql/rdb/`; committed as `data/sample/SalesCO.db`)
- **Relational SQL on municipal collision data:** load LA traffic CSVs into SQLite via SQLAlchemy (`create_engine`, `to_sql`, `read_sql_query`); `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`, implicit joins, and explicit `JOIN` over `traffic`, `MO_accident`, and `MO_master` (`SQL LA Traffic Data.ipynb`)

### Data warehouse and business intelligence

- **Star-schema dimensional modeling:** ClassicModels warehouse DDL/DML under `sql/warehouse/` (`classicmodels-dw-ddl.sql`, `classicmodels-dw-dml.sql`)
- **Operational vs. analytical SQL:** compare transactional query patterns with aggregation-oriented warehouse queries (`classicmodels-oper-vs-analytical.sql`)
- **Written BI deliverables:** query portfolios for relational and warehouse schemas (`Business Intelligence SQL Queries RDB.pdf`, `Business Intelligence SQL Queries Data Warehouse.pdf`)

### Document-oriented search

- **Elasticsearch indexing and retrieval:** connect to a course index of Chicago food inspection records; construct `bool` and `query_string` queries; paginate results with the scroll API (`Chicago Food Inspections - NoSQL.ipynb`)
- **Query precision experiments:** compare retrieval precision across three query formulations on the same document corpus
- **Geospatial visualization:** map failed inspections with folium `HeatMap` layers derived from search results

### Data preparation and analytics-oriented transforms

- **Integration and cleaning:** ingest LA traffic collision data from [data.lacity.org](https://data.lacity.org/); drop low-information columns; deduplicate records; impute missing ages; coerce numeric types; filter invalid categorical values (`Data Prep & Cleaning.ipynb`)
- **Exploratory analysis:** victim age, sex, and descent distributions on cleaned collision records
- **Hierarchical indexing and reshaping:** `MultiIndex` construction; group and slice multi-level Series/DataFrames; `pivot_table` with custom `aggfunc`, margins, and categorical binning (`Categorical`, `heavyCat`) (`Hierarchical Indexes, Pivot-tables, lambda, map.ipynb`)
- **Functional aggregation:** coefficient-of-variation helper (`coefV`), `lambda`, `map`, and `groupby().agg()` on retail/customer SQLite exercise data (`xyz.db`)

### Graph data and Cypher

- **Property-graph seed data:** fraud-detection graph import script (`sql/graph/fraud-detection.cypher`)
- **Cypher query deliverable:** written query portfolio for graph traversal and pattern matching (`Fraud Detection Cypher Query Language.pdf`)

**Data dependencies:** large municipal CSVs (`Traffic_Collision_Data.csv`, `Chicago_Food_Inspections.csv`), locally built SQLite databases (`LAtraffic.db`, `xyz.db`), and the course Elasticsearch index are referenced in notebooks but not bundled in the repository. See [data/README.md](data/README.md) for acquisition and rebuild instructions.

---

## 3. Stack

| Layer | Tools |
|-------|-------|
| Language | Python 3 |
| Environment | Jupyter Notebook |
| Relational DB | SQLite via SQLAlchemy |
| Document / search | Elasticsearch Python client (`elasticsearch`; bulk API referenced in coursework) |
| Data prep / analysis | pandas, NumPy |
| Visualization | matplotlib, seaborn, folium (HeatMap plugin) |
| Utilities | `tabulate`, `sqlite3`, `collections.defaultdict` |
| Written deliverables (PDF) | ERD, normalization, BI SQL (RDB + warehouse), Cypher fraud-detection queries |
| Scripted artifacts | SaleCo SQLite schema/load/queries; ClassicModels warehouse DDL/DML; fraud-detection Cypher |
| Dependencies | `requirements.txt` (pandas, SQLAlchemy, Elasticsearch 7.x client, folium, Jupyter) |

---

## 4. Structure

```
Database-Systems-and-Data-Preparation/
├── sql/
│   ├── rdb/
│   │   ├── build-saleco-schema.sql      # SaleCo teaching schema (SQLite)
│   │   ├── load-saleco-data.sql         # INSERT seed data
│   │   └── sample-queries.sql           # SELECT / JOIN practice queries
│   ├── warehouse/
│   │   ├── classicmodels-dw-ddl.sql     # Star-schema dimensions & facts
│   │   ├── classicmodels-dw-dml.sql     # Warehouse load scripts
│   │   └── classicmodels-oper-vs-analytical.sql
│   └── graph/
│       └── fraud-detection.cypher       # Neo4j fraud-detection graph seed
├── data/
│   ├── sample/
│   │   └── SalesCO.db                   # Committed SaleCo teaching database (~52 KB)
│   └── README.md                        # Acquisition notes for large CSVs/DBs
├── requirements.txt
├── SQL LA Traffic Data.ipynb
├── Data Prep & Cleaning.ipynb
├── Hierarchical Indexes, Pivot-tables, lambda, map.ipynb
├── Chicago Food Inspections - NoSQL.ipynb
├── Entity Relationship Diagram.pdf
├── Normalization through Business Rules.pdf
├── Business Intelligence SQL Queries RDB.pdf
├── Business Intelligence SQL Queries Data Warehouse.pdf
├── Fraud Detection Cypher Query Language.pdf
├── .gitignore
└── README.md
```

### Module map

| Module | Topic | Primary artifacts |
|--------|-------|-------------------|
| Schema design | ERD, normalization | `Entity Relationship Diagram.pdf`, `Normalization through Business Rules.pdf` |
| Relational SQL | LA traffic collisions | `SQL LA Traffic Data.ipynb`, `sql/rdb/` |
| Data preparation | Cleaning, integration, EDA | `Data Prep & Cleaning.ipynb` |
| Data warehouse | Star schema, BI SQL | `sql/warehouse/`, BI warehouse PDF |
| Analytics transforms | Pivot, hierarchical index, custom aggregations | `Hierarchical Indexes, Pivot-tables, lambda, map.ipynb` |
| Document search | Elasticsearch, geospatial viz | `Chicago Food Inspections - NoSQL.ipynb` |
| Graph queries | Cypher, fraud detection | `sql/graph/fraud-detection.cypher`, Cypher PDF |

- **Organization:** coursework split across notebooks (applied labs), `sql/` scripts (reproducible schema and query artifacts), and PDF submissions (conceptual and written query portfolios)
- **Reusable modules:** none; SQL helpers (e.g., `run_sql`) are defined inline in notebooks
- **Engineering practice:** CSV-to-database loading pipelines, deduplication and imputation workflows, indexed query experiments with relevance tuning, multi-table relational joins, and scripted schema artifacts suitable for local replay

---

## 5. Quick start

```bash
git clone https://github.com/EAName/Database-Systems-and-Data-Preparation.git
cd Database-Systems-and-Data-Preparation

python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
jupyter notebook
```

**SaleCo sample database** (relational/BI SQL practice) is committed at `data/sample/SalesCO.db`:

```bash
sqlite3 data/sample/SalesCO.db "SELECT name FROM sqlite_master WHERE type='table';"
sqlite3 data/sample/SalesCO.db "SELECT COUNT(*) FROM PRODUCT;"

# Optional rebuild from SQL scripts:
sqlite3 SalesCO.db < sql/rdb/build-saleco-schema.sql
sqlite3 SalesCO.db < sql/rdb/load-saleco-data.sql
sqlite3 SalesCO.db < sql/rdb/sample-queries.sql
```

For LA traffic, Chicago inspections, `xyz.db`, and Elasticsearch replay, see [data/README.md](data/README.md). Large raw CSVs and locally built `.db` files remain gitignored (100 MB+).

---

**Course:** Northwestern University, M.S. in Data Science (Data Engineering specialization), MSDS 420 — Database Systems and Data Preparation, Winter 2022  
**Repository:** https://github.com/EAName/Database-Systems-and-Data-Preparation
