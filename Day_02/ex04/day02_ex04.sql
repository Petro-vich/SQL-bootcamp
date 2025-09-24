SELECT mn.pizza_name, pz.name AS pizzeria_name, mn.price 
FROM pizzeria pz
JOIN menu mn ON mn.pizzeria_id = pz.id
WHERE mn.pizza_name IN ('mushroom pizza', 'pepperoni pizza')
ORDER BY 1, 2