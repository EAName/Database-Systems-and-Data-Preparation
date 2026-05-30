# Database-Systems-and-Data-Preparation

Graduate coursework spanning relational SQL, document-oriented search, data cleaning, and schema design across multiple data paradigms.

---

## 1. Title and Summary

**Database Systems and Data Preparation**  
Northwestern University M.S. in Data Science (Data Engineering specialization): hands-on work with relational databases, document indexing, pandas-based data preparation, and supporting deliverables on normalization, entity-relationship modeling, and graph query concepts.

---

## 2. Concepts and Methods

- **Relational SQL (SQLite):** load CSV data into SQLite via SQLAlchemy (`create_engine`, `to_sql`, `read_sql_query`); write queries with `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`, implicit joins, and explicit `JOIN`; analyze LA traffic collision records (`traffic`, `MO_accident`, `MO_master` tables)
- **Data warehouse / BI SQL:** standalone PDF deliverables for business-intelligence query patterns on relational and warehouse-style schemas [VERIFY specific star/snowflake designs and query optimization techniques documented in PDFs]
- **Schema design:** entity-relationship diagram deliverable; normalization through business rules deliverable [VERIFY normal forms and business-rule examples in PDF]
- **Graph data / Cypher:** fraud-detection Cypher query language deliverable [VERIFY graph database platform, e.g., Neo4j, and query patterns in PDF; no graph DB client code present in notebooks]
- **Document-oriented search (Elasticsearch):** connect to a course Elasticsearch index of Chicago food inspection records; build `bool` and `query_string` queries; use scroll API for retrieval; compare query precision across three experiments
- **Data cleaning and integration (pandas):** ingest LA traffic collision CSV from `data.lacity.org`; drop low-value columns; remove duplicates; impute missing ages with mean; coerce numeric types; filter invalid categorical values; exploratory analysis by victim age, sex, and descent
- **Hierarchical indexing and reshaping:** construct `MultiIndex` objects; group and slice multi-level Series/DataFrames; build `pivot_table` summaries with custom `aggfunc`, margins, and categorical binning (`Categorical`, `heavyCat`)
- **Functional transforms:** custom aggregation functions (`coefV` coefficient of variation), `lambda`, `map`, and `groupby().agg()` on retail/customer SQLite data (`xyz.db`)
- **Geospatial visualization:** folium heatmaps of failed Chicago food inspections tied to NoSQL query results

**Out of scope for this repo:** cloud ETL orchestration and batch/streaming pipeline frameworks (see **Data-Miners**); systems lifecycle and architecture methodology (see **Systems-Engineering**); deployed analytics application engineering (see **Analytics-Applications-Engineering**).

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

[VERIFY whether course Elasticsearch was hosted on a specific DSCC/VPN environment vs. local install]

---

## 4. Structure

```
Database-Systems-and-Data-Preparation/
├── SQL LA Traffic Data.ipynb
├── Data Prep & Cleaning.ipynb
├── Hierarchical Indexes, Pivot-tables, lambda, map.ipynb
├── Chicago Food Inspections - NoSQL.ipynb
├── Entity Relationship Diagram.pdf
├── Normalization through Business Rules.pdf
├── Business Intelligence SQL Queries RDB.pdf
├── Business Intelligence SQL Queries Data Warehouse.pdf
├── Fraud Detection Cypher Query Language.pdf
└── README.md
```

- **Organization:** four Jupyter assignments plus five PDF deliverables; relational/document/graph topics split across notebooks and written submissions
- **Reusable modules:** none; SQL helpers (e.g., `run_sql`) defined inline in notebooks
- **Engineering practice:** CSV-to-database loading pipelines, deduplication and imputation workflows, indexed query experiments with relevance tuning, and multi-table relational joins for analytical SQL

---

**Course context:** Northwestern University, M.S. in Data Science, Data Engineering specialization  
**Repository:** https://github.com/EAName/Database-Systems-and-Data-Preparation
