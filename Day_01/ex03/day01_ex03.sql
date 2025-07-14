SELECT visit_date AS action_date, person_id 
FROM person_visits
INTERSECT
SELECT po.order_date AS action_date, po.person_id 
FROM person_order po
ORDER BY action_date ASC, person_id DESC