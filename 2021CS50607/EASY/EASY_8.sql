SELECT DISTINCT p.subject_id, p.anchor_age
FROM patients p
JOIN diagnoses_icd diag_icd ON p.subject_id = diag_icd.subject_id
JOIN d_icd_diagnoses d ON diag_icd.icd_code = d.icd_code AND diag_icd.icd_version = d.icd_version
JOIN icustays icu ON diag_icd.subject_id = icu.subject_id AND diag_icd.hadm_id = icu.hadm_id
WHERE d.long_title = 'Typhoid fever' AND icu.stay_id IS NOT NULL;