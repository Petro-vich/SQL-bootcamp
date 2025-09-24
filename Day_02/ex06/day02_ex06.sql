SELECT mn.pizza_name AS pizza_name, pz.name AS pizzeria_name 
FROM pizzeria pz
JOIN menu mn ON pz.id = mn.pizzeria_id
JOIN person_order po ON mn.id = po.menu_id
JOIN person p ON p.id = po.person_id
WHERE p.name IN ('Denis', 'Anna')

ORDER BY 1,2