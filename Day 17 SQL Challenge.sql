-- Day 16 of 21-Day SQL Challenge:
-- Topics: Subqueries in SELECT, derived tables, inline views

-- Day 16 SQL Challenge question:
-- Create a report showing each service with: service name, total patients admitted,
-- the difference between their total admissions and the average admissions across all services,
-- and a rank indicator ('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending.
SELECT
	service,
    total_admitted,
    (total_admitted - avg_admitted) AS difference,
    CASE
		WHEN total_admitted > avg_admitted THEN 'Above Average'
        WHEN total_admitted = avg_admitted THEN 'Average'
        ELSE 'Below Average'
    END AS performance
FROM (
	SELECT
		service,
		SUM(patients_admitted) AS total_admitted,
		(SELECT AVG(total_pat_admitted) AS avg_pat_admitted
		FROM
			(SELECT SUM(patients_admitted) AS total_pat_admitted
			FROM services_weekly
			GROUP BY service
			) AS total_sq1
		) AS avg_admitted
	FROM services_weekly
	GROUP BY service
	) AS service_stats
ORDER BY total_admitted DESC;


-- Practice Questions:
-- 1. Show each patient with their service's average satisfaction as an additional column.
SELECT
	p.patient_id,
    p.name AS patient_name,
    p.service,
    p.satisfaction,
    avg_satisfaction.avg_pat_satisfaction
FROM patients p
JOIN
    (SELECT
		service,
		ROUND(AVG(satisfaction), 2) AS avg_pat_satisfaction
		FROM patients
		GROUP BY service
    ) AS avg_satisfaction
ON p.service = avg_satisfaction.service;

-- 2. Create a derived table of service statistics and query from it.
SELECT
	service,
	SUM(patients_admitted) AS total_admitted,
	(SELECT ROUND(AVG(total_pat_admitted), 2) AS avg_pat_admitted
	 FROM
		(SELECT SUM(patients_admitted) AS total_pat_admitted
		 FROM services_weekly
		 GROUP BY service
		) AS total_sq1
	) AS avg_admitted
FROM services_weekly
GROUP BY service;

-- 3. Display staff with their service's total patient count as a calculated field.
SELECT 
    s.staff_name, 
    s.service, 
    totals.total_patients
FROM staff AS s
JOIN (
	  SELECT 
		   service, 
		   SUM(patients_admitted) AS total_patients
	  FROM services_weekly
	  GROUP BY service
	) AS totals
ON s.service = totals.service;