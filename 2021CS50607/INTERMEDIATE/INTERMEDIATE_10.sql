SELECT p.subject_id, pt.anchor_year, p.drug
FROM (
    SELECT subject_id, drug
    FROM prescriptions
    GROUP BY subject_id, drug
    HAVING COUNT(DISTINCT hadm_id) > 1
) p
JOIN patients pt ON p.subject_id = pt.subject_id
ORDER BY p.subject_id DESC, pt.anchor_year DESC, p.drug DESC
LIMIT 1000;