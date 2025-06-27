
-- Task 4: SQL for Data Analysis (Superstore Dataset)
-- a. SELECT, WHERE, ORDER BY, GROUP BY

-- 1. Show all orders from California
SELECT * FROM superstore_orders WHERE state = 'California';

-- 2. Top 10 highest selling orders
SELECT * FROM superstore_orders ORDER BY sales DESC LIMIT 10;

-- 3. Total sales by Region
SELECT region, SUM(sales) AS total_sales
FROM superstore_orders
GROUP BY region
ORDER BY total_sales DESC;


-- b. JOINS (INNER, LEFT, RIGHT)

-- Create region_manager table
CREATE TABLE region_manager (
    region VARCHAR(50),
    manager VARCHAR(50)
);

-- Insert sample manager data
INSERT INTO region_manager (region, manager) VALUES
('East', 'Anjali Sharma'),
('West', 'Ravi Kumar'),
('Central', 'Neha Singh'),
('South', 'Amit Verma');

-- INNER JOIN: 
SELECT o.region, r.manager, SUM(o.sales) AS total_sales
FROM superstore_orders o
INNER JOIN region_manager r ON TRIM(o.region) = TRIM(r.region)
GROUP BY o.region, r.manager;

-- LEFT JOIN: 
SELECT r.region, r.manager, COUNT(o.order_id) AS total_orders
FROM region_manager r
LEFT JOIN superstore_orders o ON TRIM(r.region) = TRIM(o.region)
GROUP BY r.region, r.manager;

-- RIGHT JOIN: 
SELECT o.region, r.manager, SUM(o.sales) AS total_sales
FROM superstore_orders o
RIGHT JOIN region_manager r ON TRIM(o.region) = TRIM(r.region)
GROUP BY o.region, r.manager;


-- c. Subqueries

-- 1. Top customer by sales
SELECT customer_name, total_sales
FROM (
    SELECT customer_name, SUM(sales) AS total_sales
    FROM superstore_orders
    GROUP BY customer_name
) AS customer_sales
ORDER BY total_sales DESC
LIMIT 1;

-- 2. Products with above-average sales
SELECT product_name, sales
FROM superstore_orders
WHERE sales > (
    SELECT AVG(sales) FROM superstore_orders
)
ORDER BY sales DESC;


-- d. Aggregate Functions

SELECT 
  SUM(sales) AS total_sales,
  AVG(profit) AS avg_profit,
  MAX(discount) AS max_discount,
  MIN(sales) AS min_sale
FROM superstore_orders;


-- e. Create Views

-- 1. Monthly sales and profit view
CREATE VIEW monthly_sales AS
SELECT 
  DATE_FORMAT(order_date, '%Y-%m') AS month,
  SUM(sales) AS total_sales,
  SUM(profit) AS total_profit
FROM superstore_orders
GROUP BY month
ORDER BY month;

-- 2. View data from monthly_sales view
SELECT * FROM monthly_sales;


-- f. Optimize Queries with Indexes

CREATE INDEX idx_state ON superstore_orders(state);
CREATE INDEX idx_region ON superstore_orders(region);
CREATE INDEX idx_order_date ON superstore_orders(order_date);
CREATE INDEX idx_customer_id ON superstore_orders(customer_id);
CREATE INDEX idx_product_name ON superstore_orders(product_name);
