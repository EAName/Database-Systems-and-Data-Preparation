-- Business intelligence queries on the saleco_dw star schema (PostgreSQL).
-- Transcribed from "Business Intelligence SQL Queries Data Warehouse.pdf"; see docs/bi-queries.md.
-- The saleco_dw DDL was supplied by the course and is not in this repository.
-- Tables referenced: DWDAYSALESFACT (fact), DWCUSTOMER, DWPRODUCT, DWTIME (dimensions).

-- Q1: total sales by region and customer
SELECT C.REG_ID, S.CUS_CODE, SUM(S.SALE_UNITS*S.SALE_PRICE) AS TOTAL_SALES
FROM DWDAYSALESFACT S JOIN DWCUSTOMER C ON S.CUS_CODE = C.CUS_CODE
GROUP BY C.REG_ID, S.CUS_CODE
ORDER BY C.REG_ID, S.CUS_CODE;

-- Q2: same, with ROLLUP (adds region subtotals and a grand total)
SELECT C.REG_ID, S.CUS_CODE, SUM(S.SALE_UNITS*S.SALE_PRICE) AS TOTAL_SALES
FROM DWDAYSALESFACT S JOIN DWCUSTOMER C ON S.CUS_CODE = C.CUS_CODE
GROUP BY ROLLUP (C.REG_ID, S.CUS_CODE);

-- Q3: same, with CUBE (adds customer totals across regions as well)
SELECT C.REG_ID, S.CUS_CODE, SUM(S.SALE_UNITS*S.SALE_PRICE) AS TOTAL_SALES
FROM DWDAYSALESFACT S JOIN DWCUSTOMER C ON S.CUS_CODE = C.CUS_CODE
GROUP BY CUBE (C.REG_ID, S.CUS_CODE);

-- Q5: sales by customer, month, and product
SELECT dwdaysalesfact.cus_code, dwdaysalesfact.p_code, dwdaysalesfact.sale_price, dwtime.tm_month
FROM dwdaysalesfact LEFT JOIN dwtime ON dwdaysalesfact.tm_id = dwtime.tm_id
ORDER BY cus_code, tm_month;

-- Q6: September purchases by customer (as submitted; sorted ascending)
SELECT dwdaysalesfact.cus_code, dwcustomer.cus_lname, SUM(dwdaysalesfact.sale_price) AS total_sales
FROM dwdaysalesfact
JOIN dwtime ON dwdaysalesfact.tm_id = dwtime.tm_id
JOIN dwcustomer ON dwdaysalesfact.cus_code = dwcustomer.cus_code
WHERE dwtime.tm_month = 9
GROUP BY dwdaysalesfact.cus_code, dwcustomer.cus_lname
ORDER BY SUM(dwdaysalesfact.sale_price);

-- Q6 corrected: units * price, highest first
SELECT S.CUS_CODE, C.CUS_LNAME, SUM(S.SALE_UNITS*S.SALE_PRICE) AS TOTAL_SALES
FROM DWDAYSALESFACT S
JOIN DWTIME T ON S.TM_ID = T.TM_ID
JOIN DWCUSTOMER C ON S.CUS_CODE = C.CUS_CODE
WHERE T.TM_MONTH = 9
GROUP BY S.CUS_CODE, C.CUS_LNAME
ORDER BY TOTAL_SALES DESC;

-- Q7: total sales by month and product category
SELECT T.TM_MONTH, P.P_CATEGORY, SUM(S.SALE_UNITS*S.SALE_PRICE) AS TOTAL_SALES
FROM DWTIME T JOIN DWDAYSALESFACT S ON T.TM_ID = S.TM_ID
JOIN DWPRODUCT P ON P.P_CODE = S.P_CODE
GROUP BY T.TM_MONTH, P.P_CATEGORY
ORDER BY T.TM_MONTH, P.P_CATEGORY;

-- Q8: number of sale rows and total sales by month
SELECT T.TM_MONTH, COUNT(S.TM_ID) AS PRODUCT_SALES, SUM(S.SALE_UNITS*S.SALE_PRICE) AS TOTAL_SALES
FROM DWDAYSALESFACT S JOIN DWTIME T ON S.TM_ID = T.TM_ID
GROUP BY TM_MONTH
ORDER BY TM_MONTH DESC;

-- Q9 as submitted: no join predicates, so this is a Cartesian product.
-- Kept for the record; do not use.
-- SELECT dwproduct.p_code, dwproduct.p_category, dwtime.tm_month,
--        COUNT(dwdaysalesfact.cus_code) AS row, SUM(dwdaysalesfact.sale_price) AS sales
-- FROM dwdaysalesfact, dwtime, dwproduct
-- GROUP BY dwproduct.p_code, dwproduct.p_category, dwtime.tm_month
-- ORDER BY dwproduct.p_code DESC;

-- Q9 corrected (not run; warehouse not available): units sold per product, per month.
-- Run once with TM_MONTH = 9 (a) and once with TM_MONTH = 10 (b); top row is the best seller.
SELECT P.P_CATEGORY, P.P_CODE, P.P_DESCRIPT, SUM(S.SALE_UNITS) AS UNITS_SOLD
FROM DWDAYSALESFACT S
JOIN DWPRODUCT P ON P.P_CODE = S.P_CODE
JOIN DWTIME T ON T.TM_ID = S.TM_ID
WHERE T.TM_MONTH = 9
GROUP BY P.P_CATEGORY, P.P_CODE, P.P_DESCRIPT
ORDER BY UNITS_SOLD DESC;

-- Q10: number of sale rows and total sales by month, category, and product
SELECT T.TM_MONTH, P.P_CATEGORY, S.P_CODE, COUNT(S.TM_ID) AS PRODUCT, SUM(S.SALE_UNITS*S.SALE_PRICE) AS SALES
FROM DWTIME T JOIN DWDAYSALESFACT S ON T.TM_ID = S.TM_ID
JOIN DWPRODUCT P ON P.P_CODE = S.P_CODE
GROUP BY T.TM_MONTH, P.P_CATEGORY, S.P_CODE
ORDER BY T.TM_MONTH, P.P_CATEGORY, S.P_CODE;
