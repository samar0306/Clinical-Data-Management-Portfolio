-- Sites with >=50 subjects
SELECT site_id, COUNT(*) as total 
FROM subjects 
GROUP BY site_id 
HAVING COUNT(*) >=50;

-- Count per treatment with avg age
SELECT treatment, COUNT(*) as cnt, ROUND(AVG(age),1) as avg_age 
  FROM subjects 
  GROUP BY treatment;
