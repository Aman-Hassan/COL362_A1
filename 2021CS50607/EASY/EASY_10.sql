SELECT p.subject_id, p.anchor_age
FROM patients p
WHERE p.anchor_age < 50
AND exists (
    SELECT 1
    FROM procedures_icd pr1
    join procedures_icd pr2 ON pr1.subject_id = pr2.subject_id
        AND pr1.icd_version = pr2.icd_version
        AND pr1.icd_code = pr2.icd_code
        AND pr1.hadm_id <> pr2.hadm_id
    WHERE pr1.subject_id = p.subject_id
)
ORDER BY p.subject_id ASC, p.anchor_age ASC;