# Database-Systems-and-Data-Preparation

Relational and warehouse SQL, Elasticsearch document search, and pandas data preparation—four Jupyter labs, seven SQL/Cypher scripts, a committed SaleCo sample database, and schema design deliverables across relational, document, and graph paradigms.

**Course:** Northwestern University M.S. in Data Science (Data Engineering specialization), MSDS 420 — Database Systems and Data Preparation (Winter 2022)

---

## What's in this repository

| Artifact | Contents |
|----------|----------|
| **Notebooks (4)** | Data cleaning, LA traffic SQL, pivot/lambda analytics, Chicago food inspections + Elasticsearch |
| **SQL / Cypher (7)** | SaleCo RDB schema and queries; ClassicModels warehouse DDL/DML; Neo4j fraud-detection graph seed |
| **Sample data** | `data/sample/SalesCO.db` (~52 KB) — ready-to-query SaleCo teaching database |
| **PDF deliverables (5)** | ERD, normalization, BI SQL (RDB + warehouse), fraud-detection Cypher write-up |
| **Setup** | `requirements.txt`, [data/README.md](data/README.md) for large CSV/DB sources |

Large raw files (`LAtraffic.db`, Chicago inspections CSV, `xyz.db`) are documented but not committed (100 MB+).

---

## Notebooks and focus areas

| Notebook | Focus |
|----------|--------|
| [Data Prep & Cleaning.ipynb](Data%20Prep%20%26%20Cleaning.ipynb) | pandas ingestion, deduplication, imputation, LA traffic collision EDA |
| [SQL LA Traffic Data.ipynb](SQL%20LA%20Traffic%20Data.ipynb) | SQLAlchemy → SQLite, joins, aggregations on traffic collision tables |
| [Hierarchical Indexes, Pivot-tables, lambda, map.ipynb](Hierarchical%20Indexes%2C%20Pivot-tables%2C%20lambda%2C%20map.ipynb) | MultiIndex, `pivot_table`, custom `aggfunc`, retail SQLite analytics |
| [Chicago Food Inspections - NoSQL.ipynb](Chicago%20Food%20Inspections%20-%20NoSQL.ipynb) | Elasticsearch `bool` / `query_string` queries, scroll API, folium heatmaps |

---

## SQL and Cypher scripts

### Relational (`sql/rdb/`)

| File | Purpose |
|------|---------|
| `build-saleco-schema.sql` | SaleCo vendor/product/customer/invoice DDL |
| `load-saleco-data.sql` | Seed INSERT statements |
| `sample-queries.sql` | SELECT, WHERE, JOIN practice queries |

Matches the committed database at `data/sample/SalesCO.db`.

### Warehouse (`sql/warehouse/`)

| File | Purpose |
|------|---------|
| `classicmodels-dw-ddl.sql` | Star-schema dimensions and facts |
| `classicmodels-dw-dml.sql` | Warehouse load scripts |
| `classicmodels-oper-vs-analytical.sql` | Operational vs analytical query patterns |

### Graph (`sql/graph/`)

| File | Purpose |
|------|---------|
| `fraud-detection.cypher` | Neo4j graph seed for fraud-detection exercise |

---

## Stack

| Layer | Tools |
|-------|-------|
| Language | Python 3 |
| Environment | Jupyter Notebook |
| Relational DB | SQLite via SQLAlchemy |
| Document search | Elasticsearch 7.x Python client |
| Data prep / analysis | pandas, NumPy |
| Visualization | matplotlib, seaborn, folium (HeatMap) |
| Utilities | tabulate, sqlite3 |
| Dependencies | See [requirements.txt](requirements.txt) |

---

## Repository structure

```
Database-Systems-and-Data-Preparation/
├── sql/
│   ├── rdb/                    # SaleCo SQLite schema, data, sample queries
│   ├── warehouse/              # ClassicModels star-schema scripts
│   └── graph/                    # fraud-detection.cypher
├── data/
│   ├── sample/SalesCO.db       # Committed teaching database
│   └── README.md               # Sources for large local datasets
├── requirements.txt
├── *.ipynb                     # Four course notebooks
├── *.pdf                       # ERD, normalization, BI SQL, Cypher deliverables
└── README.md
```

---

## Quick start

```bash
git clone https://github.com/EAName/Database-Systems-and-Data-Preparation.git
cd Database-Systems-and-Data-Preparation

python -m venv .venv && source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt
jupyter notebook
```

**Query the SaleCo sample database:**

```bash
sqlite3 data/sample/SalesCO.db "SELECT name FROM sqlite_master WHERE type='table';"
sqlite3 data/sample/SalesCO.db "SELECT COUNT(*) FROM PRODUCT;"
```

**Rebuild SaleCo from scripts (optional):**

```bash
sqlite3 SalesCO.db < sql/rdb/build-saleco-schema.sql
sqlite3 SalesCO.db < sql/rdb/load-saleco-data.sql
sqlite3 SalesCO.db < sql/rdb/sample-queries.sql
```

**Elasticsearch notebook:** requires a running Elasticsearch 7.x instance and course index setup per notebook instructions.

**Large datasets:** see [data/README.md](data/README.md) for LA traffic and Chicago food inspection download links.

---

## Concepts covered

- Relational SQL: loading CSVs into SQLite, multi-table joins, BI query patterns
- Data warehouse design: star schema DDL/DML, operational vs analytical SQL
- Schema design: ERD, normalization through business rules (PDF deliverables)
- Document search: Elasticsearch query tuning and precision experiments
- Graph data: Cypher fraud-detection modeling (script + PDF)
- Data preparation: cleaning, imputation, hierarchical indexes, pivot analytics
- Geospatial visualization: folium heatmaps from search results

---

**Course context:** Northwestern University, M.S. in Data Science, Data Engineering specialization  
**Repository:** https://github.com/EAName/Database-Systems-and-Data-Preparation
