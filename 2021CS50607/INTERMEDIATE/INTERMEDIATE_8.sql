SELECT d.subject_id, d.hadm_id, COUNT(DISTINCT d.icd_code) AS distinct_diagnoses_count, p.drug
FROM DIAGNOSES_ICD d
JOIN PRESCRIPTIONS p ON d.subject_id = p.subject_id AND d.hadm_id = p.hadm_id
WHERE d.icd_code LIKE 'V4%' AND (LOWER(p.drug) LIKE '%prochlorperazine%' OR LOWER(p.drug) LIKE '%bupropion%')
GROUP BY d.subject_id, d.hadm_id, p.drug
HAVING COUNT(DISTINCT d.icd_code) > 1
ORDER BY distinct_diagnoses_count DESC, d.subject_id DESC, d.hadm_id DESC, p.drug ASC;