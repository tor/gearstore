SELECT d.amount, u.name, 'NEW' as source
FROM drupal7.gs3_deposits d
JOIN drupal7.gs3_users u
	ON d.user_id = u.id
WHERE d.amount > 0
UNION 
SELECT d.amount, u.name, 'OLD' as source
FROM anumc.gs3_deposits d
JOIN anumc.gs3_users u
	ON d.user_id = u.id
WHERE d.amount > 0
ORDER BY 2;