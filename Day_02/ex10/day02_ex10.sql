SELECT p1.name, p2.name, p1.address AS common_address
FROM person p1
INNER JOIN person p2 ON p1.id > p2.id
AND p1.address = p2.address
ORDER BY 1, 2, 3