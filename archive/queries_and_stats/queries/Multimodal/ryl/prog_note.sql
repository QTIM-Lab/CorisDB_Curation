-- V1 
SELECT 
    f.file_path_coris,
    oe.pat_id,
    oe.pat_mrn,
    oe.contact_date,
    oe.progress_note,
    f.exdatetime,
    EXTRACT(YEAR FROM AGE(op.birth_date)) AS patient_age,
    op.pat_sex
FROM 
    axispacs_snowflake.file_paths_and_meta AS f
INNER JOIN 
    ehr.ophthalmologyencountervisit AS oe
    ON oe.pat_mrn = CAST(f.ptid AS VARCHAR) AND DATE(f.exdatetime) = oe.contact_date -- Adjusted to join on date
INNER JOIN 
    ehr.ophthalmologypatients AS op 
    ON f.ptid = CAST(op.pat_mrn AS VARCHAR)
WHERE 
    f.devdescription IN ('Optos', 'OPTOS')
ORDER BY 
    oe.pat_mrn, f.exdatetime
LIMIT 20;


-- V2  
SELECT 
    f.file_path_coris,
    f.ptid,
    oe.pat_mrn,
    oe.contact_date,
    oe.progress_note,
    f.exdatetime,
    -- EXTRACT(YEAR FROM AGE(op.birth_date)) AS patient_age,
    EXTRACT(YEAR FROM AGE(f.exdatetime, op.birth_date)) AS patient_age,
    op.pat_sex
FROM 
    axispacs_snowflake.file_paths_and_meta AS f
INNER JOIN 
    ehr.ophthalmologyencountervisit AS oe
    ON CAST(f.ptid AS VARCHAR) = oe.pat_mrn AND DATE(f.exdatetime) = oe.contact_date -- Ensuring matching ptid with pat_mrn and aligning dates
INNER JOIN 
    ehr.ophthalmologypatients AS op 
    ON oe.pat_mrn = op.pat_mrn -- Joining patient details
WHERE 
    f.devdescription IN ('Optos', 'OPTOS')
ORDER BY 
    oe.pat_mrn, f.exdatetime
LIMIT 1000;
