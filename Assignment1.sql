/* 1 */
SELECT instrument_name, list_price, date_added 
FROM instruments 
WHERE list_price > 500 AND list_price < 2000 
ORDER BY date_added DESC;

/* 2 */
SELECT item_id, item_price, discount_amount, quantity, 
item_price*quantity AS price_total,
discount_amount*quantity AS discount_total, 
(item_price-discount_amount) * quantity AS item_total
FROM order_instruments 
WHERE (item_price-discount_amount) * quantity > 500
ORDER BY (item_price-discount_amount) * quantity DESC;

/* 3 */
SELECT NOW()+0 AS today_unformatted, NOW() AS today_formatted;


/* 4 */
SELECT first_name, last_name, line1, city, state, zip_code
FROM addresses
JOIN musicians m on m.musician_id = addresses.musician_id
WHERE email_address = 'david.goldstein@hotmail.com';

/* 5 ? */
SELECT first_name, last_name, line1, city, state, zip_code
FROM addresses
JOIN musicians on musicians.musician_id = addresses.musician_id
WHERE billing_address_id = address_id;

select * from addresses 
join musicians on musicians.musician_id = addresses.musician_id;

select * from addresses 
left join musicians on musicians.musician_id = addresses.musician_id;

select * from addresses 
right join musicians on musicians.musician_id = addresses.musician_id;

/* 6 */
SELECT last_name, first_name, order_date,
instrument_name, item_price, discount_amount, quantity
FROM musicians m JOIN orders o ON m.musician_id = o.musician_id
JOIN order_instruments oi ON o.order_id = oi.order_id
JOIN instruments i ON oi.instrument_id = i.instrument_id
ORDER BY CONCAT(last_name, ', ', order_date, ', ', instrument_name) desc;

/* 7 */ /* self join */
SELECT i1.instrument_name, i1.list_price 
FROM instruments i1 JOIN instruments i2 
ON i1.list_price = i2.list_price and i1.instrument_id <> i2.instrument_id
ORDER BY i1.instrument_name DESC;

/* 8 */
	SELECT order_id, order_date, 'NOT SHIPPED' AS shipped FROM orders
	WHERE ship_date IS NULL
UNION
	SELECT order_id, order_date, 'SHIPPED' AS shipped FROM orders
	WHERE ship_date IS NOT NULL;

