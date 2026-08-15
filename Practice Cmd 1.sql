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