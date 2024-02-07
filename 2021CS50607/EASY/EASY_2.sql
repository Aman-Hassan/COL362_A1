SELECT p.subject_id, COUNT(*) AS num_admissions
FROM patients p 
JOIN admissions a ON p.subject_id = a.subject_id 
GROUP BY p.subject_id
HAVING COUNT(*) = (
    SELECT MAX(admissions_count)
    FROM (
        SELECT COUNT(*) AS admissions_count
        FROM admissions
        GROUP BY subject_id
        ) AS subquery
    )
ORDER BY p.subject_id ASC;