# Database-Systems-and-Data-Preparation

Graduate coursework spanning relational SQL, document-oriented search, data cleaning, and schema design across multiple data paradigms.

---

## 1. Title and Summary

**Database Systems and Data Preparation**  
Northwestern University M.S. in Data Science (Data Engineering specialization): hands-on work with relational databases, document indexing, pandas-based data preparation, and supporting deliverables on normalization, entity-relationship modeling, and graph query concepts.

---

## 2. Concepts and Methods

- **Relational SQL (SQLite):** load CSV data into SQLite via SQLAlchemy (`create_engine`, `to_sql`, `read_sql_query`); write queries with `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`, implicit joins, and explicit `JOIN`; analyze LA traffic collision records (`traffic`, `MO_accident`, `MO_master` tables)
- **Data warehouse / BI SQL:** ClassicModels star-schema DDL/DML and operational-vs-analytical query scripts (`sql/warehouse/`); PDF deliverables for BI query patterns on RDB and warehouse schemas
- **Schema design:** entity-relationship diagram deliverable; normalization through business rules deliverable
- **Graph data / Cypher:** Neo4j fraud-detection graph script (`sql/graph/fraud-detection.cypher`) plus written Cypher deliverable (PDF)
- **Document-oriented search (Elasticsearch):** connect to a course Elasticsearch index of Chicago food inspection records; build `bool` and `query_string` queries; use scroll API for retrieval; compare query precision across three experiments
- **Data cleaning and integration (pandas):** ingest LA traffic collision CSV from `data.lacity.org`; drop low-value columns; remove duplicates; impute missing ages with mean; coerce numeric types; filter invalid categorical values; exploratory analysis by victim age, sex, and descent
- **Hierarchical indexing and reshaping:** construct `MultiIndex` objects; group and slice multi-level Series/DataFrames; build `pivot_table` summaries with custom `aggfunc`, margins, and categorical binning (`Categorical`, `heavyCat`)
- **Functional transforms:** custom aggregation functions (`coefV` coefficient of variation), `lambda`, `map`, and `groupby().agg()` on retail/customer SQLite data (`xyz.db`)
- **Geospatial visualization:** folium heatmaps of failed Chicago food inspections tied to NoSQL query results

---

## 3. Stack

| Layer | Tools |
|-------|-------|
| Language | Python 3 |
| Environment | Jupyter Notebook |
| Relational DB | SQLite via SQLAlchemy |
| Document / search | Elasticsearch Python client (`elasticsearch`, bulk API referenced in coursework) |
| Data prep / analysis | pandas, NumPy |
| Visualization | matplotlib, seaborn, folium (HeatMap plugin) |
| Utilities | `tabulate`, `sqlite3`, `collections.defaultdict` |
| Deliverables (PDF) | ERD, normalization, BI SQL (RDB + warehouse), Cypher fraud-detection queries |
| SQL / Cypher scripts | SaleCo SQLite schema, ClassicModels warehouse DDL/DML, sample queries, fraud-detection Cypher |
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
│   └── README.md                        # How to obtain large CSVs/DBs (not committed)
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

- **Organization:** four Jupyter assignments, seven SQL/Cypher scripts, five PDF deliverables; relational, warehouse, document, and graph topics split across notebooks, scripts, and written submissions
- **Reusable modules:** none; SQL helpers (e.g., `run_sql`) defined inline in notebooks
- **Engineering practice:** CSV-to-database loading pipelines, deduplication and imputation workflows, indexed query experiments with relevance tuning, multi-table relational joins, and reproducible schema scripts

---

## 5. Quick start

```bash
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
jupyter notebook
```

**SaleCo sample database** (BI SQL practice) is committed at `data/sample/SalesCO.db`. Query it directly or rebuild from scripts:

```bash
sqlite3 data/sample/SalesCO.db "SELECT name FROM sqlite_master WHERE type='table';"

# Optional rebuild from SQL scripts:
sqlite3 SalesCO.db < sql/rdb/build-saleco-schema.sql
sqlite3 SalesCO.db < sql/rdb/load-saleco-data.sql
sqlite3 SalesCO.db < sql/rdb/sample-queries.sql
```

For LA traffic, Chicago inspections, `xyz.db`, and Elasticsearch replay, see [data/README.md](data/README.md). Large raw CSVs and local `.db` files remain gitignored (100 MB+).

---

**Course context:** Northwestern University, M.S. in Data Science, Data Engineering specialization  
**Repository:** https://github.com/EAName/Database-Systems-and-Data-Preparation
