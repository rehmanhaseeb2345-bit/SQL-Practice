

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name  VARCHAR(50),
  city       VARCHAR(50)
);

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name       VARCHAR(50),
  department VARCHAR(50),
  price      INT,
  weight     INT,
  stock      INT
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id    INT REFERENCES users(id),
  product_id INT REFERENCES products(id),
  quantity   INT,
  paid       BOOLEAN
);

INSERT INTO users (first_name, last_name, city) VALUES
('Iva','Lindgren','Portland'), ('Ignatius','Johns','Seattle'),
('Jannie','Boehm','Portland'), ('Neal','Wehner','Austin'),
('Mikayla','Casper','Seattle'), ('Omer','Kunde','Austin'),
('Meta','Gulgowski','Portland'), ('Rebeca','Cronin','Denver'),
('Malachi','Little','Seattle'), ('Ken','Bahringer','Denver');

INSERT INTO products (name, department, price, weight, stock) VALUES
('Shirt','Clothes',40,3,120), ('Towels','Outdoors',25,16,60),
('Bacon','Grocery',10,6,200), ('Ball','Toys',15,23,0),
('Fish','Grocery',30,10,45), ('Mouse','Electronics',55,1,80),
('Computer','Electronics',899,2,12), ('Hat','Clothes',22,1,90),
('Keyboard','Electronics',70,2,30), ('Chair','Home',120,40,8),
('Lamp','Home',45,5,25), ('Cheese','Grocery',18,4,150);

INSERT INTO orders (user_id, product_id, quantity, paid) VALUES
(5,4,2,true),(3,2,1,true),(4,6,3,false),(5,3,5,true),(1,1,1,false),
(2,7,1,true),(6,12,4,true),(3,6,2,true),(8,10,1,false),(5,9,1,true),
(1,3,10,true),(7,5,2,false),(9,1,3,true),(4,5,1,true),(2,8,2,true),
(2,7,1,false),(6,3,6,true),(3,12,3,true),(8,6,1,true),(5,1,2,false),
(9,5,4,true),(1,10,1,true),(7,8,1,false),(4,3,2,true);