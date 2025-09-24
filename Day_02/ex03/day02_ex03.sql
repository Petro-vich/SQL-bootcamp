WITH days AS (
  SELECT generate_series('2022-01-01', '2022-01-10', '1 day'::interval)::date AS day_date
)
SELECT day_date AS missing_date
FROM days
LEFT JOIN (
    SELECT visit_date 
    FROM person_visits 
    WHERE person_id IN (1, 2)
) AS pv ON days.day_date = pv.visit_date
WHERE pv.visit_date IS NULL
ORDER BY missing_date;