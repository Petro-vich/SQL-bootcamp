SELECT days::date AS missing_date
FROM generate_series('2022-01-01', '2022-01-10', '1 day'::interval) AS days
LEFT JOIN (
    SELECT visit_date 
    FROM person_visits 
    WHERE person_id = 1 OR person_id = 2
) AS pv ON days::date = pv.visit_date
WHERE pv.visit_date IS NULL
ORDER BY missing_date;