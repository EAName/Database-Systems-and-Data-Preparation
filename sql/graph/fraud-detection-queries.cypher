// Fraud-detection queries against the graph seeded by fraud-detection.cypher (Neo4j).
// Transcribed from "Fraud Detection Cypher Query Language.pdf"; see docs/fraud-detection-cypher.md.
// Q2 to Q5 were provided by the course; Q6 to Q9 are the written answers.

// Q2: retailers
MATCH (r:Retailer) RETURN (r);

// Q3: employees
MATCH (e:Employee) RETURN (e);

// Q4: customers
MATCH (c:Customer) RETURN (c);

// Q5: all disputed transactions, newest first
MATCH (customer:Customer)-[transaction:SHOPPED_AT]->(retailer)
WHERE transaction.status = "Disputed"
RETURN customer.name AS `Customer Name`, retailer.name AS `Retailer Name`,
       transaction.amount AS `TransactionAmount`, transaction.date AS `Transaction date`
ORDER BY `Transaction date` DESC;

// Q6: number of disputed transactions per retailer
MATCH (customer:Customer)-[transaction:SHOPPED_AT]->(retailer)
WHERE transaction.status = "Disputed"
RETURN retailer.name, count(*);

// Q7 as submitted: disputed transactions per (customer, retailer) pair
MATCH (customer:Customer)-[transaction:SHOPPED_AT]->(retailer)
WHERE transaction.status = "Disputed"
RETURN customer.name, retailer.name, count(*);

// Q7 alternative: one row per retailer with the count and the list of customers
MATCH (customer:Customer)-[transaction:SHOPPED_AT]->(retailer)
WHERE transaction.status = "Disputed"
RETURN retailer.name AS `Retailer Name`, count(*) AS `Disputed`,
       collect(DISTINCT customer.name) AS `Customers`
ORDER BY `Disputed` DESC;

// Q8: customers with more than one disputed transaction
MATCH (customer:Customer)-[transaction:SHOPPED_AT]->(retailer)
WHERE transaction.status = "Disputed"
WITH customer.name AS `Customer Name`, COUNT(*) AS `Number of Disputed Transactions`
WHERE `Number of Disputed Transactions` > 1
RETURN `Customer Name`, `Number of Disputed Transactions`;

// Q9: stores on LaSalle Street with disputed transactions, sorted by store name
MATCH (customer:Customer)-[transaction:SHOPPED_AT]->(retailer)
WHERE retailer.street CONTAINS 'LaSalle' AND transaction.status = "Disputed"
RETURN retailer.name AS `Retailer Name`, COUNT(*), COLLECT(retailer.street)
ORDER BY `Retailer Name` ASC;
