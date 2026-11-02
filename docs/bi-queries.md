# Business intelligence SQL queries: relational vs. warehouse

Sources:
- [`Business Intelligence SQL Queries RDB.pdf`](../Business%20Intelligence%20SQL%20Queries%20RDB.pdf) (2 pages, SQLite against the SaleCo OLTP schema)
- [`Business Intelligence SQL Queries Data Warehouse.pdf`](../Business%20Intelligence%20SQL%20Queries%20Data%20Warehouse.pdf) (5 pages, PostgreSQL `psql` against the `saleco_dw` star schema)

Both PDFs are terminal screenshots. The queries and outputs below were transcribed from the page images. Runnable copies of the queries are in [`sql/rdb/bi-queries-saleco.sql`](../sql/rdb/bi-queries-saleco.sql) and [`sql/warehouse/saleco-dw-bi-queries.sql`](../sql/warehouse/saleco-dw-bi-queries.sql). Where a submitted query does not fully answer its question, that is flagged and a corrected version is given in the `.sql` file; the outputs shown here are always the ones in the PDF.

## Part 1: relational (OLTP) queries on SaleCo

Schema: `CUSTOMER`, `INVOICE`, `LINE`, `PRODUCT`, `VENDOR` (see [erd.md](erd.md)). The database is committed at `data/sample/SalesCO.db`, so these can be replayed with `sqlite3 data/sample/SalesCO.db < sql/rdb/bi-queries-saleco.sql`.

| # | Question | Result in PDF |
|---|----------|---------------|
| 1 | How many invoices? List invoice numbers and dates. | 8 invoices (1001 to 1008, 16 to 17 Jan 2016) |
| 2 | How many customers? List codes and names. | 10 customers |
| 3 | List vendor codes and names; vendor count per state. | 11 vendors; count query returned 11 |
| 4 | Most expensive product and its quantity on hand. | 256.99; QOH 11, "Hicut chainsaw, 16 in." |
| 5 | Customers with balance over $500. | 2 (10013 Olowski Paul 536.75; 10017 Williams George 768.93) |
| 6 | Products offered by each vendor. | 14 product/vendor rows |
| 7 | Customer purchases by invoice and line. | 18 invoice lines |
| 8 | Balances of customers who appear in `INVOICE`. | 10012 (345.86), 10018 (216.55) |
| 9 | Customers with no purchases in the invoicing period. | 10010, 10013, 10016, 10017, 10019 |
| 10 | Inventory value per product (`p_qoh * p_price`). | 16 products, from 115.20 (23114-AA) to 2826.89 (89-WRE-Q) |

```sql
-- 1
SELECT COUNT(*) FROM invoice;
SELECT inv_number, inv_date FROM invoice;
-- 2
SELECT COUNT(*) FROM customer;
SELECT cus_code, cus_lname, cus_fname FROM customer;
-- 3
SELECT v_code, v_name FROM vendor;
SELECT COUNT(v_state) FROM vendor;
-- 4
SELECT MAX(p_price) FROM product;
SELECT MAX(p_price) AS price, p_qoh, p_descript FROM product;
-- 5
SELECT COUNT(cus_code) AS cus_count FROM customer WHERE cus_balance > 500;
SELECT cus_code, cus_lname, cus_fname, cus_balance FROM customer WHERE cus_balance > 500;
-- 6
SELECT product.p_code, product.v_code, vendor.v_name
FROM product, vendor
WHERE product.v_code = vendor.v_code;
-- 7
SELECT invoice.cus_code, invoice.inv_number, line.line_number, line.line_price
FROM invoice, line
WHERE invoice.inv_number = line.inv_number;
-- 8
SELECT invoice.cus_code, customer.cus_balance
FROM invoice, customer
WHERE invoice.cus_code = customer.cus_code AND customer.cus_balance;
-- 9
SELECT cus_code AS zero_purchases FROM customer
WHERE cus_code NOT IN (SELECT cus_code FROM invoice);
-- 10
SELECT (p_qoh * p_price) AS value, p_code FROM product;
```

