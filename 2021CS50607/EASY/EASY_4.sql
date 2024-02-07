SELECT COUNT(DISTINCT CONCAT(icd_version,icd_code)) AS count 
FROM procedures_icd 
WHERE subject_id = '10000117';