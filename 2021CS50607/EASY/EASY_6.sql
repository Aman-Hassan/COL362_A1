SELECT COUNT(d.subject_id) 
FROM diagnoses_icd d 
JOIN d_icd_diagnoses diag ON d.icd_code = diag.icd_code 
WHERE diag.long_title='Cholera due to vibrio cholerae';