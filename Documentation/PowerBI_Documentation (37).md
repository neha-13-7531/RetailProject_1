Retail Sales Analytics Dashboard — Power BI Documentation

1. Overview:- 
        This Power BI dashboard provides an executive-level analysis of retail sales performance, customer behavior, and retention patterns.
        The solution is built on a PostgreSQL star schema warehouse and integrates:
                Revenue performance tracking
                Customer segmentation using RFM analysis
                Cohort-based retention modeling
                Customer lifetime value insights
                Churn risk identification

        The objective of this dashboard is to transform raw transactional data into actionable business intelligence.

2. Data Architecture:-
    Data Source
        Retail transactional dataset (800K+ records)
    Data Warehouse
        PostgreSQL
        Star schema modeling
    Fact Table
        fact_sales
        invoice
        customer_id
        stockcode
        date
        quantity
        price
        revenue
    Dimension Tables
        dim_customer
            customer_id
            country
        dim_product
            stockcode
            description
        dim_date
            date
            year
            month
            quarter
    Analytical Tables
        rfm_scores
            Recency
            Frequency
            Monetary
            RFM segment classification
        cohort_analysis
            cohort_month
            transaction_month
            month_number
    Relationships
            fact_sales → dim_customer (One-to-Many)
            fact_sales → dim_product (One-to-Many)
            fact_sales → dim_date (One-to-Many)
            dim_customer → rfm_scores (One-to-One)
    The model follows a clean star schema for performance and scalability.

3. Key Metrics (KPI Definitions)
    Total Revenue
        Sum of all valid transaction revenue.
    Total Customers
        Distinct count of purchasing customers.
    Total Orders
        Distinct invoice count.
    Average Order Value (AOV)
        Total Revenue ÷ Total Orders.
    Revenue Growth %
        Month-over-month percentage change in revenue.
    RFM Segmentation
        Customers classified based on:
            Recency (Last purchase date)
            Frequency (Number of purchases)
            Monetary (Total spending)
        Segments include:
            Champions
            Loyal Customers
            New Customers
            At Risk
            Others
    Retention Rate
        Percentage of customers returning in subsequent months after first purchase.
    Churn Status
        Customer flagged as churned if no purchase within last 90 days.

4. Dashboard Pages Structure
    Page 1 — Executive Overview
        Purpose:
            Provide high-level performance summary for stakeholders.
        Visuals:
            KPI Cards (Revenue, Customers, Orders, AOV, Churn %)
            Monthly Revenue Trend
            Revenue by Country
            Top 10 Products
            RFM Segment Distribution
        Business Use:
            Helps leadership quickly evaluate revenue performance and market concentration.
    Page 2 — Customer Segmentation
        Purpose:
            Analyze customer value and behavior patterns.
        Visuals:
            RFM Segment Breakdown
            Frequency vs Monetary Scatter Plot
            Revenue Contribution by Segment
            Customer Lifetime Value Table
        Business Use:
            Identifies high-value customers and at-risk segments.
    Page 3 — Retention & Cohort Analysis
        Purpose:
            Understand customer lifecycle and retention trends.
        Visuals:
            Cohort Retention Heatmap
            Monthly Active Customers
            Retention Trend Line
        Business Use:
            Evaluates customer loyalty and repeat purchase behavior.

5. Business Insights Generated:-
    Revenue is concentrated among a small percentage of high-value customers.
    The UK contributes the majority of total sales revenue.
    Customer retention significantly drops after the second month.
    Champions segment generates highest average order value.
    At-risk customers represent a recovery opportunity for revenue growth.

6. Performance Optimization:-
    Fact table indexed on customer_id, stockcode, and date.
    Star schema modeling for optimized query performance.
    Invalid transactions removed during cleaning stage.
    Efficient DAX measures implemented using CALCULATE and DATEADD.
    Query performance validated under 2 seconds.

7. Tools & Technologies Used:-
    PostgreSQL
    SQL (Joins, Window Functions, Indexing)
    Power BI Desktop
    DAX (Time Intelligence & Analytical Measures)
    Star Schema Data Modeling.

8. Future Enhancements:-
    Implement customer churn prediction using machine learning.
    Add revenue forecasting using time-series analysis.
    Automate ETL pipeline for scheduled refresh.
    Deploy dashboard to Power BI Service for enterprise reporting.

9. Project Outcome:-
    This project demonstrates the end-to-end implementation of:
    Data cleaning and transformation
    Data warehouse modeling
    Customer segmentation analytics
    Retention analysis
    Business intelligence dashboard development
The solution reflects a production-style analytics workflow suitable for real-world business environments.