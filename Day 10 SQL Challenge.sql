-- Day 9 of 21-DAY SQL Challenge:

-- Day 9 SQL challenge question:
-- Create a service performance report showing service name, total patients admitted, and a performance category based on the
-- following: 'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'.
-- Order by average satisfaction descending.
SELECT
	service,
    SUM(patients_admitted) AS total_p_admitted,
    ROUND(AVG(patient_satisfaction), 2) AS average_satifaction,
    CASE
		WHEN AVG(patient_satisfaction) >= 85 THEN 'Excellent'
        WHEN AVG(patient_satisfaction) >= 75 THEN 'Good'
        WHEN AVG(patient_satisfaction) >= 65 THEN 'Fair'
        ELSE 'Need Improvement'
	END AS category_performance
FROM services_weekly
GROUP BY service
ORDER BY average_satifaction;


-- Practice questions:
-- 1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
SELECT
	patient_id,
    name,
    satisfaction,
    CASE
		WHEN satisfaction >= 80 THEN 'High'
        WHEN satisfaction BETWEEN 50 AND 80 THEN 'Medium'
        WHEN satisfaction <= 45 THEN 'Low'
		ELSE 'Null'
    END AS categorical_sat
FROM patients
ORDER BY categorical_sat;
    
-- 2. Label staff roles as 'Medical' or 'Support' based on role type.
SELECT
	staff_id,
    staff_name,
    role,
    CASE
		WHEN role = 'Doctor' THEN 'Medical'
        WHEN role = 'Nurse' THEN 'Suppot'
        WHEN role = 'nursing_assistant' THEN 'Support'
        ELSE 'Null'
	END AS role_label
FROM staff;
    
-- 3. Create age groups for patients (0-18, 19-40, 41-65, 65+).
SELECT
	patient_id,
    name,
    age,
    CASE
		WHEN age BETWEEN 0 AND 18 THEN 'Minor'
        WHEN age BETWEEN 19 AND 40 THEN 'Adult'
        WHEN age BETWEEN 41 AND 65 THEN 'Senoir'
        WHEN age >= 65 THEN 'Super-senior(Retired)'
        ELSE 'Null'
	END AS age_group
FROM patients;