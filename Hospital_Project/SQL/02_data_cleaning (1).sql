-- =====================================================
-- HOSPITAL READMISSION ANALYSIS PROJECT
-- File: 02_data_cleaning.sql
-- Purpose: Data Cleaning and Preparation
-- =====================================================

-- -----------------------------------------------------
-- Step 1: Check total number of records
-- -----------------------------------------------------

SELECT COUNT(*) AS total_records
FROM diabetic_data;


-- -----------------------------------------------------
-- Step 2: Identify duplicate patient records
-- -----------------------------------------------------

SELECT patient_nbr, COUNT(*) AS duplicate_count
FROM diabetic_data
GROUP BY patient_nbr
HAVING COUNT(*) > 1;


-- -----------------------------------------------------
-- Step 3: Replace missing values in race column
-- -----------------------------------------------------

UPDATE diabetic_data
SET race = 'Unknown'
WHERE race IS NULL;


-- -----------------------------------------------------
-- Step 4: Replace missing values in weight column
-- -----------------------------------------------------

UPDATE diabetic_data
SET weight = 'Unknown'
WHERE weight IS NULL;


-- -----------------------------------------------------
-- Step 5: Replace missing values in payer_code
-- -----------------------------------------------------

UPDATE diabetic_data
SET payer_code = 'Unknown'
WHERE payer_code IS NULL;


-- -----------------------------------------------------
-- Step 6: Replace missing values in medical_specialty
-- -----------------------------------------------------

UPDATE diabetic_data
SET medical_specialty = 'Unknown'
WHERE medical_specialty IS NULL;


-- -----------------------------------------------------
-- Step 7: Validate gender categories
-- -----------------------------------------------------

SELECT DISTINCT gender
FROM diabetic_data;


-- -----------------------------------------------------
-- Step 8: Check age group categories
-- -----------------------------------------------------

SELECT DISTINCT age
FROM diabetic_data
ORDER BY age;


-- -----------------------------------------------------
-- Step 9: Validate hospital stay duration
-- -----------------------------------------------------

SELECT MIN(time_in_hospital) AS min_stay,
       MAX(time_in_hospital) AS max_stay
FROM diabetic_data;


-- -----------------------------------------------------
-- Step 10: Check readmission categories
-- -----------------------------------------------------

SELECT DISTINCT readmitted
FROM diabetic_data;


-- Expected values:
-- NO   -> Not readmitted
-- <30  -> Readmitted within 30 days
-- >30  -> Readmitted after 30 days


-- -----------------------------------------------------
-- Step 11: Create simplified readmission flag
-- -----------------------------------------------------

ALTER TABLE diabetic_data
ADD COLUMN readmitted_flag INT;


UPDATE diabetic_data
SET readmitted_flag =
CASE
    WHEN readmitted = 'NO' THEN 0
    WHEN readmitted = '<30' THEN 1
    WHEN readmitted = '>30' THEN 1
END;


-- -----------------------------------------------------
-- Step 12: Final data quality check
-- -----------------------------------------------------

SELECT
COUNT(*) AS total_records,
COUNT(race) AS race_available,
COUNT(weight) AS weight_available,
COUNT(medical_specialty) AS specialty_available
FROM diabetic_data;
