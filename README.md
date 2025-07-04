🛒 Online Retail Database Project (MySQL)

This project represents a simple **Online Retail Store** database system built using **MySQL**. It includes the schema design, sample data, and multiple insightful queries for analyzing customer behavior, sales, product performance, and more.

📁 Contents

- `CREATE DATABASE` and `CREATE TABLE` statements for:
  - Categories
  - Customers
  - Products
  - Orders
  - Order Items

- Sample data for:
  - Product categories
  - Customers
  - Products
  - Orders
  - Order items

- Analytical and business-oriented SQL queries, including:
  - Sales analysis
  - Customer segmentation
  - Product and category insights
  - Order trends

---

🛠️ Technologies Used

- MySQL (tested on MySQL 8.0+)
- SQL (DDL & DML)
- Aggregate Functions (SUM, COUNT, AVG)
- Joins (INNER, RIGHT OUTER)
- GROUP BY, ORDER BY, LIMIT
- Date functions and subqueries

---

🗂️ Database Schema Overview

### 🔹 `category`
Stores product categories (e.g., Electronics, Books, Clothing).

### 🔹 `customers`
Contains customer details such as name, contact, address, and country.

### 🔹 `products`
Product catalog with foreign key to categories, stock, and price.

### 🔹 `orders`
Customer orders with total amounts and timestamps.

### 🔹 `orderitems`
Items within each order, linked to both products and orders.

---

📊 Example Queries

Here are some useful SQL queries included in the project:

- Total revenue by product or category
- Top spending customers
- Average order value
- Products with zero stock
- Monthly order trends
- Products with highest sales
- Customers who didn’t place any orders
- Most expensive product per category
- Recent orders with customer details
- Customer count by country

---

🔍 Sample Query

```sql
SELECT p.product_id, p.product_name, SUM(oi.quantity * oi.price) AS total_sales
FROM orderitems oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC;
