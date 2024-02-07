SELECT subject_id, COUNT(DISTINCT stay_id) as total_stays, AVG(los) as avg_length_of_stay
FROM icustays 
WHERE los IS NOT NULL AND (first_careunit LIKE '%MICU%' OR last_careunit LIKE '%MICU%')
GROUP BY subject_id
HAVING COUNT(DISTINCT stay_id) >= 5
ORDER BY avg_length_of_stay DESC, total_stays DESC, subject_id DESC
LIMIT 500;