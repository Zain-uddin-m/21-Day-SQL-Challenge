-- Day 13 of 21-SQL Challenge
-- Topics: INNER JOIN, joining two tables, relationship understanding

-- Day 13 SQL question:
-- Create a comprehensive report showing patient_id, patient name, age, service, and the total number of staff members
-- available in their service. Only include patients from services that have more than 5 staff members.
-- Order by number of staff descending, then by patient name.
SELECT
	p.patient_id,
    p.name AS patient_name,
    p.age AS patient_age,
    p.service AS services,
    COUNT(s.staff_id) AS total_staff
FROM patients p
	INNER JOIN staff s
		ON p.service = s.service
GROUP BY p.patient_id, p.name, p.age, p.service
	HAVING COUNT(s.staff_id) > 5
ORDER BY total_staff DESC, p.name;


-- Practice Questions:
-- 1. Join patients and staff based on their common service field (show patient and staff who work in same service).
SELECT
	p.patient_id,
    p.name As patient_name,
    p.service,
    s.staff_name
FROM patients p
	INNER JOIN staff s
		ON p.service = s.service;

-- 2. Join services_weekly with staff to show weekly service data with staff information.
SELECT
	sw.week,
    sw.service AS services,
    s.staff_name,
    s.role AS staff_role
FROM services_weekly sw
	INNER JOIN staff s
		ON sw.service = s.service;

-- 3. Create a report showing patient information along with staff assigned to their service.
SELECT
	p.patient_id,
    p.name AS patient_name,
    p.service AS services,
    s.role AS staff_role,
    s.staff_name
FROM patients p
	INNER JOIN staff s
		ON p.service = s.service
ORDER BY p.service, p.name;