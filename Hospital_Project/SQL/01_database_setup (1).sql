-- ===============================================
-- HOSPITAL READMISSION ANALYSIS PROJECT
-- Data Analyst Portfolio Project
-- File: 01_database_setup.sql
-- ===============================================

-- Dataset: UCI Diabetes 130-US hospitals dataset
-- Time period: 1999–2008
-- Objective: Analyze factors affecting hospital readmission

-- Step 1: Create database
CREATE DATABASE IF NOT EXISTS hospital_analysis;

-- Step 2: Select database
USE hospital_analysis;

-- Step 3: Create main table

CREATE TABLE diabetic_data (

-- Patient Identifiers
encounter_id BIGINT PRIMARY KEY,
patient_nbr BIGINT,

-- Demographics
race VARCHAR(50),
gender VARCHAR(20),
age VARCHAR(10),
weight VARCHAR(10),

-- Admission Details
admission_type_id INT,
discharge_disposition_id INT,
admission_source_id INT,
time_in_hospital INT,

-- Insurance & Medical Department
payer_code VARCHAR(20),
medical_specialty VARCHAR(100),

-- Hospital Activity Metrics
num_lab_procedures INT,
num_procedures INT,
num_medications INT,
number_outpatient INT,
number_emergency INT,
number_inpatient INT,

-- Diagnosis Codes
diag_1 VARCHAR(20),
diag_2 VARCHAR(20),
diag_3 VARCHAR(20),
number_diagnoses INT,

-- Lab Results
max_glu_serum VARCHAR(20),
A1Cresult VARCHAR(20),

-- Diabetes Medications
metformin VARCHAR(20),
repaglinide VARCHAR(20),
nateglinide VARCHAR(20),
chlorpropamide VARCHAR(20),
glimepiride VARCHAR(20),
acetohexamide VARCHAR(20),
glipizide VARCHAR(20),
glyburide VARCHAR(20),
tolbutamide VARCHAR(20),
pioglitazone VARCHAR(20),
rosiglitazone VARCHAR(20),
acarbose VARCHAR(20),
miglitol VARCHAR(20),
troglitazone VARCHAR(20),
tolazamide VARCHAR(20),
examide VARCHAR(20),
citoglipton VARCHAR(20),
insulin VARCHAR(20),

-- Combination Medications
glyburide_metformin VARCHAR(20),
glipizide_metformin VARCHAR(20),
glimepiride_pioglitazone VARCHAR(20),
metformin_rosiglitazone VARCHAR(20),
metformin_pioglitazone VARCHAR(20),

-- Treatment Changes
change VARCHAR(10),
diabetesMed VARCHAR(10),

-- Target Variable
readmitted VARCHAR(20)

);
