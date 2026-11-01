-- RANK oldest per site
WITH ranked AS (
  SELECT site_id, subject_id, age, RANK() OVER (PARTITION BY site_id ORDER BY age DESC) as rnk
  FROM subjects
)
SELECT * FROM ranked WHERE rnk=1;

-- Top 2 per site (people)
WITH ranked AS (
  SELECT site_id, subject_id, age, ROW_NUMBER() OVER (PARTITION BY site_id ORDER BY age DESC) as rnk
  FROM subjects
)
SELECT * FROM ranked WHERE rnk<=2;

-- LAG previous age per site (oldest to youngest)
SELECT site_id, subject_id, age,
LAG(age) OVER (PARTITION BY site_id ORDER BY age DESC) as prev_age
FROM subjects
ORDER BY site_id, age DESC;

-- LEAD next age per site
SELECT site_id, subject_id, age,
LEAD(age) OVER (PARTITION BY site_id ORDER BY age DESC) as next_age
FROM subjects
ORDER BY site_id, age DESC;

-- LAG whole table oldest to youngest (76 down to 25)
SELECT subject_id, age,
LAG(age) OVER (ORDER BY age DESC) as prev_age
FROM subjects
ORDER BY age DESC;

-- LEAD whole table youngest to oldest (25 up to 76)
SELECT subject_id, age,
LEAD(age) OVER (ORDER BY age ASC) as next_age
FROM subjects
ORDER BY age ASC;

-- Running count per site
SELECT site_id, subject_id, age,
ROW_NUMBER() OVER (PARTITION BY site_id ORDER BY age DESC) as running_count
FROM subjects;

-- AVG OVER site average in same row (keeps 500 rows)
SELECT subject_id, site_id, age,
AVG(age) OVER (PARTITION BY site_id) as site_avg
FROM subjects;

-- Age above site average (CTE)
WITH with_avg AS (
  SELECT *, AVG(age) OVER (PARTITION BY site_id) as site_avg
  FROM subjects
)
SELECT * FROM with_avg WHERE age > site_avg;

-- Basic ranking by age descending
SELECT subject_id, age, RANK() OVER (ORDER BY age DESC) as age_rank
FROM subjects
ORDER BY age_rank
LIMIT 10;

-- Ranking vs dense rank vs row number on same age column
SELECT subject_id, age,
RANK() OVER (ORDER BY age DESC) as rnk,
DENSE_RANK() OVER (ORDER BY age DESC) as dense_rnk,
ROW_NUMBER() OVER (ORDER BY age DESC) as row_num
FROM subjects
ORDER BY age DESC
LIMIT 10;

-- Ranking within each site by age descending
SELECT subject_id, site_id, age,
RANK() OVER (PARTITION BY site_id ORDER BY age DESC) as site_age_rank
FROM subjects
ORDER BY site_id, site_age_rank
LIMIT 20;

-- Oldest subject per site using rank partition
WITH ranked AS (
  SELECT subject_id, site_id, age,
  RANK() OVER (PARTITION BY site_id ORDER BY age DESC) as rnk
  FROM subjects
)
SELECT site_id, subject_id, age FROM ranked WHERE rnk = 1;

-- Oldest subject per treatment group
WITH ranked_treat AS (
  SELECT subject_id, treatment, age,
  RANK() OVER (PARTITION BY treatment ORDER BY age DESC) as rnk
  FROM subjects
)
SELECT treatment, subject_id, age FROM ranked_treat WHERE rnk = 1;

-- Second oldest subject per site
WITH ranked AS (
  SELECT site_id, subject_id, age,
  RANK() OVER (PARTITION BY site_id ORDER BY age DESC) as rnk
  FROM subjects
)
SELECT * FROM ranked WHERE rnk = 2
ORDER BY site_id;

-- Second oldest overall using rank
WITH ranked AS (
  SELECT subject_id, age, site_id,
  RANK() OVER (ORDER BY age DESC) as rnk
  FROM subjects
)
SELECT * FROM ranked WHERE rnk = 2;

-- Top two oldest per site
WITH ranked AS (
  SELECT site_id, subject_id, age,
  ROW_NUMBER() OVER (PARTITION BY site_id ORDER BY age DESC) as rnk
  FROM subjects
)
SELECT site_id, subject_id, age, rnk
FROM ranked WHERE rnk <= 2
ORDER BY site_id, rnk;

-- Sites ranked by average age
WITH avg_per_site AS (
  SELECT site_id, AVG(age) as avg_age FROM subjects GROUP BY site_id
)
SELECT site_id, ROUND(avg_age,1) as avg_age,
RANK() OVER (ORDER BY avg_age DESC) as site_rank
FROM avg_per_site
ORDER BY site_rank;

-- Sites ranked by enrollment count
WITH cnt AS (
  SELECT site_id, COUNT(*) as total FROM subjects GROUP BY site_id
)
SELECT site_id, total,
RANK() OVER (ORDER BY total DESC) as enroll_rank
FROM cnt
ORDER BY enroll_rank;

-- Distinct ages ranked
WITH distinct_age AS (
  SELECT DISTINCT age FROM subjects
)
SELECT age, DENSE_RANK() OVER (ORDER BY age DESC) as dr
FROM distinct_age
ORDER BY dr
LIMIT 5;

-- Random subject per site using random order
WITH rnd AS (
  SELECT site_id, subject_id, age,
  ROW_NUMBER() OVER (PARTITION BY site_id ORDER BY RANDOM()) as rnd_rank
  FROM subjects
)
SELECT * FROM rnd WHERE rnd_rank = 1
ORDER BY site_id;
