/*	1	*/
SELECT category_name, count(instrument_id) AS instrument_count,
max(list_price) AS most_expensive_instrument
FROM instruments i
JOIN categories c ON i.category_id = c.category_id
GROUP BY i.category_id
ORDER BY instrument_count DESC;

/*	2	*/
SELECT m.email_address, sum(oi.item_price * oi.quantity) AS item_price_total,
sum(oi.discount_amount * oi.quantity) AS discount_amount_total
FROM musicians m 
JOIN orders o ON o.musician_id = m.musician_id
JOIN order_instruments oi ON o.order_id = oi.order_id
GROUP BY m.email_address
ORDER BY item_price_total DESC;

/*	3	*/
SELECT m.email_address, count(DISTINCT(o.order_id)) AS order_count,
sum((item_price - discount_amount)* quantity) AS total FROM orders o
JOIN order_instruments oi ON oi.order_id = o.order_id
JOIN musicians m ON o.musician_id = m.musician_id
GROUP BY o.musician_id HAVING order_count > 1;

/*	4	*/
SELECT m.email_address, count(o.order_id) AS order_count, 
sum((oi.item_price - oi.discount_amount)*quantity) AS order_total
FROM orders o
JOIN order_instruments oi ON oi.order_id = o.order_id
JOIN musicians m ON m.musician_id = o.musician_id
WHERE oi.item_price > 400
GROUP BY o.musician_id HAVING order_count > 1;

/*	5	*/
SELECT i.instrument_name, sum((oi.item_price-oi.discount_amount)*quantity) AS Total
FROM instruments i
JOIN order_instruments oi ON oi.instrument_id = i.instrument_id
GROUP BY i.instrument_name WITH ROLLUP;

/*	6	*/
SELECT m.email_address, COUNT(DISTINCT(oi.instrument_id)) AS number_of_instruments
FROM orders o
JOIN order_instruments oi ON oi.order_id = o.order_id
JOIN musicians m ON m.musician_id = o.musician_id
GROUP BY o.musician_id HAVING number_of_instruments > 1
ORDER BY m.email_address ASC;

/*	7	*/
SELECT IF(GROUPING(c.category_name)=1, 'Grand Total', c.category_name) AS category_name,
IF(GROUPING(i.instrument_name)=1, 'Category Total', i.instrument_name) AS instrument_name,
SUM(oi.quantity) AS qty_purchased
FROM categories c
JOIN instruments i ON c.category_id = i.category_id
JOIN order_instruments oi ON oi.instrument_id = i.instrument_id
GROUP BY c.category_name, i.instrument_name WITH ROLLUP;

/*	8	*/
SELECT o.order_id, ((oi.item_price - oi.discount_amount) * oi.quantity) AS item_price,
SUM((oi.item_price - oi.discount_amount) * oi.quantity) OVER (PARTITION BY o.order_id) AS order_total
FROM orders o JOIN order_instruments oi ON oi.order_id = o.order_id
ORDER BY o.order_id ASC;

/*	9	*/
SELECT o.order_id, ((oi.item_price - oi.discount_amount) * oi.quantity) AS item_price,
SUM((oi.item_price - oi.discount_amount) * oi.quantity) 
OVER (PARTITION BY o.order_id ORDER BY ((oi.item_price - oi.discount_amount) * oi.quantity))
AS order_total,
ROUND(AVG((oi.item_price - oi.discount_amount) * oi.quantity) OVER(PARTITION BY o.order_id) , 2)
AS avg_total
FROM orders o JOIN order_instruments oi ON oi.order_id = o.order_id
ORDER BY o.order_id ASC;

/*	10	*/
SELECT o.musician_id, o.order_date, (oi.item_price - oi.discount_amount)*quantity AS item_total,
	SUM((oi.item_price - oi.discount_amount)*quantity)
OVER
	(PARTITION BY o.musician_id) AS musician_total,
	SUM((oi.item_price - oi.discount_amount)*quantity)
OVER
	(PARTITION BY o.musician_id ORDER BY o.order_date) AS musician_total_by_date
FROM orders o
JOIN musicians m ON m.musician_id = o.musician_id
JOIN order_instruments oi ON oi.order_id = o.order_id
ORDER BY o.musician_id ASC;


/*
SELECT o.order_id, oi.instrument_id, i.instrument_name, oi.quantity from orders o 
JOIN order_instruments oi on oi.order_id = o.order_id
JOIN instruments i on i.instrument_id = oi.instrument_id;
*/