Review notes (added now, comparing each query to its question):
- Q3 counts all vendors (11) rather than grouping by state; the per-state answer needs `GROUP BY v_state`.
- Q4 part 2 relies on SQLite returning the row that holds the `MAX`, which is SQLite-specific; a portable form uses a subquery on `MAX(p_price)`.
- Q6 and Q8 omit the requested `ORDER BY`. Q8's trailing `AND customer.cus_balance` silently filters out zero balances, which is why only 2 of the 5 invoiced customers (10011, 10012, 10014, 10015, 10018) appear.
- Q7 lists line prices but does not compute the requested per-line subtotal (`line_units * line_price`) or sort explicitly.

## Part 2: warehouse (ROLAP) queries on `saleco_dw`

Star schema used in the PDF: fact table `DWDAYSALESFACT` (`TM_ID`, `CUS_CODE`, `P_CODE`, `SALE_UNITS`, `SALE_PRICE`) with dimensions `DWCUSTOMER` (includes `REG_ID`, `CUS_LNAME`), `DWPRODUCT` (includes `P_CATEGORY`, `P_DESCRIPT`), `DWTIME` (`TM_ID`, `TM_MONTH`), and a region dimension. The DDL for `saleco_dw` was provided by the course and is not in this repository; table and column names here come from the queries in the PDF.

