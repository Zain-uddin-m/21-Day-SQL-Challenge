-- Day 16 of 21-Day SQL Challenge:
-- Topics: Subqueries in WHERE, nested queries, filtering with subqueries

-- Day 16 SQL Challenge question:
-- Find all patients who were admitted to services that had at least one week where patients were refused
-- AND the average patient satisfaction for that service was below the overall hospital average satisfaction.
-- Show patient_id, name, service, and their personal satisfaction score.
SELECT
	p.patient_id,
    p.name AS patient_name,
    p.service,
    p.satisfaction
FROM patients p
WHERE p.service IN (
		SELECT sw.service
        FROM services_weekly sw
		WHERE sw.service IN (
			SELECT service
            FROM services_weekly
            WHERE patients_refused > 0)
		GROUP BY sw.service
			HAVING ROUND(AVG(sw.patient_satisfaction), 2) <
				(SELECT ROUND(AVG(patient_satisfaction), 2) FROM services_weekly));
    

-- Practice Question:
-- 1. Find patients who are in services with above-average staff count.
SELECT * FROM patients
WHERE service IN (
		SELECT service
        FROM staff
        GROUP BY service
			HAVING COUNT(*) > 5);
        
-- 2. List staff who work in services that had any week with patient satisfaction below 70.
SELECT * FROM staff
WHERE service IN (
		SELECT DISTINCT service
        FROM services_weekly
        WHERE patient_satisfaction < 70);
        
-- 3. Show patients from services where total admitted patients exceed 1000.
SELECT * FROM patients
WHERE service IN (
		SELECT service 
        FROM services_weekly
        GROUP BY service
			HAVING SUM(patients_admitted) > 1000);