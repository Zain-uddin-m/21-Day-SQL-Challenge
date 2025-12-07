-- Day 7 of 21-DAY SQL Challenge:

-- Day 7 SQL challenge question:
-- Identify services that refused more than 100 patients in total and had an average patient satisfaction below 80.
-- Show service name, total refused, and average satisfaction.
SELECT service,
	SUM(patients_refused) AS total_refused,
    ROUND(avg(patient_satisfaction), 2) AS average_satisfaction
FROM hospital.services_weekly
GROUP BY service
HAVING total_refused > 100 AND average_satisfaction < 80;


-- Practice questions:
-- 1. Find services that have admitted more than 500 patients in total.
SELECT service,
	SUM(patients_admitted) AS Total_patients
FROM hospital.services_weekly
GROUP BY service
HAVING SUM(patients_admitted) > 500;

-- 2. Show services where average patient satisfaction is below 75.
SELECT service,
	ROUND(avg(satisfaction), 2) AS average_satisfaction
FROM hospital.patients
GROUP BY service
HAVING average_satisfaction < 75;

-- 3. List weeks where total staff presence across all services was less than 50.
SELECT week,
	SUM(present) AS staff_presence
FROM hospital.staff_schedule
GROUP BY week
HAVING staff_presence > 50;