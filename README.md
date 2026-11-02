# Database-Systems-and-Data-Preparation

Northwestern University, M.S. in Data Science (Data Engineering specialization) · MSDS 420: Database Systems

## Overview

This course covered the same business data through four storage models: a normalized relational schema (SQLite), a star-schema warehouse (PostgreSQL/MySQL), a document index (Elasticsearch), and a property graph (Neo4j), plus the pandas cleaning work that feeds them. The useful lesson for a data engineer is less any single query than the tradeoffs between models: what normalization buys you on writes, what a dimensional model buys you on aggregate reads, when text search beats SQL, and when relationships are the data and a graph is the natural fit.

## Highlights / Results

| Work | Method | Result | Source |
|------|--------|--------|--------|
| LA traffic collision cleaning | pandas dedupe, filter, impute, `explode` of multi-valued MO codes | 569,389 raw rows to 559,415 clean collisions; MO codes split into a 3,101,766-row bridge table (331 distinct codes) | `Data Prep & Cleaning.ipynb` (cells 5, 60, 62) |
| LA traffic in SQLite | SQLAlchemy `to_sql`, joins across `traffic`, `MO_accident`, `MO_master` | Top hit-and-run division (MO 3029/3030): 77th Street, 16,526 coded rows; 77th Street also has the most collisions (37,280) | `SQL LA Traffic Data.ipynb` (cell 57) |
| Chicago food inspections | Elasticsearch `bool` + `query_string`, wildcard vs. fuzzy matching, `terms` aggregation | Failed high-risk inspections mentioning children: 601 hits with `*Children*`, 196 with `Children~`, 505 with `Children's~`; 774 / 300 / 24 for the `Child` variants. 26 child-care facilities failed high-risk inspections 5+ times | `Chicago Food Inspections - NoSQL.ipynb` (cells 32, 52, 56, 74, 86, 89, 67) |
| SaleCo warehouse BI | `GROUP BY ROLLUP` / `CUBE` over a sales fact table | ROLLUP turns 10 region/customer rows into 15 (region subtotals plus grand total 2,252.06); CUBE gives 25 | [docs/bi-queries.md](docs/bi-queries.md), `Business Intelligence SQL Queries Data Warehouse.pdf` |
| Card fraud graph | Cypher pattern matching on `(:Customer)-[:SHOPPED_AT]->(:Retailer)` | 33 of 84 transactions disputed; Walmart (7) and Nordstrom (6) lead; both LaSalle Street stores (Nordstrom 6, Neiman Marcus 4) show up | [docs/fraud-detection-cypher.md](docs/fraud-detection-cypher.md), `sql/graph/fraud-detection.cypher` |
| Normalization | Functional dependencies to 2NF and 3NF | Two case studies (hotel staffing agency, Wellmeadows Hospital medication form) decomposed with PKs/FKs | [docs/normalization.md](docs/normalization.md) |

## Schema design decisions

Grounded in the written deliverables, now readable as markdown under [`docs/`](docs/).

- **Normalization level: 3NF.** Both case studies in [docs/normalization.md](docs/normalization.md) stop at 3NF: partial dependencies are removed first (for example `hNo -> hLoc` moves hotel location into its own `Hotel` relation), then transitive ones (`NIN -> hNo -> hLoc`). 3NF is the usual stopping point for an OLTP schema because every non-key fact is stored once, so an update (a hotel moves, a drug is renamed) touches one row, while the join count stays manageable. BCNF and beyond were not needed for these examples. Looking back at the submission, a few keys were chosen from the sample rows rather than the business rules (`NIN` alone as the staffing PK, `bedNo` on `Ward`); the doc keeps the original answer and adds a short reviewer note with the corrected decomposition.
- **Keys in SaleCo.** [docs/erd.md](docs/erd.md) renders the ERD as Mermaid. Surrogate-style codes are the primary keys (`CUS_CODE`, `INV_NUMBER`, `P_CODE`, `V_CODE`). `LINE` uses the composite key (`INV_NUMBER`, `LINE_NUMBER`) because a line number only means something inside its invoice; the DDL in `sql/rdb/build-saleco-schema.sql` adds `ON DELETE CASCADE` from `LINE` to `INVOICE` and a `UNIQUE (INV_NUMBER, P_CODE)` constraint so a product appears once per invoice. `PRODUCT.V_CODE` is a nullable FK, which the ERD draws as mandatory; the doc notes the mismatch.
- **Warehouse vs. relational queries.** In SaleCo OLTP, "sales by customer" means joining `INVOICE` to `LINE` and computing units times price at read time. In `saleco_dw` the fact table `DWDAYSALESFACT` is already at sale grain with `SALE_UNITS` and `SALE_PRICE` on it, and time, region, and category are one join away. That is why `ROLLUP` and `CUBE` work from a single fact-to-dimension join. `sql/warehouse/classicmodels-oper-vs-analytical.sql` shows the same contrast on ClassicModels: a four-table join through `orders` and `orderdetails` versus a direct `factOrderDetails` join to `dimtime`, `dimproducts`, `dimcustomers`. The cost is a load step and redundant dimension attributes, which is fine for read-heavy analytics and wrong for transactional writes.
- **Why a graph for fraud.** The fraud question is "which merchant do disputed cards have in common?", and each follow-up adds a hop (which employees work there, which accounts those customers use). In SQL that is a growing chain of self-joins on a transactions table. In Neo4j a transaction is an attributed `SHOPPED_AT` edge, so the question is one `MATCH` pattern and an extra hop is one more segment. See [docs/fraud-detection-cypher.md](docs/fraud-detection-cypher.md).
- **Why Elasticsearch for inspections.** The signal (facilities serving children) is buried in free-text `Violations`, `Facility Type`, and `DBA Name` fields with inconsistent spelling. An inverted index with wildcard and fuzzy (`~`, edit distance 1) matching handles that directly, and the three experiments in the notebook show how much the hit count moves with the query form (601 vs. 196 vs. 505), which is a precision/recall decision, not a SQL `LIKE` tweak.

