
--Count per sex
SELECT sex, COUNT(*) as total
FROM subjects
GROUP BY sex;

--Count per site_id
SELECT site_id, COUNT(*) as total
FROM subjects
GROUP BY site_id
ORDER BY total DESC;

--Average age per treatment
SELECT treatment, ROUND(AVG(age),1) as avg_age, COUNT(*) as cnt
FROM subjects
GROUP BY treatment;

--Average height and weight per site
SELECT site_id, ROUND(AVG(height_cm),1) as avg_height, ROUND(AVG(weight_kg),1) as avg_weight
FROM subjects
GROUP BY site_id;

--Sites with >=50 subjects (HAVING)
SELECT site_id, COUNT(*) as total
FROM subjects
GROUP BY site_id
HAVING COUNT(*) >= 50;

--Ethnicity Hispanic count per site
SELECT site_id, COUNT(*) as hispanic_count
FROM subjects
WHERE ethnicity = 'Hispanic or Latino'
GROUP BY site_id;

--Screening status count per site
SELECT site_id, screening_status, COUNT(*) as cnt
FROM subjects
GROUP BY site_id, screening_status
ORDER BY site_id;

--Count per site per sex
SELECT site_id, sex, COUNT(*) as total
FROM subjects
GROUP BY site_id, sex
ORDER BY site_id;
