-- Day 21 of 21-Day SQL Challenge:
-- Topics: WITH clause, CTEs, recursive CTEs (if applicable), query organization

-- Day 21 SQL Challenge Question:
-- Create a comprehensive hospital performance dashboard using CTEs.
-- Calculate: 1) Service-level metrics (total admissions, refusals, avg satisfaction),
-- 2) Staff metrics per service (total staff, avg weeks present), 3) Patient demographics per service (avg age, count).
-- Then combine all three CTEs to create a final report showing service name, all calculated metrics,
-- and an overall performance score (weighted average of admission rate and satisfaction). Order by performance score descending.
WITH service_metrics
	AS (SELECT
			service,
            SUM(patients_admitted) AS total_admissions,
            SUM(patients_refused) AS total_refused,
            ROUND(AVG(patient_satisfaction), 2) AS avg_pat_satisfaction
		FROM services_weekly
        GROUP BY service
        ),
	staff_metrics
    AS (SELECT
			service,
            COUNT(DISTINCT staff_id) AS total_staff,
            ROUND(AVG(present), 2) AS avg_week_present
		FROM staff_schedule
        GROUP BY service
        ),
	patient_demographics
    AS (SELECT
            service,
            ROUND(AVG(age), 2) AS avg_age,
            COUNT(patient_id) AS patient_count
		FROM patients
        GROUP BY service
        )
SELECT
	sm.service,
	sm.total_admissions,
	sm.total_refused,
	sm.avg_pat_satisfaction,
	ss.total_staff,
	ss.avg_week_present,
	pd.avg_age,
	pd.patient_count,
	ROUND(100.0 * sm.total_admissions /
			(sm.total_admissions + sm.total_refused), 2
		 ) AS admission_rate,
	ROUND(100.0 * sm.total_admissions /
			(sm.total_admissions + sm.total_refused) + sm.avg_pat_satisfaction / 2, 2
		 ) AS performance_score
FROM service_metrics sm
	LEFT JOIN staff_metrics ss
		ON sm.service = ss.service
	LEFT JOIN patient_demographics pd
		ON ss.service = pd.service
ORDER BY performance_score DESC;


-- Practice Questions:
-- 1. Create a CTE to calculate service statistics, then query from it.
WITH service_stats_cte
	AS (SELECT
			service,
			COUNT(*) AS patient_count,
			ROUND(AVG(satisfaction), 2) AS avg_satisfaction
		FROM patients
		GROUP BY service
		)
SELECT * FROM service_stats_cte
WHERE avg_satisfaction > 70
ORDER BY patient_count DESC;

-- 2. Use multiple CTEs to break down a complex query into logical steps.
WITH patient_metrics
	AS (SELECT
			service,
            COUNT(*) AS patient_count,
            AVG(age) AS avg_age,
            ROUND(AVG(satisfaction), 2) AS avg_satisfaction
		FROM patients
        GROUP BY service
        ),
staff_metrics
    AS (SELECT
			service,
            COUNT(*) AS staff_count
		FROM staff
        GROUP BY service
        ),
weekly_metrics
	AS (SELECT
			service,
            SUM(patients_admitted) AS total_pat_admitted,
            SUM(patients_refused) AS total_pat_refused
		FROM services_weekly
        GROUP BY service
        )
SELECT
	pm.patient_count,
    pm.avg_age,
    pm.avg_satisfaction,
    sm.staff_count,
    wm.total_pat_admitted,
    wm.total_pat_refused,
    ROUND(100.0 * wm.total_admitted /
				(wm.total_admitted + wm.total_refused), 2
		 ) AS admission_rate
FROM patient_metrics pm
	LEFT JOIN staff_metrics sm
		ON pm.service = sm.service
	LEFT JOIN weekly_metrics wm
		ON sm.service = wm.service
ORDER BY pm.avg_satisfaction DESC;

-- 3. Build a CTE for staff utilization and join it with patient data.
WITH staff_utilization
	AS (
		SELECT
			staff_id,
            staff_name,
			service,
            role,
            SUM(present) AS total_staff_present
		FROM staff_schedule
        GROUP BY staff_id, staff_name, service, role
		)
SELECT
	p.patient_id,
    p.name AS patient_name,
    p.service,
    p.satisfaction,
    su.staff_name,
    su.role,
    su.total_staff_present    
FROM patients p
LEFT JOIN staff_utilization su
	ON p.service = su.service
ORDER BY su.staff_name;