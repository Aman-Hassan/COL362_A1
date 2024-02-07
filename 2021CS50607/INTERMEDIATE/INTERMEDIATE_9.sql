SELECT a1.subject_id 
FROM admissions a1 
JOIN admissions a2 ON a1.subject_id = a2.subject_id AND a1.hadm_id != a2.hadm_id
JOIN diagnoses_icd diag_icd ON a1.subject_id = diag_icd.subject_id AND a1.hadm_id = diag_icd.hadm_id
WHERE a1.dischtime < a2.admittime AND diag_icd.icd_code LIKE 'I21%'
GROUP BY a1.subject_id
ORDER BY a1.subject_id DESC
LIMIT 1000;