| # | Question | Result in PDF |
|---|----------|---------------|
| 1 | Total sales by region and customer. | 10 rows |
| 2 | Same with `ROLLUP (reg_id, cus_code)`. | 15 rows: 10 detail, 4 region subtotals (1: 352.23, 2: 534.66, 3: 816.19, 4: 548.98), grand total 2252.06 |
| 3 | Same with `CUBE (reg_id, cus_code)`. | 25 rows: ROLLUP rows plus 10 per-customer totals across regions |
| 4 | What ROLLUP and CUBE add. | Written answer, see below |
| 5 | Sales by customer, month, product. | 36 rows |
| 6 | September purchases by customer, top buyer. | 23 detail rows; per-customer totals show 10015 (O'Brian) highest at 310.83 |
| 7 | Sales by month and product category. | 8 rows (Sept: CAT1 174.83, CAT2 446.81, CAT3 537.54, CAT4 80.67; Oct: CAT1 124.89, CAT2 366.91, CAT3 459.64, CAT4 60.77) |
| 8 | Row count and total sales by month. | Sept: 23 rows, 1239.85; Oct: 13 rows, 1012.21 |
| 9 | Units sold by product for Sept and Oct; best seller. | See review note |
| 10 | Row count and sales by month, category, product. | 18 rows |

Written answer to Q4a, as submitted: "The additional information gained when using ROLLUP are sub-totals and grand totals for columns passed to the GROUP BY ROLLUP statement. The GROUP BY CUBE provides all combinations for the selected columns."

```sql
-- 1
SELECT C.REG_ID, S.CUS_CODE, SUM(S.SALE_UNITS*S.SALE_PRICE) AS TOTAL_SALES
FROM DWDAYSALESFACT S JOIN DWCUSTOMER C ON S.CUS_CODE = C.CUS_CODE
GROUP BY C.REG_ID, S.CUS_CODE
ORDER BY C.REG_ID, S.CUS_CODE;

-- 2
SELECT C.REG_ID, S.CUS_CODE, SUM(S.SALE_UNITS*S.SALE_PRICE) AS TOTAL_SALES
FROM DWDAYSALESFACT S JOIN DWCUSTOMER C ON S.CUS_CODE = C.CUS_CODE
GROUP BY ROLLUP (C.REG_ID, S.CUS_CODE);

-- 3
SELECT C.REG_ID, S.CUS_CODE, SUM(S.SALE_UNITS*S.SALE_PRICE) AS TOTAL_SALES
FROM DWDAYSALESFACT S JOIN DWCUSTOMER C ON S.CUS_CODE = C.CUS_CODE
GROUP BY CUBE (C.REG_ID, S.CUS_CODE);

-- 5
SELECT dwdaysalesfact.cus_code, dwdaysalesfact.p_code, dwdaysalesfact.sale_price, dwtime.tm_month
FROM dwdaysalesfact LEFT JOIN dwtime ON dwdaysalesfact.tm_id = dwtime.tm_id
ORDER BY cus_code, tm_month;

-- 6
SELECT dwdaysalesfact.cus_code, dwcustomer.cus_lname, SUM(dwdaysalesfact.sale_price) AS total_sales
FROM dwdaysalesfact
JOIN dwtime ON dwdaysalesfact.tm_id = dwtime.tm_id
JOIN dwcustomer ON dwdaysalesfact.cus_code = dwcustomer.cus_code
WHERE dwtime.tm_month = 9
GROUP BY dwdaysalesfact.cus_code, dwcustomer.cus_lname
ORDER BY SUM(dwdaysalesfact.sale_price);

-- 7
SELECT T.TM_MONTH, P.P_CATEGORY, SUM(S.SALE_UNITS*S.SALE_PRICE) AS TOTAL_SALES
FROM DWTIME T JOIN DWDAYSALESFACT S ON T.TM_ID = S.TM_ID
JOIN DWPRODUCT P ON P.P_CODE = S.P_CODE
GROUP BY T.TM_MONTH, P.P_CATEGORY
ORDER BY T.TM_MONTH, P.P_CATEGORY;

-- 8
SELECT T.TM_MONTH, COUNT(S.TM_ID) AS PRODUCT_SALES, SUM(S.SALE_UNITS*S.SALE_PRICE) AS TOTAL_SALES
FROM DWDAYSALESFACT S JOIN DWTIME T ON S.TM_ID = T.TM_ID
GROUP BY TM_MONTH
ORDER BY TM_MONTH DESC;

-- 9 (as submitted; see review note)
SELECT dwproduct.p_code, dwproduct.p_category, dwtime.tm_month,
       COUNT(dwdaysalesfact.cus_code) AS row, SUM(dwdaysalesfact.sale_price) AS sales
FROM dwdaysalesfact, dwtime, dwproduct
GROUP BY dwproduct.p_code, dwproduct.p_category, dwtime.tm_month
ORDER BY dwproduct.p_code DESC;

-- 10
SELECT T.TM_MONTH, P.P_CATEGORY, S.P_CODE, COUNT(S.TM_ID) AS PRODUCT, SUM(S.SALE_UNITS*S.SALE_PRICE) AS SALES
FROM DWTIME T JOIN DWDAYSALESFACT S ON T.TM_ID = S.TM_ID
JOIN DWPRODUCT P ON P.P_CODE = S.P_CODE
GROUP BY T.TM_MONTH, P.P_CATEGORY, S.P_CODE
ORDER BY T.TM_MONTH, P.P_CATEGORY, S.P_CODE;
```

Review notes (added now):
- Q6 sorts ascending, so the top buyer is on the bottom row instead of the top; the question asked for highest first (`ORDER BY ... DESC`). It also sums `sale_price` without multiplying by `sale_units`, unlike Q1 to Q3. The submitted output still identifies 10015 (O'Brian) as the September top buyer at 310.83.
- Q9 as submitted lists the three tables in `FROM` with no join predicates, so it computes a Cartesian product: every product shows the same 108 (Sept) or 72 (Oct) rows and the same sales totals, and the output does not answer the question. A corrected query (join on `tm_id` and `p_code`, `SUM(sale_units)`, filter by month) is included in `sql/warehouse/saleco-dw-bi-queries.sql` without output, since the warehouse is not available to rerun it.
- From Q10's output, the highest row counts in September are 23109-HB (5 rows) and 13-Q2/P2 and 54778-2T (4 rows each). Those are line counts, not units, so they are not a substitute for the Q9 answer.

## What the two halves show

The same kind of question costs different amounts in each model. On the OLTP side, "sales by customer" means joining `INVOICE` to `LINE` and computing price times units on every read. In the warehouse the grain is already one row per sale in `DWDAYSALESFACT`, the measure columns (`SALE_UNITS`, `SALE_PRICE`) sit on the fact, and month, region, and category are one join away in a dimension. That is what makes `ROLLUP` and `CUBE` cheap to express: Q2 gets region subtotals and a grand total, and Q3 adds per-customer totals across regions, from a single statement over one fact and one dimension. [`sql/warehouse/classicmodels-oper-vs-analytical.sql`](../sql/warehouse/classicmodels-oper-vs-analytical.sql) makes the same point on ClassicModels, where the operational query needs a four-table join through `orders` and `orderdetails` and the dimensional query goes straight from `factOrderDetails` to its dimensions.
