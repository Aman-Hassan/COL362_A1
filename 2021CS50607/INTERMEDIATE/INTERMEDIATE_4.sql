SELECT a.subject_id, a.hadm_id, d_icd.icd_code, d_icd.long_title
FROM admissions a JOIN diagnoses_icd diag_icd ON a.subject_id = diag_icd.subject_id AND a.hadm_id = diag_icd.hadm_id
JOIN d_icd_diagnoses d_icd ON diag_icd.icd_code = d_icd.icd_code
WHERE a.admission_type = 'URGENT' AND a.hospital_expire_flag = 1 AND d_icd.long_title IS NOT NULL
ORDER BY a.subject_id DESC, a.hadm_id DESC, d_icd.icd_code DESC, d_icd.long_title DESC
limit 1000;