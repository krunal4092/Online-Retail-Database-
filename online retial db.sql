CREATE DATABASE IF NOT EXISTS onlineretaildb;
USE onlineretaildb;


CREATE TABLE category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    zipcode VARCHAR(20),
    country VARCHAR(50)
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2),
    stock INT,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE orderitems (
    orderitem_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO category (category_name) VALUES ('Electronics'), ('Clothing'), ('Books');

INSERT INTO customers (firstname, lastname, email, phone, address, city, state, zipcode, country)
VALUES 
('sameer','khanna','sameer.khanna@example.com','123-456-7890','123 elm st','springfield','il','62701','usa'),
('jane','smith','jane.smith@example.com','234-567-8901','456 oak st.','madison','wi','53703','usa'),
('harshad','patel','harshad.patel@example.com','345-678-9012','789 dalal st.','mumbai','maharashtra','411032','india'),
('ishwar','panchariya','ishwar.panchariya@example.com','79563265953','123 elm st','springfield','il','62701','usa');

INSERT INTO products (product_name, category_id, price, stock)
VALUES 
('Smartphone', 1, 699.99, 10),
('Laptop', 1, 999.99, 5),
('T-Shirt', 2, 19.99, 20),
('Jeans', 2, 49.99, 15),
('Novel', 3, 14.99, 30),
('Notebook', 3, 29.99, 25),
('keyword', 1, 45.99, 0);

INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (1,CURRENT_TIMESTAMP(),719.98), (2,CURRENT_TIMESTAMP(),49.99), (3,CURRENT_TIMESTAMP(),44.98);

INSERT INTO orderitems (order_id, product_id, quantity, price)
VALUES 
(1,1,1,699.99),
(1,3,1,19.99),
(2,4,1,49.99),
(3,5,1,14.99),
(3,6,1,29.99);


SELECT * FROM category;
SELECT * FROM customers;
SELECT * FROM orderitems;
SELECT * FROM orders;
SELECT * FROM products;

SELECT order_id FROM orders;

SELECT o.order_id,o.order_date,o.total_amount,p.product_id,p.product_name,oi.quantity,oi.price 
FROM orders o
JOIN orderitems oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.customer_id = 1;

SELECT p.product_id, p.product_name, SUM(oi.quantity * oi.price) AS total_sales
FROM orderitems oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC;

SELECT AVG(total_amount) AS 'average of order' FROM orders;

SELECT c.customer_id, c.firstname, c.lastname, SUM(total_amount) AS total_spend
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.firstname, c.lastname
ORDER BY total_spend DESC
LIMIT 5;

SELECT c.category_id, c.category_name, SUM(quantity) AS total_quantity_spend
FROM orderitems oi
JOIN products p ON oi.product_id = p.product_id
JOIN category c ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_quantity_spend DESC;

SELECT p.product_id, p.product_name, c.category_id, c.category_name 
FROM products p 
JOIN category c ON p.category_id = c.category_id
WHERE p.stock = 0;

SELECT c.customer_id , c.firstname, c.lastname, c.email, c.phone
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= NOW() - INTERVAL 30 DAY;

SELECT COUNT(order_id) AS totalorders, YEAR(order_date) AS orderyear, MONTH(order_date) AS ordermonth
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY orderyear, ordermonth;

SELECT c.customer_id, c.firstname, c.lastname, o.order_id, o.order_date, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC
LIMIT 3;

SELECT DISTINCT c.category_id, c.category_name, p.product_name, AVG(p.price) AS average_price_of_products
FROM products p
JOIN category c ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name, p.product_name
ORDER BY average_price_of_products DESC;

SELECT DISTINCT c.customer_id, c.firstname, c.lastname, c.email, c.phone 
FROM customers c
RIGHT OUTER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT p.product_id, p.product_name, COUNT(quantity) AS total_quantity
FROM orderitems oi
JOIN products p ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY p.product_id;

SELECT c.category_id, c.category_name, SUM(oi.quantity * oi.price) AS total_revenue
FROM orderitems oi
JOIN products p ON oi.product_id = p.product_id 
JOIN category c ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_revenue;

SELECT c.category_id, c.category_name, p1.product_id, p1.product_name, p1.price
FROM category c
JOIN products p1 ON p1.category_id = c.category_id
WHERE p1.price = (
  SELECT MAX(price) FROM products p2 WHERE p2.category_id = p1.category_id
);

SELECT DISTINCT c.customer_id, c.firstname, c.lastname, o.order_id, o.order_date, o.total_amount
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.total_amount > 500.00
ORDER BY o.total_amount;

SELECT p.product_id, p.product_name, COUNT(oi.order_id) AS total_orders
FROM products p 
JOIN orderitems oi ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_orders;

SELECT p.product_id, p.product_name, COUNT(oi.order_id) AS order_count
FROM products p 
JOIN orderitems oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY order_count;

SELECT firstname, lastname, country, COUNT(customer_id) AS total_customer_in_each_country
FROM customers
GROUP BY firstname, lastname, country;

SELECT c.customer_id, c.firstname, c.lastname, SUM(o.total_amount) AS total_spending_of_customer
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.firstname, c.lastname
ORDER BY total_spending_of_customer;
