-- 1
SELECT 
  name
FROM  
  users
JOIN
  orders 
ON 
  users.id = orders.user_id
GROUP BY 
  name;
  
-- 2
SELECT 
  p.name,
  c.name
FROM 
  products AS p
LEFT JOIN
  catalogs AS c 
ON 
  p.catalog_id = c.id;
  
  
-- 3
SELECT 
  fl.id,
  f.name AS откуда, 
  t.name AS куда
FROM
  cities AS f
JOIN
  cities AS t
JOIN
  flights as fl
ON 
  fl.from_city = f.label
AND 
  fl.to_city = t.label
ORDER BY fl.id;