-- Practice Questions: 
USE hospital;
SELECT * FROM patients;

SELECT patient_id,
	name AS patient_name,
    age AS patient_age
FROM patients;

SELECT * FROM services_weekly LIMIT 10;

-- Challenge Question: DAY 1
SELECT DISTINCT service AS unique_hospital_records
	FROM services_weekly;