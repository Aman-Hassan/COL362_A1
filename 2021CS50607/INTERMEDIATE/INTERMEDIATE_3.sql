SELECT subject_id, COUNT(*) as diagnoses_count
FROM drgcodes 
WHERE lower(description) LIKE '%alcoholic%'
GROUP by subject_id
HAVING COUNT(*) > 1
ORDER BY diagnoses_count DESC, subject_id DESC;