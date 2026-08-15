-- USERS
CREATE TABLE users (
  id         SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name  VARCHAR(50)
);

-- PRODUCTS
CREATE TABLE products (
  id         SERIAL PRIMARY KEY,
  name       VARCHAR(50),
  department VARCHAR(50),
  price      INT,
  weight     INT
);

-- ORDERS (references both users and products)
CREATE TABLE orders (
  id         SERIAL PRIMARY KEY,
  user_id    INT REFERENCES users(id),
  product_id INT REFERENCES products(id),
  paid       BOOLEAN
);


-- --------------------------------
-- DATA
-- --------------------------------

INSERT INTO users (id, first_name, last_name) VALUES
(1, 'Iva',      'Lindgren'),
(2, 'Ignatius', 'Johns'),
(3, 'Jannie',   'Boehm'),
(4, 'Neal',     'Wehner'),
(5, 'Mikayla',  'Casper');

INSERT INTO products (id, name, department, price, weight) VALUES
(1, 'Shirt',    'Toys',       876, 3),
(2, 'Towels',   'Outdoors',   412, 16),
(3, 'Bacon',    'Movies',     10,  6),
(4, 'Ball',     'Industrial', 328, 23),
(5, 'Fish',     'Tools',      796, 10),
(6, 'Mouse',    'Grocery',    989, 11),
(7, 'Computer', 'Home',       298, 2);

INSERT INTO orders (id, user_id, product_id, paid) VALUES
(1, 5, 4, true),
(2, 3, 2, true),
(3, 4, 6, false),
(4, 5, 3, true),
(5, 1, 1, false);