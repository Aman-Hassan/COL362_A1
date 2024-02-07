WITH latest_meningitis_patients AS (
    SELECT p.subject_id, p.gender, d.long_title, a.hospital_expire_flag
    FROM patients p
    JOIN admissions a ON p.subject_id = a.subject_id
    JOIN diagnoses_icd di ON a.subject_id = di.subject_id AND a.hadm_id = di.hadm_id
    JOIN d_icd_diagnoses d ON di.icd_code = d.icd_code
    WHERE d.long_title LIKE '%Meningitis%'
    AND a.admittime IN (
        SELECT MAX(a2.admittime)
        FROM admissions a2
        WHERE a2.subject_id = p.subject_id
    )
),
meningitis_gender_counts AS (
    SELECT gender, COUNT(*) AS total
    FROM latest_meningitis_patients
    GROUP BY gender
),
meningitis_death_counts AS (
    SELECT gender, COUNT(*) AS deaths
    FROM latest_meningitis_patients
    WHERE hospital_expire_flag = 1
    GROUP BY gender
)
SELECT dc.gender, ROUND((dc.deaths::decimal / gc.total::decimal) * 100, 2) AS mortality_rate
FROM meningitis_gender_counts gc
JOIN meningitis_death_counts dc ON gc.gender = dc.gender
ORDER BY mortality_rate ASC, dc.gender DESC;