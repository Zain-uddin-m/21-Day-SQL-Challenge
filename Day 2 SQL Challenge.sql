-- Day 2 of SQL challenge:
-- Find all patients admitted to 'Surgery' service with a satisfaction score below 70,
-- showing their patient_id, name, age, and satisfaction score.
USE hospital;
SELECT patient_id,
	name AS patient_name,
    age AS patient_age,
    satisfaction AS satisfaction_score
FROM patients
	WHERE service = "Surgery" AND satisfaction < 70;

-- Practice questions:
-- 1. Find all patients who are older than 60 years.
SELECT name AS patient_name FROM patients
	WHERE age > 60;

-- 2. Retrieve all staff members who work in the 'Emergency' service.
SELECT staff_name FROM staff
	WHERE service = "Emergency";
    
-- 3. List all weeks where more than 100 patients requested admission in any service.
SELECT DISTINCT week FROM services_weekly
	WHERE patients_request > 100;