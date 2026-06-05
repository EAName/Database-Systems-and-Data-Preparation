# Data setup

Large raw files and SQLite databases are **not** committed to this repository. Rebuild them locally using the notebooks, SQL scripts, or public sources below.

## LA traffic collisions (Module 4 — `SQL LA Traffic Data.ipynb`)

| Artifact | Size (local) | How to obtain |
|----------|--------------|---------------|
| `Traffic_Collision_Data.csv` | ~110 MB | [Los Angeles Open Data — Traffic Collisions](https://data.lacity.org/) |
| `LAtraffic.db` | ~113 MB | Created in the notebook via SQLAlchemy `to_sql` after loading CSVs |
| `MO master.csv`, `MO per accident.csv` | small | Derived/split in coursework from the traffic dataset |

**SQL scripts:** `sql/rdb/build-saleco-schema.sql`, `load-saleco-data.sql`, and `sample-queries.sql` build the separate SaleCo teaching schema (`SalesCO.db`, ~52 KB) used for BI query practice.

```bash
sqlite3 SalesCO.db < sql/rdb/build-saleco-schema.sql
sqlite3 SalesCO.db < sql/rdb/load-saleco-data.sql
sqlite3 SalesCO.db < sql/rdb/sample-queries.sql
```

## Retail analytics (Module 7 — pivot / lambda notebook)

| Artifact | Size (local) | How to obtain |
|----------|--------------|---------------|
| `xyz.db` | ~7.8 MB | Created in `Hierarchical Indexes, Pivot-tables, lambda, map.ipynb` from bundled retail/customer SQLite exercise data |

## Chicago food inspections (Module 8 — Elasticsearch)

| Artifact | Size (local) | How to obtain |
|----------|--------------|---------------|
| `Chicago_Food_Inspections.csv` | ~188 MB | [Chicago Data Portal — Food Inspections](https://data.cityofchicago.org/) |

The NoSQL notebook expects a course Elasticsearch index; for local replay you need Elasticsearch running and index setup per notebook instructions.

## Data warehouse (Module 6)

MySQL-style DDL/DML for the ClassicModels star schema lives under `sql/warehouse/`. Run against MySQL or adapt for your warehouse engine:

- `classicmodels-dw-ddl.sql` — dimension and fact tables
- `classicmodels-dw-dml.sql` — load scripts
- `classicmodels-oper-vs-analytical.sql` — operational vs analytical query comparisons

## Graph fraud detection (Module 9)

`sql/graph/fraud-detection.cypher` seeds the Neo4j graph used in the fraud-detection exercise. Import in Neo4j Browser or `cypher-shell`. Written deliverable: `Fraud Detection Cypher Query Language.pdf`.
