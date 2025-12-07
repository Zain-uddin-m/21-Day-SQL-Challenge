-- Day 8 of 21-DAY SQL Challenge:

-- Day 8 SQL challenge question:
-- Create a patient summary that shows patient_id, full name in uppercase, service in lowercase,
-- age category (if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), and name length.
-- Only show patients whose name length is greater than 10 characters.
SELECT
	patient_id,
    UPPER(name) AS  full_name,
    LOWER(service) AS lower_service,
CASE
	WHEN age >= 65 THEN 'Senior'
    WHEN age >= 18 THEN 'Adult'
    ELSE 'Minor'
END AS age_category,
	length(name) AS name_length
FROM patients
WHERE length(name) > 10;


-- Practice questions:
-- 1. Convert all patient names to uppercase.
SELECT
	name,
	UPPER(name)
FROM hospital.patients;

-- 2. Find the length of each staff member's name.
SELECT
	staff_name,
	length(staff_name)
FROM staff;

-- 3. Concatenate staff_id and staff_name with a hyphen separator.
SELECT
	staff_id,
    staff_name,
    CONCAT(staff_id, ' - ', staff_name) AS staff_info
FROM staff;