SELECT object_name
FROM (SELECT name AS object_name, 1 AS src_order FROM person
     UNION ALL
     SELECT pizza_name AS object_name, 2 AS srs_order FROM menu
     )
ORDER BY src_order, object_name
