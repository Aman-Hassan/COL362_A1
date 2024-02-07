SELECT p.subject_id, p.anchor_age, COUNT(icu.stay_id) AS count
FROM patients p join icustays icu ON p.subject_id = icu.subject_id
WHERE icu.first_careunit = 'Coronary Care Unit (CCU)' 
GROUP BY p.subject_id
HAVING COUNT(icu.stay_id) = (
    SELECT MAX(count)
    FROM (
        SELECT COUNT(stay_id) AS count
        FROM icustays
        WHERE first_careunit = 'Coronary Care Unit (CCU)'
        GROUP BY subject_id
    ) AS subquery
)
ORDER BY count desc, anchor_age desc, subject_id desc;