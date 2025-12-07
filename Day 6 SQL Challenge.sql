-- Day 6 of 21-DAY SQL Challenge:

-- Day 6 SQL challenge question:
-- For each hospital service, calculate the total number of patients admitted, total patients refused,
-- and the admission rate (percentage of requests that were admitted). Order by admission rate descending.
SELECT
	service,
    SUM(patients_admitted) AS "Total Patients Admitted",
    SUM(patients_refused) AS "Total Patients Refused",
    ROUND(
		(SUM(patients_admitted) * 100.00) /
		NULLIF(SUM(patients_admitted) + SUM(patients_refused), 0), 2
	) AS "Admission rate"
FROM hospital.services_weekly
	GROUP BY service
    ORDER BY "Admission rate" DESC;


-- Practice questions:
-- 1. Count the number of patients by each service.
SELECT
	service,
    COUNT(patient_id) AS "Total Patients"
FROM hospital.patients
GROUP BY service;

-- 2. Calculate the average age of patients grouped by service.
SELECT
	service,
    ROUND(
		AVG(age), 2) AS Average_age
FROM hospital.patients
GROUP BY service;

-- 3. Find the total number of staff members per role.
SELECT
	role,
    COUNT(staff_id) AS "Total_Staff"
FROM hospital.staff
GROUP BY role
ORDER BY total_staff;