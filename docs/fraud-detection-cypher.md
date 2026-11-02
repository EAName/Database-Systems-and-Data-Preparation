# Fraud detection with Neo4j and Cypher

Source: [`Fraud Detection Cypher Query Language.pdf`](../Fraud%20Detection%20Cypher%20Query%20Language.pdf) (11 pages, mostly Neo4j Browser screenshots). Queries and results were transcribed from the page images. The seed script is [`sql/graph/fraud-detection.cypher`](../sql/graph/fraud-detection.cypher) and the queries are collected in [`sql/graph/fraud-detection-queries.cypher`](../sql/graph/fraud-detection-queries.cypher).

## The graph

Loaded by running the whole seed script at the `neo4j$` prompt. The Browser overview in the PDF (`MATCH (n) RETURN n`) shows 60 nodes and 136 relationships:

| Node label | Count | Key properties |
|------------|-------|----------------|
| `Customer` | 20 | name |
| `Employee` | 20 | name, age, phone |
| `Retailer` | 10 | name, street, city, state, zip |
| `Account` | 10 | login_id (for example `abc125`, `xyz123`), last delivery-notification date |

| Relationship | Count | Meaning |
|--------------|-------|---------|
| `(:Customer)-[:SHOPPED_AT {amount, date, status}]->(:Retailer)` | 84 | a card transaction; `status` is `Disputed` or `Approved` |
| `(:Employee)-[:WORKS_AT]->(:Retailer)` | 27 | employment |
| `(:Customer)-[:HAS_MEMBERSHIP_AT {reward_points, member_since}]->(:Retailer)` | 13 | loyalty membership |
| `(:Customer)-[:USES_ACCOUNT]->(:Account)` | 12 | account usage |

The counts match the `CREATE` statements in the seed script (33 of the 84 `SHOPPED_AT` edges are `Disputed`).

## Queries and results

### Q5: list all disputed transactions (provided)

```cypher
MATCH (customer:Customer)-[transaction:SHOPPED_AT]->(retailer)
WHERE transaction.status = "Disputed"
RETURN customer.name AS `Customer Name`, retailer.name AS `Retailer Name`,
       transaction.amount AS `TransactionAmount`, transaction.date AS `Transaction date`
ORDER BY `Transaction date` DESC
```

Result: 33 records. Note that `date` is stored as a string (`'7/17/2020'`), so this sort is lexicographic, not chronological.

### Q6: number of disputed transactions per retailer

```cypher
MATCH (customer:Customer)-[transaction:SHOPPED_AT]->(retailer)
WHERE transaction.status = "Disputed"
RETURN retailer.name, count(*)
```

| Retailer | Disputed |
|----------|---------:|
| Walmart | 7 |
| Nordstrom | 6 |
| Neiman Marcus | 4 |
| Kohls | 4 |
| Express | 4 |
| BestBuy | 3 |
| Foot Locker | 2 |
| Coach | 2 |
| Target | 1 |

### Q7: disputed transactions and customer names per retailer

As submitted, this groups by customer and retailer, returning one row per pair (32 records), for example Edgar Haroop / Walmart 2, Edgar Haroop / Nordstrom 1, Rigoberto Kinchen / Express 1.

```cypher
MATCH (customer:Customer)-[transaction:SHOPPED_AT]->(retailer)
WHERE transaction.status = "Disputed"
RETURN customer.name, retailer.name, count(*)
```

The question asked for one row per retailer with the list of customers. The idiomatic form uses `collect()`; it is in the `.cypher` file as an alternative (not run against the course database).

### Q8: customers with more than one disputed transaction

```cypher
MATCH (customer:Customer)-[transaction:SHOPPED_AT]->(retailer)
WHERE transaction.status = "Disputed"
WITH customer.name AS `Customer Name`, COUNT(*) AS `Number of Disputed Transactions`
WHERE `Number of Disputed Transactions` > 1
RETURN `Customer Name`, `Number of Disputed Transactions`
```

Result: 7 records. Rows 2 to 7 are visible in the screenshot: Torri Pettway 2, Rigoberto Kinchen 4, Zenaida Sitzes 4, Jonathan Rinka 3, Richard Smith 2, Larry Grahamr 2. Row 1 is cut off in the PDF; counting the seed script gives Edgar Haroop with 5.

### Q9: stores on LaSalle Street with disputed transactions

```cypher
MATCH (customer:Customer)-[transaction:SHOPPED_AT]->(retailer)
WHERE retailer.street CONTAINS 'LaSalle' AND transaction.status = "Disputed"
RETURN retailer.name AS `Retailer Name`, COUNT(*), COLLECT(retailer.street)
ORDER BY `Retailer Name` ASC
```

| Retailer | Disputed | Street |
|----------|---------:|--------|
| Neiman Marcus | 4 | 610 South LaSalle |
| Nordstrom | 6 | 45 North LaSalle |

## Why a graph for this problem

The classic card-fraud question is "which merchant do the disputed cards have in common?", which is the point of compromise. In a relational model that is a self-join of a transactions table filtered on disputed status, grouped by merchant, and it gets harder with each extra hop (for example, from the compromised merchant to the employees who work there, or to the accounts the same customers use). In the graph, transactions are typed, attributed edges between customers and retailers, so the same question is a one-pattern `MATCH` and an extra hop is one more segment in the pattern. Q6 and Q9 point at Walmart, Nordstrom, and the two LaSalle Street stores; the natural next query (not in the assignment) is `(:Employee)-[:WORKS_AT]->(r)` on those retailers.

Data-quality issues visible in the results: several customer names carry leading and trailing spaces (`" Torri Pettway "`), amounts and dates are strings, and one name looks misspelled (`Larry Grahamr`). In a real pipeline those would be cleaned at load time and the properties typed (`toInteger`, `date()`).
