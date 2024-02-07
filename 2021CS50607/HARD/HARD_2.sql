WITH mortality_rates AS (
    SELECT diag_icd.icd_code, diag_icd.icd_version, d.long_title, (COUNT(CASE WHEN a.hospital_expire_flag = 1 THEN 1 END) * 100.0 / COUNT(*)) AS mortality_rate
    FROM admissions a 
    JOIN diagnoses_icd diag_icd ON a.subject_id = diag_icd.subject_id AND a.hadm_id = diag_icd.hadm_id
    JOIN d_icd_diagnoses d ON diag_icd.icd_code = d.icd_code AND diag_icd.icd_version = d.icd_version
    GROUP BY diag_icd.icd_code, diag_icd.icd_version, d.long_title
),
top_diagnoses AS (
    SELECT icd_code, icd_version, long_title, mortality_rate
    FROM mortality_rates
    ORDER BY mortality_rate DESC
    LIMIT 245
),
dead_patients AS (
    SELECT a.subject_id, td.icd_code, td.icd_version
    FROM top_diagnoses td
    JOIN diagnoses_icd diag_icd ON td.icd_code = diag_icd.icd_code AND td.icd_version = diag_icd.icd_version
    JOIN admissions a ON diag_icd.subject_id = a.subject_id AND diag_icd.hadm_id = a.hadm_id AND a.hospital_expire_flag = 1
),
survived_avg_patient AS (
    SELECT td.icd_code, td.icd_version, td.long_title, AVG(p.anchor_age) AS survived_avg_age
    FROM top_diagnoses td
    JOIN diagnoses_icd diag_icd ON td.icd_code = diag_icd.icd_code AND td.icd_version = diag_icd.icd_version
    JOIN admissions a ON diag_icd.subject_id = a.subject_id AND diag_icd.hadm_id = a.hadm_id AND a.hospital_expire_flag = 0
    JOIN patients p ON a.subject_id = p.subject_id 
    WHERE (p.subject_id, diag_icd.icd_code, diag_icd.icd_version) NOT IN (SELECT subject_id, icd_code, icd_version FROM dead_patients)
    GROUP BY td.icd_code, td.icd_version, td.long_title
)
SELECT long_title, ROUND(survived_avg_age, 2) AS survived_avg_age
FROM survived_avg_patient
ORDER BY long_title ASC, survived_avg_age DESC;