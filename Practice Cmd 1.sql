--1st Cmd
SELECT * FROM products;

--2nd Cmd
SELECT 
	name,
	price 
FROM products;

--3rd Cmd
SELECT 
	first_name,
	last_name
FROM users;

--4th Cmd
SELECT 
	first_name,
	last_name,
	city
FROM users;

--5th CMD
SELECT 
	products.price
FROM products
WHERE price > 100;

--6th Cmd
SELECT * FROM products
WHERE 
	department = 'Electronics';

--7th Cmd
SELECT * FROM orders
WHERE 
	paid = true;

--8th Cmd
SELECT * FROM products
WHERE 
	weight < 5;

--9th CMD
SELECT * FROM users
WHERE 
	city = 'Seattle';

--10th Cmd
SELECT * FROM products
WHERE 
	price > 20 AND price < 60;

--11th Cmd
SELECT * FROM products
WHERE 
	department IN ('Grocery', 'Clothes');

--12th I saw it from result 
SELECT * FROM products
WHERE name LIKE 'C%';

-- 2nd Section

SELECT * FROM products
ORDER BY price;

SELECT * FROM products
ORDER BY price DESC;

SELECT * FROM products
ORDER BY 
	price DESC 
LIMIT 3;

SELECT * FROM products
ORDER BY 
	price 
LIMIT 1;

SELECT last_name FROM users
ORDER BY 
	last_name;

-- 3rd Section
--I saw the answer
SELECT COUNT(*) FROM products;

SELECT MAX(price) FROM products;

SELECT MIN(price) FROM products;

SELECT AVG(price) FROM products; 
--OR--
 SELECT FLOOR(AVG(price)) FROM products;

SELECT SUM(price) FROM products;

SELECT COUNT(*) 
FROM
	orders
WHERE 
	paid = true;

--4th Section

SELECT 
	products.department,
	COUNT(stock)
FROM products
GROUP BY products.department;

SELECT 
	products.department,
	FLOOR(AVG(price))
FROM products
GROUP BY products.department;

SELECT 
	orders.product_id,
	COUNT(quantity) AS Quantity
FROM orders
GROUP BY orders.product_id;

SELECT 
	products.department,
	COUNT(stock)
FROM products
GROUP BY products.department;

-- SAW ans
SELECT 
	users.city,
	COUNT(*)
FROM users
GROUP BY users.city;

SELECT 
	products.department,
	COUNT(*)
FROM products
GROUP BY 
		products.department
HAVING COUNT(*) > 1;

SELECT 
	orders.user_id,
	COUNT(*)
FROM orders
GROUP BY 
	orders.user_id
HAVING 
 	COUNT(*) > 2;

    SELECT 
    products.department,
    FLOOR(AVG(price)) AS avg_price_floor
FROM products
GROUP BY products.department
HAVING FLOOR(AVG(price)) > 50;   

SELECT 
    users.city,
	COUNT(*)
FROM users
GROUP BY users.city
HAVING COUNT(*) > 2;   

-- 6th Section

SELECT 
    orders.id,
	users.first_name
FROM users
JOIN orders ON orders.id = users.id;

SELECT 
    orders.id,
	products.name
FROM products
JOIN orders ON orders.id = products.id;

SELECT 
    orders.id,
	products.name,
	products.price
FROM products
JOIN orders ON orders.id = products.id;

SELECT 
    users.first_name,
	products.name
FROM orders
JOIN users ON users.id = orders.user_id 
JOIN products ON products.id = orders.product_id;

SELECT 
    users.first_name,
	products.name,
	orders.paid
FROM orders
JOIN users ON users.id = orders.user_id 
JOIN products ON products.id = orders.product_id;

SELECT 
    users.first_name,
	products.name,
	orders.quantity,
	orders.paid
FROM orders
JOIN users ON users.id = orders.user_id 
JOIN products ON products.id = orders.product_id
WHERE orders.paid = true;

-- This is working too
SELECT 
	users.first_name,
	orders.quantity,
FROM orders
JOIN users ON users.id = orders.user_id;

SELECT 
    users.first_name,
    products.name,
    SUM(orders.quantity * products.price) AS spent_on_product
FROM orders
JOIN users ON users.id = orders.user_id
JOIN products ON products.id = orders.product_id
GROUP BY users.id, users.first_name, products.id, products.name;   

SELECT 
	products.department,
	SUM (products.price * orders.quantity)
FROM orders
JOIN products ON products.id = orders.product_id
GROUP BY products.department

ELECT SUM(products.price * orders.quantity)
FROM orders
JOIN products ON products.id = orders.product_id
WHERE orders.paid = true;

