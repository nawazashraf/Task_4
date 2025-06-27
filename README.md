# 📊 SQL for Data Analysis – Task 4 Submission

## ✅ Objective:
Use SQL queries to extract and analyze data from the Superstore dataset.

---

## 📁 Dataset Used:
- Dataset Name: Raw - Superstore.csv
- Total Rows: ~10,000
- Imported into: MySQL

---

## 🔧 Tools:
- MySQL Workbench
- MySQL Server
- VS Code / Notepad for .sql file
- Excel (for pre-cleaning)
- (Optional) Tableau for visualization

---

## 🔍 Query Results and Screenshots

### a. SELECT, WHERE, ORDER BY, GROUP BY

**Query 1: All orders from California**
```sql
SELECT * FROM superstore_orders WHERE state = 'California';
```
![WhatsApp Image 2025-06-27 at 17 56 17_6596b8cc](https://github.com/user-attachments/assets/94493305-0f59-4255-b096-8fea6b5aa258)


---

**Query 2: Top 10 highest selling orders**
```sql
SELECT * FROM superstore_orders ORDER BY sales DESC LIMIT 10;
```
![WhatsApp Image 2025-06-27 at 17 57 44_82158d9a](https://github.com/user-attachments/assets/d7602d68-4bd3-4b02-a35b-68726338a0b5)


---

**Query 3: Total sales by Region**
```sql
SELECT region, SUM(sales) AS total_sales FROM superstore_orders GROUP BY region ORDER BY total_sales DESC;
```
![WhatsApp Image 2025-06-27 at 17 59 21_19a0616d](https://github.com/user-attachments/assets/31117444-eb82-4975-9fbb-2a86b834b64f)


---

### b. JOINS (INNER, LEFT, RIGHT)

**INNER JOIN: Sales by Region and Manager**
```sql
SELECT o.region, r.manager, SUM(o.sales) AS total_sales
FROM superstore_orders o
INNER JOIN region_manager r ON TRIM(o.region) = TRIM(r.region)
GROUP BY o.region, r.manager;
```
![WhatsApp Image 2025-06-27 at 18 17 48_bfba4b20](https://github.com/user-attachments/assets/3c668c1b-3600-46db-9913-0785713b4ca6)


---

**LEFT JOIN: Show all managers even if no orders**
```sql
SELECT r.region, r.manager, COUNT(o.order_id) AS total_orders
FROM region_manager r
LEFT JOIN superstore_orders o ON TRIM(r.region) = TRIM(o.region)
GROUP BY r.region, r.manager;
```
![WhatsApp Image 2025-06-27 at 18 21 46_434fa7b4](https://github.com/user-attachments/assets/b5feaa95-c5a6-41cf-8837-7bf392a76623)


---

**RIGHT JOIN: Similar to LEFT JOIN with reversed roles**
```sql
SELECT r.region, r.manager, SUM(o.sales) AS total_sales
FROM superstore_orders o
RIGHT JOIN region_manager r ON TRIM(o.region) = TRIM(r.region)
GROUP BY r.region, r.manager;
```
![WhatsApp Image 2025-06-27 at 18 23 21_7ddbe809](https://github.com/user-attachments/assets/e20da5ee-4994-4317-9a86-96c9b1012c88)


---

### c. Subqueries

**Top customer by sales**
```sql
SELECT customer_name, total_sales
FROM (
  SELECT customer_name, SUM(sales) AS total_sales
  FROM superstore_orders
  GROUP BY customer_name
) AS customer_sales
ORDER BY total_sales DESC
LIMIT 1;
```
![WhatsApp Image 2025-06-27 at 18 24 43_fda5044b](https://github.com/user-attachments/assets/6c8f6743-adca-418b-a9a3-3351ce919a84)

---

**Products with above-average sales**
```sql
SELECT product_name, sales FROM superstore_orders
WHERE sales > (SELECT AVG(sales) FROM superstore_orders)
ORDER BY sales DESC;
```
![WhatsApp Image 2025-06-27 at 18 25 34_bc5144be](https://github.com/user-attachments/assets/44f03668-25ef-4010-a387-1863f2a0e229)

---

### d. Aggregate Functions

```sql
SELECT 
  SUM(sales) AS total_sales,
  AVG(profit) AS avg_profit,
  MAX(discount) AS max_discount,
  MIN(sales) AS min_sale
FROM superstore_orders;
```
![image](https://github.com/user-attachments/assets/b26d8b6a-4acb-402f-8671-be224cd5fa9c)



---

### e. Views

**Create monthly sales view**
```sql
CREATE VIEW monthly_sales AS
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore_orders
GROUP BY month
ORDER BY month;
SELECT * FROM monthly_sales;
```
![WhatsApp Image 2025-06-27 at 18 27 37_0e19bdd8](https://github.com/user-attachments/assets/69a9f0cc-82a7-4241-b2e9-25e429babdb4)


---

### f. Index Optimization

```sql
CREATE INDEX idx_state ON superstore_orders(state);
CREATE INDEX idx_region ON superstore_orders(region);
CREATE INDEX idx_order_date ON superstore_orders(order_date);
CREATE INDEX idx_customer_id ON superstore_orders(customer_id);
CREATE INDEX idx_product_name ON superstore_orders(product_name);
```
![WhatsApp Image 2025-06-27 at 18 29 59_9ba67caf](https://github.com/user-attachments/assets/2b01145d-2dbf-485c-a014-0e9a8076fcea)


---

## ✅ Submission Checklist:
- [ ] SQL file included (`Task4_Analysis.sql`)
- [ ] Screenshots of all outputs
- [ ] This README filled with screenshots or output
