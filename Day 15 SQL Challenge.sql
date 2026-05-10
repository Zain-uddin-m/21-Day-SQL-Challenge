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