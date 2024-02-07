WITH icu_procedures AS (
    SELECT icu.subject_id, icu.hadm_id, icu.los, proc.icd_code, proc.icd_version
    FROM icustays icu 
    JOIN procedures_icd proc ON icu.subject_id = proc.subject_id AND icu.hadm_id = proc.hadm_id
),
avg_icu_stay AS (
    SELECT icd_code, icd_version, AVG(los) AS avg_los
    FROM icu_procedures
    GROUP BY icd_code, icd_version
)
SELECT DISTINCT p.subject_id, p.gender, ip.icd_code, ip.icd_version
FROM patients p 
JOIN icu_procedures ip ON p.subject_id = ip.subject_id
JOIN avg_icu_stay ais ON ip.icd_code = ais.icd_code AND ip.icd_version = ais.icd_version
WHERE ip.los < ais.avg_los
ORDER BY p.subject_id ASC, ip.icd_code DESC, ip.icd_version DESC, p.gender ASC
LIMIT 1000;