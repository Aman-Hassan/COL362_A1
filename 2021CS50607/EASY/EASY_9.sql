SELECT COUNT(DISTINCT adm.subject_id) 
FROM admissions adm 
JOIN labevents lab ON adm.hadm_id = lab.hadm_id AND adm.subject_id = lab.subject_id
WHERE lab.flag = 'abnormal' AND adm.hospital_expire_flag = 1;