## Engineering decisions and tradeoffs

- **Bridge table for multi-valued codes.** Collision records carry a space-separated list of MO codes. Rather than keep a string column, `Data Prep & Cleaning.ipynb` explodes it into a `(DR_Number, MO_Codes)` table (3.1M rows) and `SQL LA Traffic Data.ipynb` joins it to an `MO_master` lookup. Codes are read as strings (`dtype={'MO_Codes': 'str'}`) to keep leading zeros.
- **Imputation plus a flag column.** Missing victim ages are mean-imputed, and an `imputeAge` flag is carried into SQLite so downstream queries can filter on it (the last cells of the SQL notebook compute the flagged share by gender and descent). In the notebook as run, the flag is set after the fill and marks ages 16 and under rather than the filled rows; the assignment intended it as an audit of imputed values, which is the version I would build now (set the flag from `isnull()` before `fillna`).
- **Dropping instead of guessing.** Age 99 (7,218 rows, a placeholder value) and invalid gender codes are removed rather than recoded; low-information columns (premise code is "STREET" for 535,982 rows) are dropped before load.
- **Index-side aggregation.** The frequent-violator query pushes the grouping into Elasticsearch (`terms` on `DBA Name.keyword` with `min_doc_count: 5`, plus `top_hits`) instead of pulling every hit into pandas.
- **Scripted, replayable schemas.** SaleCo DDL, seed data, and queries are plain SQL files, and the built database is committed (`data/sample/SalesCO.db`, 52 KB) so the relational BI queries in `sql/rdb/bi-queries-saleco.sql` run with one `sqlite3` command.

## Limitations and what I would do differently today

- **A couple of cleaning bugs survived.** In `Data Prep & Cleaning.ipynb` cell 57, latitude and longitude are split from `Location[0]` (the first row) instead of the whole column, so every row gets 34.0255, -118.3002; the division scatter in the SQL notebook (cell 59) shows the symptom. Several `replace(...)` calls for gender and descent are not assigned back. Today I would write these as tested functions (`str.extract` on the column) with row-count and distinct-value assertions after each step.
- **Notebooks, not pipelines.** CSV to cleaned CSV to SQLite is a manual sequence of notebooks with hardcoded filenames. I would make it a small dbt or Python pipeline (raw, staged, mart layers) orchestrated with Airflow or Dagster, with data contracts on the staged tables.
- **No data versioning or tests.** Source extracts from the LA and Chicago portals are not pinned to a date or checksum, so results will drift if rerun. I would snapshot inputs (DVC or object storage with versioned paths) and add Great Expectations or dbt tests.
- **Warehouse DDL for SaleCo is not here.** The `saleco_dw` star schema used in the BI PDF came from the course environment; only the ClassicModels warehouse DDL is in `sql/warehouse/`. Some submitted warehouse queries also have issues (Q9 is a Cartesian product); [docs/bi-queries.md](docs/bi-queries.md) flags them and gives corrected SQL.
- **The Elasticsearch notebook is 13 MB** because it stores full query results and folium maps as outputs. It is kept as the original run, but outputs could be trimmed.

## Repository map

