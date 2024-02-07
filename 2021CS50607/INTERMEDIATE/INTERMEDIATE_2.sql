SELECT p.drug AS drug, COUNT(*) AS prescription_count
FROM admissions a
JOIN prescriptions p ON a.subject_id = p.subject_id AND a.hadm_id = p.hadm_id
WHERE p.starttime BETWEEN a.admittime AND a.admittime + INTERVAL '12 hours'
GROUP BY p.drug
ORDER BY prescription_count DESC, drug DESC
LIMIT 1000;