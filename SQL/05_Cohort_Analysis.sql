/*
Step 5: Cohort Analysis

Goal:
Track customer retention based on
First purchase month.

Used to analyze customer lifecycle behaviour.
*/

/* Identify first purchase month */
DROP TABLE IF EXISTS customer_cohort CASCADE;

CREATE TABLE customer_cohort AS
SELECT
    customer_id,
    DATE_TRUNC('month', MIN(date)) AS cohort_month
FROM fact_sales
GROUP BY customer_id;


/* Cohort tracking */
DROP TABLE IF EXISTS cohort_analysis CASCADE;

CREATE TABLE cohort_analysis AS
SELECT
    f.customer_id,
    c.cohort_month,
    DATE_TRUNC('month', f.date) AS transaction_month,
    EXTRACT(MONTH FROM AGE(DATE_TRUNC('month', f.date), c.cohort_month)) AS month_number
FROM fact_sales f
JOIN customer_cohort c
ON f.customer_id = c.customer_id;


/* Retention output */
SELECT
    cohort_month,
    month_number,
    COUNT(DISTINCT customer_id) AS active_customers
FROM cohort_analysis
GROUP BY cohort_month, month_number
ORDER BY cohort_month, month_number;
