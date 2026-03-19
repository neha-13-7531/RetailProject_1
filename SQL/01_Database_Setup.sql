/*
Project: Retail Customer Analytics
Step 1: Database Setup

This script creates the retail database and required tables
for storing transaction data.

Tables Created:
- customers
- products
- transactions

Author: Harshita Reddy / Omkar Powar
*/

/* ============================================================
   01_DATABASE_SETUP.SQL
   Purpose: Create database and raw table structure
   ============================================================ */

/* Run this first (if database not created) */
-- CREATE DATABASE retail;

/* Connect to retail database before running below */

DROP TABLE IF EXISTS retailsalespro CASCADE;

/* Raw staging table (all text for safe import) */
CREATE TABLE retailsalespro (
    id SERIAL PRIMARY KEY,
    invoice TEXT,
    stockcode TEXT,
    description TEXT,
    quantity TEXT,
    invoicedate TEXT,
    price TEXT,
    customer_id INT,
    country TEXT
);

/* After this, import CSV using pgAdmin Import Tool */

