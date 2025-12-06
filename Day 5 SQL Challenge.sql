-- Day 5 of 21-DAY SQL Challenge:

-- Day 5 challenge question:
-- Calculate the total number of patients admitted, total patients refused, and the average patient satisfaction across all services and weeks.
-- Round the average satisfaction to 2 decimal places.
SELECT
	SUM(patients_admitted) AS total_patients_admitted,
    SUM(patients_refused) AS total_patients_refused,
    ROUND(AVG(patient_satisfaction), 2) AS average_satisfaction_score
FROM hospital.services_weekly;

-- Practice questions:
-- 1. Count the total number of patients in the hospital.
SELECT COUNT(patient_id) AS total_patients
FROM patients;

-- 2. Calculate the average satisfaction score of all patients.
SELECT ROUND(AVG(satisfaction), 2) AS average_satisfaction_score
FROM patients;

-- 3. Find the minimum and maximum age of patients.
SELECT
	MIN(age) AS minimum_age,
    MAX(age) AS maximum_age
FROM patients;