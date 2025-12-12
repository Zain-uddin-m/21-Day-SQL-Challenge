-- Day 14 0f 21-DAY SQL Challenge:
-- Topics: LEFT JOIN, RIGHT JOIN, including unmatched records

-- Day 14 SQL Challenge question:
-- Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service)
-- and the count of weeks they were present (from staff_schedule). Include staff members even if they have no schedule records.
-- Order by weeks present descending.
SELECT
	s.staff_id,
    s.staff_name,
    s.role AS staff_role,
    s.service AS services,
    COUNT(ss.week) AS weeks_schedule,
    SUM(COALESCE(ss.present, 0)) AS weeks_present
FROM staff s
	LEFT JOIN staff_schedule ss
		ON s.staff_id = ss.staff_id
GROUP BY s.staff_id, s.staff_name, s.role, s.service
ORDER BY weeks_present DESC;


-- Practice questions:
-- 1. Show all staff members and their schedule information (including those with no schedule entries).
SELECT
	s.staff_id,
    s.staff_name,
    s.role AS staff_role,
    s.service AS services,
    COUNT(ss.week) AS staff_scheduled,
    SUM(COALESCE(ss.present, 0)) AS weeks_present
FROM staff s
	LEFT JOIN staff_schedule ss
		ON s.staff_id = ss.staff_id
GROUP BY s.staff_id, s.staff_name, s.role, s.service;

-- 2. List all services from services_weekly and their corresponding staff (show services even if no staff assigned).
SELECT
	sw.service,
    s.staff_name,
    COUNT(sw.week) AS weeks_scheduled
FROM services_weekly sw
	LEFT JOIN staff s
		ON sw.service = s.service
GROUP BY sw.service, s.staff_name, sw.week;

-- 3. Display all patients and their service's weekly statistics (if available).
SELECT
	p.patient_id,
    p.name AS patient_name,
    p.service AS services,
    sw.patient_satisfaction,
    COUNT(sw.week) AS weeks
FROM patients p
	LEFT JOIN services_weekly sw
		ON p.service = sw.service
GROUP BY p.patient_id, p.name, p.service, sw.patient_satisfaction
ORDER BY patient_name;