--SELECT
/* 1. Write a query that returns everything in the customer table. */

SELECT CUSTOMER_ID, CUSTOMER_FIRST_NAME, CUSTOMER_LAST_NAME FROM CUSTOMER

/* 2. Write a query that displays all of the columns and 10 rows from the cus- tomer table, 
sorted by customer_last_name, then customer_first_ name. */

SELECT TOP 10 CUSTOMER_ID, CUSTOMER_FIRST_NAME, CUSTOMER_LAST_NAME FROM CUSTOMER 
ORDER BY CUSTOMER_LAST_NAME CUSTOMER_FIRST_NAME


--WHERE
/* 1. Write a query that returns all customer purchases of product IDs 4 and 9. */
-- option 1
SELECT product_id,vendor_id, market_date, customer_id, quantity, cost_to_customer_per_qty,
transaction_time FROM customer_purchases WHERE product_id IN (4,9)
-- option 2
SELECT product_id,vendor_id, market_date, customer_id, quantity, cost_to_customer_per_qty,
transaction_time FROM customer_purchases WHERE product_id = 9 OR product_id = 4 

/*2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), 
filtered by vendor IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	2.  one condition using BETWEEN
*/
-- option 1
SELECT product_id,vendor_id, market_date, customer_id, quantity, cost_to_customer_per_qty,
transaction_time, (quantity * cost_to_customer_per_qty) AS 'price' FROM customer_purchases 
where vendor_id>=8 and vendor_id<=10
-- option 2
SELECT product_id,vendor_id, market_date, customer_id, quantity, cost_to_customer_per_qty,
transaction_time, (quantity * cost_to_customer_per_qty) AS 'price' FROM customer_purchases 
where vendor_id BETWEEN 8 and 10
--CASE
/* 1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. 
Using the product table, write a query that outputs the product_id and product_name
columns and add a column called prod_qty_type_condensed that displays the word “unit” 
if the product_qty_type is “unit,” and otherwise displays the word “bulk.” */

SELECT product_id, product_name, 
CASE 
	WHEN product_qty_type == 'unit' THEN 'unit'
	ELSE 'bulk'
	END
as prod_qty_type_condensed 
FROM product
/* 2. We want to flag all of the different types of pepper products that are sold at the market. 
add a column to the previous query called pepper_flag that outputs a 1 if the product_name 
contains the word “pepper” (regardless of capitalization), and otherwise outputs 0. */
SELECT product_id, product_name, 
CASE 
	WHEN product_qty_type == 'unit' THEN 'unit'
	ELSE 'bulk'
END
as prod_qty_type_condensed ,
CASE
	WHEN product_name like '%pepper%' THEN 1
	ELSE 0
END
pepper_flag
FROM product

--JOIN
/* 1. Write a query that INNER JOINs the vendor table to the vendor_booth_assignments table on the 
vendor_id field they both have in common, and sorts the result by vendor_name, then market_date. */
SELECT vn.vendor_id,vn.vendor_name,vn.vendor_type,vn.vendor_owner_first_name,vn.vendor_owner_last_name  from vendor  vn 
INNER JOIN vendor_booth_assignments vba on vn.vendor_id = vba.vendor_id 
ORDER by vn.vendor_name, vba.market_date