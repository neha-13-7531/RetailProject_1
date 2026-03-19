/*
Step 2: Data Cleaning

Purpose:
Clean raw sales data before analysis.

Tasks Performed:
- Handle NULL values
- Standardize date format
- Remove duplicate records
*/

/* Remove missing customers */
DELETE FROM retailsalespro
WHERE customer_id IS NULL;

/* Remove cancelled invoices */
DELETE FROM retailsalespro
WHERE invoice LIKE 'C%';

/* Remove invalid quantity */
DELETE FROM retailsalespro
WHERE quantity::numeric <= 0;

/* Remove invalid price */
DELETE FROM retailsalespro
WHERE price::numeric <= 0;

/* Create typed clean table */
DROP TABLE IF EXISTS retail_clean CASCADE;

CREATE TABLE retail_clean AS
SELECT
    invoice,
    stockcode,
    description,
    quantity::INT AS quantity,
    invoicedate::TIMESTAMP AS invoicedate,
    price::NUMERIC(10,2) AS price,
    customer_id,
    country,
    (quantity::INT * price::NUMERIC(10,2)) AS revenue
FROM retailsalespro;

/* Validate row count */
SELECT COUNT(*) FROM retail_clean;
