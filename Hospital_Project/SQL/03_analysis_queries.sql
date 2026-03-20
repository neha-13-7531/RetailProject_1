-- =====================================================
-- HOSPITAL READMISSION ANALYSIS PROJECT
-- File: 03_analysis_queries.sql
-- Purpose: Business Analysis and Insights
-- =====================================================

-- -----------------------------------------------------
-- 1. Total number of hospital encounters
-- -----------------------------------------------------

SELECT COUNT(*) AS total_encounters
FROM diabetic_data;


-- -----------------------------------------------------
-- 2. Total number of unique patients
-- -----------------------------------------------------

SELECT COUNT(DISTINCT patient_nbr) AS total_patients
FROM diabetic_data;


-- -----------------------------------------------------
-- 3. Average hospital stay duration
-- -----------------------------------------------------

SELECT AVG(time_in_hospital) AS avg_hospital_stay
FROM diabetic_data;


-- -----------------------------------------------------
-- 4. Readmission distribution
-- -----------------------------------------------------

SELECT readmitted,
COUNT(*) AS patient_count
FROM diabetic_data
GROUP BY readmitted
ORDER BY patient_count DESC;


-- -----------------------------------------------------
-- 5. Readmission rate percentage
-- -----------------------------------------------------

SELECT 
ROUND(
COUNT(CASE WHEN readmitted != 'NO' THEN 1 END) * 100.0 
/ COUNT(*),2
) AS readmission_rate_percentage
FROM diabetic_data;


-- -----------------------------------------------------
-- 6. Patient distribution by gender
-- -----------------------------------------------------

SELECT gender,
COUNT(*) AS patient_count
FROM diabetic_data
GROUP BY gender
ORDER BY patient_count DESC;


-- -----------------------------------------------------
-- 7. Patient distribution by race
-- -----------------------------------------------------

SELECT race,
COUNT(*) AS patient_count
FROM diabetic_data
GROUP BY race
ORDER BY patient_count DESC;


-- -----------------------------------------------------
-- 8. Average hospital stay by age group
-- -----------------------------------------------------

SELECT age,
ROUND(AVG(time_in_hospital),2) AS avg_stay
FROM diabetic_data
GROUP BY age
ORDER BY age;


-- -----------------------------------------------------
-- 9. Readmission by age group
-- -----------------------------------------------------

SELECT age,
COUNT(*) AS readmitted_patients
FROM diabetic_data
WHERE readmitted != 'NO'
GROUP BY age
ORDER BY readmitted_patients DESC;


-- -----------------------------------------------------
-- 10. Top medical specialties treating patients
-- -----------------------------------------------------

SELECT medical_specialty,
COUNT(*) AS patient_count
FROM diabetic_data
GROUP BY medical_specialty
ORDER BY patient_count DESC
LIMIT 10;


-- -----------------------------------------------------
-- 11. Average number of medications prescribed
-- -----------------------------------------------------

SELECT AVG(num_medications) AS avg_medications
FROM diabetic_data;


-- -----------------------------------------------------
-- 12. Average lab procedures performed
-- -----------------------------------------------------

SELECT AVG(num_lab_procedures) AS avg_lab_tests
FROM diabetic_data;


-- -----------------------------------------------------
-- 13. Readmission by number of inpatient visits
-- -----------------------------------------------------

SELECT number_inpatient,
COUNT(*) AS readmission_count
FROM diabetic_data
WHERE readmitted != 'NO'
GROUP BY number_inpatient
ORDER BY readmission_count DESC;


-- -----------------------------------------------------
-- 14. Average hospital stay by admission type
-- -----------------------------------------------------

SELECT admission_type_id,
ROUND(AVG(time_in_hospital),2) AS avg_stay
FROM diabetic_data
GROUP BY admission_type_id
ORDER BY avg_stay DESC;


-- -----------------------------------------------------
-- 15. Diabetes medication usage analysis
-- -----------------------------------------------------

SELECT insulin,
COUNT(*) AS patient_count
FROM diabetic_data
GROUP BY insulin
ORDER BY patient_count DESC;