| Path | Model | What it covers |
|------|-------|----------------|
| `Entity Relationship Diagram.pdf`, [docs/erd.md](docs/erd.md) | Relational (OLTP) | SaleCo Crow's Foot ERD: entities, attributes, cardinalities, keys, eight business rules |
| `Normalization through Business Rules.pdf`, [docs/normalization.md](docs/normalization.md) | Relational | 1NF to 3NF for a staffing agency and the Wellmeadows Hospital case |
| `Business Intelligence SQL Queries RDB.pdf`, `Business Intelligence SQL Queries Data Warehouse.pdf`, [docs/bi-queries.md](docs/bi-queries.md) | OLTP and ROLAP | Ten BI questions on SaleCo (SQLite) and ten on the `saleco_dw` star schema (PostgreSQL), including `ROLLUP` and `CUBE` |
| `sql/rdb/build-saleco-schema.sql`, `load-saleco-data.sql`, `sample-queries.sql` | Relational | SaleCo DDL (PKs, FKs, unique constraints, indexes), seed data, `SELECT`/`WHERE`/`LIKE`/`IN` practice |
| `sql/rdb/bi-queries-saleco.sql` | Relational | BI queries from the RDB PDF, with corrected variants; runs against `data/sample/SalesCO.db` |
| `sql/warehouse/classicmodels-dw-ddl.sql`, `classicmodels-dw-dml.sql` | ROLAP | ClassicModels star schema (`dimCustomers`, `dimEmployees`, `dimProducts`, `dimtime`, `factOrderDetails`) and load scripts (MySQL) |
| `sql/warehouse/classicmodels-oper-vs-analytical.sql` | OLTP vs. ROLAP | Same three questions against `classicmodels` and `classicmodelsdw` |
| `sql/warehouse/saleco-dw-bi-queries.sql` | ROLAP | Warehouse BI queries from the PDF, with corrected Q6 and Q9 |
| `sql/graph/fraud-detection.cypher` | Graph | Neo4j seed: 20 customers, 20 employees, 10 retailers, 10 accounts, 136 relationships |
| `sql/graph/fraud-detection-queries.cypher`, `Fraud Detection Cypher Query Language.pdf`, [docs/fraud-detection-cypher.md](docs/fraud-detection-cypher.md) | Graph | Disputed-transaction queries and results |
| `Data Prep & Cleaning.ipynb` | pandas | LA traffic: dedupe, drop columns, age imputation with flag, category filtering, MO code explode, export to CSV |
| `SQL LA Traffic Data.ipynb` | Relational (SQLite) | Load cleaned CSVs with SQLAlchemy; `SELECT`, `GROUP BY`, implicit and explicit joins, `BETWEEN`, `IN`, `LIKE`; division and hit-and-run analysis |
| `Hierarchical Indexes, Pivot-tables, lambda, map.ipynb` | In-memory OLAP | `MultiIndex` slicing and `xs`, `pivot_table` with `aggfunc` and margins, `lambda`/`map`, custom `coefV` aggregation on retail data (`xyz.db`) |
| `Chicago Food Inspections - NoSQL.ipynb` | Document (Elasticsearch) | `bool`/`query_string` queries, wildcard vs. fuzzy, scroll API, `terms` + `top_hits` aggregation, folium heatmaps |
| `data/sample/SalesCO.db`, [data/README.md](data/README.md) | | Committed SaleCo database; acquisition notes for the large datasets |

## Reproducing

- Python 3.8 or 3.9 (the notebooks were last run on 3.8.10 and 3.9.7). Install dependencies with `pip install -r requirements.txt` (the Elasticsearch client is pinned to 7.x to match the course server).
- Relational BI queries run immediately against the committed database:
  ```bash
  sqlite3 data/sample/SalesCO.db < sql/rdb/bi-queries-saleco.sql
  ```
  To rebuild SaleCo from scratch: `sqlite3 SalesCO.db < sql/rdb/build-saleco-schema.sql`, then `load-saleco-data.sql`.
- The ClassicModels warehouse scripts are MySQL; run `classicmodels-dw-ddl.sql` then `classicmodels-dw-dml.sql` against a MySQL instance that already has the public `classicmodels` sample database. The `saleco_dw` queries need the course-provided PostgreSQL warehouse.
- Graph: paste `sql/graph/fraud-detection.cypher` into Neo4j Browser (the whole script at once), then run `sql/graph/fraud-detection-queries.cypher`.
- Data is not bundled. Download `Traffic_Collision_Data.csv` from the [Los Angeles Open Data portal](https://data.lacity.org/) and `Chicago_Food_Inspections.csv` from the [Chicago Data Portal](https://data.cityofchicago.org/Health-Human-Services/Food-Inspections/4ijn-s7e5) and place them next to the notebooks. Run `Data Prep & Cleaning.ipynb` before `SQL LA Traffic Data.ipynb` (it writes `Final Traffic.csv` and `MO per accident.csv`; `MO master.csv` came from the course). See [data/README.md](data/README.md) for sizes and the `xyz.db` retail data.
- Elasticsearch: the course index lived on a university server reached over VPN. Set `ES_URL` (for example `https://user:password@host:9200`) to point the notebook at your own cluster with a `food_inspections` index loaded from the CSV.
- Notebooks and PDFs reflect the original course run (Winter 2022); outputs were not regenerated.

## Stack

| Layer | Tools |
|-------|-------|
| Language | Python 3, SQL, Cypher |
| Environment | Jupyter Notebook |
| OLTP (relational) | SQLite via SQLAlchemy and `sqlite3`; SaleCo and ClassicModels operational schemas |
| OLAP / ROLAP | PostgreSQL (`saleco_dw`), MySQL (ClassicModels star schema); pandas `pivot_table` / `groupby` |
| Document / search | Elasticsearch 7.x Python client |
| Graph | Neo4j, Cypher |
| Data prep / analysis | pandas, NumPy |
| Visualization | matplotlib, seaborn, folium (HeatMap plugin) |
| Utilities | `tabulate`, `collections.defaultdict` |
