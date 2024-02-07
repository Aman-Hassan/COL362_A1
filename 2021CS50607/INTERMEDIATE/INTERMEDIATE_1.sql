SELECT subject_id, COUNT(*) as count
FROM icustays 
GROUP BY subject_id
HAVING COUNT(*) >= 5
ORDER BY count DESC, subject_id DESC
LIMIT 1000;