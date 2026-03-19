/*
Step 6: Business Intelligence Queries

This file contains SQL queries used to generate
business insights such as:

- Top-selling products
- Revenue by region
- Customer purchase trends
*/

/* Total Revenue */
SELECT SUM(revenue) AS total_revenue
FROM fact_sales;


/* Total Customers */
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM fact_sales;


/* Monthly Revenue */
SELECT d.year, d.month, SUM(f.revenue) AS monthly_revenue
FROM fact_sales f
JOIN dim_date d ON f.date = d.date
GROUP BY d.year, d.month
ORDER BY d.year, d.month;


/* Top 10 Products */
SELECT p.description, SUM(f.quantity) AS total_quantity
FROM fact_sales f
JOIN dim_product p ON f.stockcode = p.stockcode
GROUP BY p.description
ORDER BY total_quantity DESC
LIMIT 10;


/* Revenue by Country */
SELECT c.country, SUM(f.revenue) AS country_revenue
FROM fact_sales f
JOIN dim_customer c ON f.customer_id = c.customer_id
GROUP BY c.country
ORDER BY country_revenue DESC;

/* 
Window Function Example
Purpose: Rank customers based on their total spending.
This demonstrates the use of SQL window functions.
*/

SELECT
customer_id,
SUM(total_price) AS total_spent,
RANK() OVER (ORDER BY SUM(total_price) DESC) AS customer_rank
FROM sales
GROUP BY customer_id;
