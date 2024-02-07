SELECT phar.pharmacy_id, COUNT(DISTINCT phar.subject_id) AS num_patients_visited
FROM prescriptions phar 
GROUP BY phar.pharmacy_id
HAVING COUNT(DISTINCT phar.subject_id) = (
        SELECT MIN(num_patients_visited)
        FROM (
            SELECT COUNT(DISTINCT subject_id) AS num_patients_visited
            FROM prescriptions
            GROUP BY pharmacy_id
        ) AS subquery
    )
ORDER BY phar.pharmacy_id ASC;