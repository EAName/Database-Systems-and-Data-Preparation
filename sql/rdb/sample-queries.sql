.header on
.mode columns

--.output "output.txt"


.print "\n======== LISTING TABLE CONTENTS - SELECT QUERIES\n"

.print "SELECT * FROM PRODUCT;\n"

SELECT * FROM PRODUCT;

.print

.print "======== SELECT WITH WHERE CLAUSE\n" 

.print "SELECT P_DESCRIPT, P_INDATE, P_PRICE, V_CODE\nFROM   PRODUCT\nWHERE  V_CODE = 21344;\n"

SELECT P_DESCRIPT, P_INDATE, P_PRICE, V_CODE
FROM   PRODUCT
WHERE  V_CODE = 21344;

.print
.print "========Other comparison operators >, >=, <, <=, <>\n"

.print "SELECT P_DESCRIPT, P_INDATE, P_PRICE, V_CODE\nFROM   PRODUCT\nWHERE  V_CODE <> 21344;\n"

SELECT P_DESCRIPT, P_INDATE, P_PRICE, V_CODE
FROM   PRODUCT
WHERE  V_CODE <> 21344;

.print 

.print "SELECT P_DESCRIPT, P_QOH, P_MIN, P_PRICE\nFROM   PRODUCT\nWHERE  P_PRICE <= 10;\n"

SELECT P_DESCRIPT, P_QOH, P_MIN, P_PRICE
FROM   PRODUCT
WHERE  P_PRICE <= 10;

.print  

.print "\n========Using computed columns and aliases\n" 

.print

.print "SELECT P_DESCRIPT, P_QOH, P_PRICE, P_QOH*P_PRICE\nFROM   PRODUCT;\n"

SELECT P_DESCRIPT, P_QOH, P_PRICE, P_QOH*P_PRICE
FROM   PRODUCT;

.print

.print "SELECT P_DESCRIPT, P_QOH, P_PRICE, P_QOH*P_PRICE AS TOTVALUE\nFROM   PRODUCT;\n"

SELECT P_DESCRIPT, P_QOH, P_PRICE, P_QOH*P_PRICE AS TOTVALUE
FROM   PRODUCT;

.print
.print "========Logical operators AND, OR, NOT\n"

.print

.print "SELECT P_DESCRIPT, P_QOH, P_PRICE, V_CODE\nFROM   PRODUCT\nWHERE  P_PRICE < 50\nAND    P_QOH > 10;\n"
.print

SELECT P_DESCRIPT, P_QOH, P_PRICE, V_CODE
FROM   PRODUCT
WHERE  P_PRICE < 50
AND    P_QOH > 10;

.print
.print "SELECT P_DESCRIPT, P_QOH, P_PRICE, V_CODE\nFROM   PRODUCT\nWHERE  P_PRICE < 50\nOR    P_QOH > 10;\n"
.print

SELECT P_DESCRIPT, P_QOH, P_PRICE, V_CODE 
FROM   PRODUCT 
WHERE  P_PRICE < 50 
OR    P_QOH > 10;

.print
.print "SELECT * \nFROM   PRODUCT\nWHERE  NOT (V_CODE = 21344);\n"
.print

SELECT *
FROM   PRODUCT
WHERE  NOT (V_CODE = 21344);

.print
.print "========Special operators : BETWEEN, IS NULL, LIKE, IN, EXITS\n"
.print
.print "SELECT *\nFROM   PRODUCT\nWHERE  P_PRICE BETWEEN 50.00 AND 100.00;\n"
.print
SELECT *
FROM   PRODUCT
WHERE  P_PRICE BETWEEN 50.00 AND 100.00;

.print
.print "SELECT P_CODE, P_DESCRIPT\nFROM   PRODUCT\nWHERE  V_CODE IS NULL;\n"
.print

SELECT P_CODE, P_DESCRIPT
FROM   PRODUCT
WHERE  V_CODE IS NULL;

-- Note: MS Access and SQL Server are case insensitive
-- Note: MS Access uses * and %, SQL Server uses % and _

.print
.print "SELECT V_NAME, V_CONTACT, V_AREACODE, V_PHONE\nFROM   VENDOR\nWHERE  V_CONTACT LIKE 'Smith%';\n"
.print
SELECT V_NAME, V_CONTACT, V_AREACODE, V_PHONE
FROM   VENDOR
WHERE  V_CONTACT LIKE 'Smith%';

.print
.print "SELECT *\nFROM   PRODUCT\nWHERE  V_CODE IN (21344, 24288);\n"
.print 

SELECT *
FROM   PRODUCT
WHERE  V_CODE IN (21344, 24288);

.print
.print " ======================= end of demo code =================="

 


