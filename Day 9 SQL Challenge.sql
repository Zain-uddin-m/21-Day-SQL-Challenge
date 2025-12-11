-- Day 9 of 21-DAY SQL Challenge:

-- Day 9 SQL challenge question:
-- Calculate the average length of stay (in days) for each service,
-- showing only services where the average stay is more than 7 days.
-- Also show the count of patients and order by average stay descending.
SELECT
	service,
    ROUND(
		AVG(datediff(departure_date, arrival_date)), 2) AS avg_stay,
	COUNT(patient_id) AS total_patients
FROM patients
GROUP BY service
HAVING AVG(datediff(departure_date, arrival_date)) > 7
ORDER BY avg_stay DESC;

-- Practice questions:
-- 1. Extract the year from all patient arrival dates.
SELECT
	arrival_date,
    year(arrival_date) AS 'Year'
FROM hospital.patients;

-- 2. Calculate the length of stay for each patient (departure_date - arrival_date).
SELECT
	patient_id,
    arrival_date,
    departure_date,
    datediff(departure_date, arrival_date) AS length_of_stay
FROM hospital.patients;

-- 3. Find all patients who arrived in a specific month. # March
SELECT
	patient_id, name,
    arrival_date
FROM hospital.patients
WHERE EXTRACT(MONTH FROM arrival_date) = 03;