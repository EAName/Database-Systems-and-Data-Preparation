-- Business intelligence queries on the SaleCo OLTP schema (SQLite).
-- Transcribed from "Business Intelligence SQL Queries RDB.pdf"; see docs/bi-queries.md.
-- Run: sqlite3 data/sample/SalesCO.db < sql/rdb/bi-queries-saleco.sql
-- "As submitted" queries are kept verbatim; "Corrected" variants follow where the
-- submitted query did not fully answer the question.

.header on
.mode columns

-- Q1: number of invoices; invoice numbers and dates
SELECT COUNT(*) FROM invoice;
SELECT inv_number, inv_date FROM invoice;

-- Q2: number of customers; customer codes and names
SELECT COUNT(*) FROM customer;
SELECT cus_code, cus_lname, cus_fname FROM customer;

-- Q3: vendor codes and names; vendor count per state
SELECT v_code, v_name FROM vendor;
-- As submitted (counts all vendors):
SELECT COUNT(v_state) FROM vendor;
-- Corrected (per state):
SELECT v_state, COUNT(*) AS vendor_count FROM vendor GROUP BY v_state ORDER BY v_state;

-- Q4: most expensive product and its quantity on hand
SELECT MAX(p_price) FROM product;
-- As submitted (SQLite returns the row holding the MAX):
SELECT MAX(p_price) AS price, p_qoh, p_descript FROM product;
-- Portable:
SELECT p_price, p_qoh, p_descript FROM product WHERE p_price = (SELECT MAX(p_price) FROM product);

-- Q5: customers with a balance over $500
SELECT COUNT(cus_code) AS cus_count FROM customer WHERE cus_balance > 500;
SELECT cus_code, cus_lname, cus_fname, cus_balance FROM customer WHERE cus_balance > 500;

-- Q6: products offered by each vendor, sorted by vendor name and product code
-- As submitted:
SELECT product.p_code, product.v_code, vendor.v_name
FROM product, vendor
WHERE product.v_code = vendor.v_code;
-- Corrected (requested sort and product name):
SELECT v.v_name, p.p_code, p.p_descript
FROM product p JOIN vendor v ON p.v_code = v.v_code
ORDER BY v.v_name, p.p_code;

-- Q7: customer purchases with line subtotals, sorted by customer, invoice, line
-- As submitted:
SELECT invoice.cus_code, invoice.inv_number, line.line_number, line.line_price
FROM invoice, line
WHERE invoice.inv_number = line.inv_number;
-- Corrected (subtotal = units * price, explicit sort):
SELECT i.cus_code, i.inv_number, l.line_number, l.line_units, l.line_price,
       l.line_units * l.line_price AS line_subtotal
FROM invoice i JOIN line l ON i.inv_number = l.inv_number
ORDER BY i.cus_code, i.inv_number, l.line_number;

-- Q8: balances of customers who appear in INVOICE, sorted by customer code
-- As submitted (the trailing "AND customer.cus_balance" drops zero balances):
SELECT invoice.cus_code, customer.cus_balance
FROM invoice, customer
WHERE invoice.cus_code = customer.cus_code AND customer.cus_balance;
-- Corrected:
SELECT DISTINCT c.cus_code, c.cus_balance
FROM customer c JOIN invoice i ON i.cus_code = c.cus_code
ORDER BY c.cus_code;

-- Q9: customers with no purchases during the invoicing period
SELECT cus_code AS zero_purchases FROM customer
WHERE cus_code NOT IN (SELECT cus_code FROM invoice)
ORDER BY cus_code;

-- Q10: value of products currently in inventory
SELECT (p_qoh * p_price) AS value, p_code FROM product;
