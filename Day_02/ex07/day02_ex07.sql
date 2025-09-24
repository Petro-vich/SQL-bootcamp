SELECT pz.name AS pizzeria_name
FROM pizzeria pz
JOIN person_visits pv on pv.pizzeria_id = pz.id 
JOIN menu mn on mn.pizzeria_id = pz.id  
JOIN person p on p.id = pv.person_id
WHERE 
    p.name = 'Dmitriy' 
    AND pv.visit_date = '2022-01-08'
    AND mn.price <= 800