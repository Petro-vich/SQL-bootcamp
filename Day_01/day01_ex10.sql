SELECT 
	pr.name AS person_name,
    mn.pizza_name AS pizza_name, 
    pz.name AS pizzeria_name   
FROM person_order AS po 
JOIN person pr on po.person_id = pr.id
JOIN menu mn on po.menu_id = mn.id
JOIN pizzeria pz on pz.id = mn.pizzeria_id
ORDER BY person_name, pizza_name, pizza_name