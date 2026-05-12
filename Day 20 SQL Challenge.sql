-- Day 20 of 21-Day SQL Challenge:
-- Topics: SUM() OVER, AVG() OVER, running totals, moving averages

-- Day 20 SQL Challenge Question:
-- Create a trend analysis showing for each service and week: week number, patients_admitted,
-- running total of patients admitted (cumulative), 3-week moving average of patient satisfaction
-- (current week and 2 prior weeks), and the difference between current week admissions and the service average.
-- Filter for weeks 10-20 only.
SELECT * FROM
		(SELECT
			service,
			week,
			patients_admitted,
			SUM(patients_admitted) OVER
					(PARTITION BY service
						ORDER BY week
					) AS cumulative_admissions,
			ROUND(AVG(patient_satisfaction) OVER
					(PARTITION BY service
						ORDER BY week
                        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2
				 ) AS service_average,
			ROUND((SUM(patients_admitted) OVER
					(PARTITION BY service
					ORDER BY week) - AVG(patient_satisfaction) OVER
										(PARTITION BY service
										ORDER BY week
										ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
				 )) AS difference
		FROM services_weekly
		ORDER BY service, week
        ) AS tb_1
WHERE week BETWEEN 10 AND 20;


-- Practice Questions:
-- 1. Calculate running total of patients admitted by week for each service.
SELECT
	service,
    week,
    patients_admitted,
    SUM(patients_admitted) OVER
				(PARTITION BY service
					ORDER BY week) AS total_admission
FROM services_weekly
ORDER BY service, week;

-- 2. Find the moving average of patient satisfaction over 4-week periods.
SELECT
	service,
    week,
    patient_satisfaction,
    ROUND(AVG(patient_satisfaction) OVER
				(PARTITION BY service
					ORDER BY week
						ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING),
		 2) AS moving_avg_4_week
FROM services_weekly
ORDER BY service, week;

-- 3. Show cumulative patient refusals by week across all services.
SELECT
	service,
    week,
    patients_refused,
    SUM(patients_refused) OVER
					(ORDER BY week) AS cumulative_refusals
FROM services_weekly
ORDER BY service, week;