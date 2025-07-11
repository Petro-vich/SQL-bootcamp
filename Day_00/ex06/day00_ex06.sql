SELECT 
  (SELECT name FROM person WHERE id = person_order.person_id) AS name,
  (SELECT name FROM person WHERE id = person_order.person_id) = 'Denis' AS check_name,
  person_order
FROM person_order
WHERE menu_id IN (13,14,18)
AND order_date = '2022-01-07';