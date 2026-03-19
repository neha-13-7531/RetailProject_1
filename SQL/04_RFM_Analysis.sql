/*
Step 4: RFM Analysis

RFM Metrics:
Recency
Frequency
Monetary

Goal:
Segment customers based on purchasing behaviour.
*/
/* RFM Base */
DROP TABLE IF EXISTS rfm_base CASCADE;

CREATE TABLE rfm_base AS
SELECT
    customer_id,
    MAX(date) AS last_purchase_date,
    COUNT(DISTINCT invoice) AS frequency,
    SUM(revenue) AS monetary,
    (SELECT MAX(date) FROM fact_sales) - MAX(date) AS recency
FROM fact_sales
GROUP BY customer_id;


/* RFM Scoring */
DROP TABLE IF EXISTS rfm_scores CASCADE;

CREATE TABLE rfm_scores AS
SELECT *,
    NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
    NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
    NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
FROM rfm_base;


/* Segmentation */
ALTER TABLE rfm_scores
ADD COLUMN rfm_segment TEXT;

UPDATE rfm_scores
SET rfm_segment =
    CASE
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
        WHEN r_score >= 3 AND f_score >= 3 THEN 'Loyal Customers'
        WHEN r_score >= 4 AND f_score <= 2 THEN 'New Customers'
        WHEN r_score <= 2 AND f_score >= 4 THEN 'At Risk'
        ELSE 'Others'
    END;

/* Segment distribution */
SELECT rfm_segment, COUNT(*)
FROM rfm_scores
GROUP BY rfm_segment;
