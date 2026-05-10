 -- Day 15 of 21-SQL Challenge
-- Topics: Multiple Joins- Joining more than two tables, complex relationships

-- Day 15 SQL question:
-- Create a comprehensive service analysis report for week 20 showing: service name,
-- total patients admitted that week, total patients refused, average patient satisfaction,
-- count of staff assigned to service, and count of staff present that week. Order by patients admitted descending.
SELECT
    sw.service,
    SUM(sw.patients_admitted) AS total_pat_admitted,
    SUM(sw.patients_refused) AS total_pat_refused,
    ROUND(
		AVG(sw.patient_satisfaction),
			2) AS avg_pat_satisfaction,
    COUNT(ss.staff_id) AS staff_assigned,
    COUNT(CASE
			WHEN ss.present = 1 THEN ss.staff_id
		END) AS staff_present
FROM services_weekly sw
	JOIN staff_schedule ss
		ON sw.service = ss.service
WHERE sw.week = 20
GROUP BY sw.service
ORDER BY total_pat_admitted DESC;


-- Practice Questions:
-- 1. 1. Find patients who are in services with above-average staff count.

-- 2. List staff who work in services that had any week with patient satisfaction below 70.

-- 3. Show patients from services where total admitted patients exceed 1000.