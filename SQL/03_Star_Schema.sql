/*
Step 3: Star Schema Creation

Fact Table:
Fact_Sales

Dimension Tables:
Dim_Customers
Dim_Products
Dim_Date

Purpose:
Improve query performance for analytical queries.
*/

/* ================== DIMENSIONS ================== */

/* Customer Dimension */
DROP TABLE IF EXISTS dim_customer CASCADE;

CREATE TABLE dim_customer AS
SELECT
    customer_id,
    MIN(country) AS country
FROM retail_clean
GROUP BY customer_id;

ALTER TABLE dim_customer
ADD PRIMARY KEY (customer_id);


/* Product Dimension */
DROP TABLE IF EXISTS dim_product CASCADE;

CREATE TABLE dim_product AS
SELECT
    stockcode,
    MIN(description) AS description
FROM retail_clean
GROUP BY stockcode;

ALTER TABLE dim_product
ADD PRIMARY KEY (stockcode);


/* Date Dimension */
DROP TABLE IF EXISTS dim_date CASCADE;

CREATE TABLE dim_date AS
SELECT DISTINCT
    invoicedate::DATE AS date,
    EXTRACT(YEAR FROM invoicedate) AS year,
    EXTRACT(MONTH FROM invoicedate) AS month,
    EXTRACT(QUARTER FROM invoicedate) AS quarter
FROM retail_clean;

ALTER TABLE dim_date
ADD PRIMARY KEY (date);


/* ================== FACT TABLE ================== */

DROP TABLE IF EXISTS fact_sales CASCADE;

CREATE TABLE fact_sales AS
SELECT
    invoice,
    customer_id,
    stockcode,
    invoicedate::DATE AS date,
    quantity,
    price,
    revenue
FROM retail_clean;

/* Add constraints */
ALTER TABLE fact_sales
ALTER COLUMN customer_id SET NOT NULL,
ALTER COLUMN stockcode SET NOT NULL,
ALTER COLUMN date SET NOT NULL,
ALTER COLUMN quantity SET NOT NULL,
ALTER COLUMN price SET NOT NULL,
ALTER COLUMN revenue SET NOT NULL;

/* Foreign Keys */
ALTER TABLE fact_sales
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id)
REFERENCES dim_customer(customer_id);

ALTER TABLE fact_sales
ADD CONSTRAINT fk_product
FOREIGN KEY (stockcode)
REFERENCES dim_product(stockcode);

ALTER TABLE fact_sales
ADD CONSTRAINT fk_date
FOREIGN KEY (date)
REFERENCES dim_date(date);

/* Indexes for performance */
CREATE INDEX idx_fact_customer ON fact_sales(customer_id);
CREATE INDEX idx_fact_product ON fact_sales(stockcode);
CREATE INDEX idx_fact_date ON fact_sales(date);
CREATE INDEX idx_fact_invoice ON fact_sales(invoice);
