  SELECT p.name 
  FROM person p
  JOIN person_order po ON p.id = po.person_id
  JOIN menu mn ON mn.id = po.menu_id
  WHERE (p.gender = 'male')
  AND (p.address = 'Moscow' OR p.address = 'Samara')
  AND (mn.pizza_name = 'pepperoni pizza' OR  mn.pizza_name = 'mushroom pizza')
  ORDER BY p.name DESC