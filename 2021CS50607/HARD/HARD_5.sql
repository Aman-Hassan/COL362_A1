WITH RECURSIVE path_length_5 (patient1, patient2, depth) AS (
    SELECT patient1, patient2, 1
    FROM graph_edges 
    WHERE patient1 = '10001725'
    UNION ALL
    SELECT pl5.patient1, ge.patient2, pl5.depth + 1
    FROM path_length_5 pl5
    JOIN graph_edges ge ON pl5.patient2 = ge.patient1
    WHERE pl5.depth < 5
),
initial_admissions AS (
    SELECT a.subject_id, a.hadm_id, a.admittime, a.dischtime
    FROM admissions a
    ORDER BY a.admittime
    LIMIT 500
),
early_admissions AS (
    SELECT * FROM initial_admissions
    WHERE admittime < dischtime and dischtime is not null
),
admissions_with_diagnoses AS (
    SELECT e.subject_id, e.hadm_id, e.admittime, e.dischtime, d.icd_code, d.icd_version
    FROM early_admissions e
    JOIN diagnoses_icd d ON e.subject_id = d.subject_id AND e.hadm_id = d.hadm_id
),
graph_edges AS (
    SELECT DISTINCT a1.subject_id AS patient1, a2.subject_id AS patient2
    FROM admissions_with_diagnoses a1
    JOIN admissions_with_diagnoses a2 ON a1.subject_id <> a2.subject_id AND a1.dischtime > a2.admittime AND a1.admittime < a2.dischtime AND a1.icd_code = a2.icd_code AND a1.icd_version = a2.icd_version
)
SELECT COUNT(*) > 0 AS pathexists FROM path_length_5 WHERE patient2 = '19438360';