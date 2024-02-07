SELECT p.subject_id, p.gender, COUNT(DISTINCT a.hadm_id) AS total_admissions, 
MAX(a.admittime) AS last_admission,MIN(a.admittime) AS first_admission,
SUM(CASE WHEN diag_icd.icd_code = '5723' THEN 1 ELSE 0 END) AS diagnosis_count
FROM patients p 
JOIN admissions a ON p.subject_id = a.subject_id
LEFT JOIN diagnoses_icd diag_icd ON a.subject_id = diag_icd.subject_id AND a.hadm_id = diag_icd.hadm_id
GROUP BY p.subject_id, p.gender
HAVING SUM(CASE WHEN diag_icd.icd_code = '5723' THEN 1 ELSE 0 END) > 0
ORDER BY total_admissions DESC, diagnosis_count DESC, last_admission DESC, first_admission DESC, gender DESC, p.subject_id DESC
LIMIT 1000;