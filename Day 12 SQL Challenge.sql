-- Day 12 of 21-DAY SQL Challenge:
-- Topics: NULL handling, IS NULL, IS NOT NULL, COALESCE
   
-- Day 12 SQL challenge question:
-- Analyze the event impact by comparing weeks with events vs weeks without events.
-- Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale.
-- Order by average patient satisfaction descending.
SELECT
	CASE
		WHEN event = 'None' OR event = ' ' OR event IS NOT NULL
        THEN 'With event'
        ELSE 'No event'
	END AS event_status,
    COUNT(week) AS week_count,
    ROUND (
		AVG(patient_satisfaction), 2) AS avg_satisfacion,
    ROUND (
		AVG(staff_morale), 2) AS avg_staff_morale
FROM services_weekly
GROUP BY event_status
ORDER BY AVG(patient_satisfaction) DESC;

-- Practice questions:
-- Find all weeks in services_weekly where no special event occurred.
SELECT
	week,
    COUNT(*) AS count,
    event
FROM services_weekly
WHERE event = 'None'
GROUP BY week
ORDER BY count DESC;
-- OR --
SELECT DISTINCT week, event
FROM services_weekly
WHERE event = 'None' OR event = ' ';

-- 2. Count how many records have null or empty event values.
SELECT COUNT(*) AS total_events
FROM services_weekly
WHERE event = 'None' OR event = ' ';

-- 3. List all services that had at least one week with a special event.
SELECT DISTINCT service
FROM services_weekly
WHERE event != 'None'
AND event <> ' '
AND event IS NOT NULL;
-- OR --
SELECT
	service,
	COUNT(event) as special_event
FROM services_weekly
WHERE event IS NOT NULL
GROUP BY service;