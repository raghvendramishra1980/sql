-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */

SELECT v.vendor_id, COUNT(vba.vendor_id) AS booth_count
FROM vendor AS v
JOIN vendor_booth_assignments AS vba ON v.vendor_id = vba.vendor_id
GROUP BY v.vendor_id; -- Addedins 'AS' as table alias which is absolutely unnecessary

/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */

SELECT cus.customer_first_name,cus.customer_last_name,sum((cp.quantity * cp.cost_to_customer_per_qty)) as total_amount 
from customer as cus 
join customer_purchases as cp on cus.customer_id == cp.customer_id 
GROUP by cus.customer_id
HAVING sum((cp.quantity * cp.cost_to_customer_per_qty)) >2000 
order by  customer_last_name, customer_first_name

--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/

CREATE TEMP TABLE new_vendor AS
SELECT vendor_id,vendor_name,vendor_type,vendor_owner_first_name,vendor_owner_last_name from vendor;
INSERT INTO new_vendor (vendor_id,vendor_name,vendor_type,vendor_owner_first_name,vendor_owner_last_name)
VALUES (10,'Thomass Superfood Store','Fresh Focused store,','Thomas', 'Rosenthal');

-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.

HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month 
and year are! */

SELECT 
customer_id,
strftime('%m',market_date) as "Month",strftime('%Y',market_date) as "Year"
FROM  customer_purchases

/* 2. Using the previous query as a base, determine how much money each customer spent in April 2019. 
Remember that money spent is quantity*cost_to_customer_per_qty. 

HINTS: you will need to AGGREGATE, GROUP BY, and filter...
but remember, STRFTIME returns a STRING for your WHERE statement!! */

SELECT customer_id,Sum((quantity*cost_to_customer_per_qty)) as amount FROM  customer_purchases 
where strftime('%m',market_date) == '04' and 
strftime('%Y',market_date) == '2019'
GROUP by customer_id 