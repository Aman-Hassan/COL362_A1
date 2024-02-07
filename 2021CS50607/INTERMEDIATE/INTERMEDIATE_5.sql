SELECT icu.subject_id, AVG(icu.los) as avg_stay_duration
FROM icustays icu 
JOIN labevents lab ON icu.subject_id = lab.subject_id AND icu.hadm_id = lab.hadm_id
WHERE icu.los IS NOT NULL AND lab.itemid = 50878
GROUP BY icu.subject_id, icu.hadm_id
ORDER BY avg_stay_duration DESC, icu.subject_id DESC
LIMIT 1000;