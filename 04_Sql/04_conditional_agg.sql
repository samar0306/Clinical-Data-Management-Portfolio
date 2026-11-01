-- Percentage Hispanic per site
SELECT site_id,
ROUND(COUNT(CASE WHEN ethnicity = 'Hispanic or Latino' THEN 1 END)*100.0/COUNT(*),1) as pct_hispanic,
ROUND(AVG(age),1) as avg_age
FROM subjects
GROUP BY site_id
ORDER BY pct_hispanic DESC;

-- Sites >20% Hispanic AND avg age >55 (no rows = valid answer)
SELECT site_id,
ROUND(COUNT(CASE WHEN ethnicity = 'Hispanic or Latino' THEN 1 END)*100.0/COUNT(*),1) as pct_hispanic,
ROUND(AVG(age),1) as avg_age
FROM subjects
GROUP BY site_id
HAVING COUNT(CASE WHEN ethnicity = 'Hispanic or Latino' THEN 1 END)*100.0/COUNT(*) > 20
AND AVG(age) > 55;
