SELECT name, COALESCE(bonus, 0) AS bonus 
FROM staff
ORDER BY name ASC;
