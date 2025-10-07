
-- ###################
-- V2 - 1 image per pt - 8.3k 
-- ONLY extracting path, age, sex 
-- ###################
-- ONLY extracting path, age, sex, and ptid
WITH RankedImages AS (
    SELECT 
        f.ptid,
        f.file_path_coris,
        EXTRACT(YEAR FROM AGE(op.birth_date)) AS patient_age,
        op.pat_sex,
        ROW_NUMBER() OVER(PARTITION BY f.ptid ORDER BY f.tmstamp DESC) AS rn
    FROM axispacs_snowflake.file_paths_and_meta AS f 
    INNER JOIN ehr.ophthalmologypatients AS op 
    ON f.ptid = CAST(op.pat_mrn AS VARCHAR)
    WHERE f.devdescription IN ('Optos', 'OPTOS')
)
SELECT 
    file_path_coris,
    ptid,
    patient_age,
    pat_sex
FROM RankedImages
WHERE rn = 1


-- V3 - all image per pt 530k
WITH AllImages AS (
    SELECT 
        f.ptid,
        f.file_path_coris,
        EXTRACT(YEAR FROM AGE(op.birth_date)) AS patient_age,
        op.pat_sex
    FROM axispacs_snowflake.file_paths_and_meta AS f 
    INNER JOIN ehr.ophthalmologypatients AS op 
    ON f.ptid = CAST(op.pat_mrn AS VARCHAR)
    WHERE f.devdescription IN ('Optos', 'OPTOS')
)
SELECT 
    file_path_coris,
    ptid,
    patient_age,
    pat_sex
FROM AllImages

-- V4 - one image per pt + progress note
WITH RankedImages AS (
    SELECT 
        f.ptid,
        f.file_path_coris,
        EXTRACT(YEAR FROM AGE(op.birth_date)) AS patient_age,
        op.pat_sex,
        oe.progress_note,
        ROW_NUMBER() OVER(PARTITION BY f.ptid ORDER BY f.tmstamp DESC) AS rn
    FROM axispacs_snowflake.file_paths_and_meta AS f 
    INNER JOIN ehr.ophthalmologypatients AS op 
    ON f.ptid = CAST(op.pat_mrn AS VARCHAR)
    INNER JOIN ehr.ophthalmologyencountervisit AS oe
    ON op.pat_mrn = oe.pat_mrn -- Join using pat_mrn
    WHERE f.devdescription IN ('Optos', 'OPTOS')
)
SELECT 
    file_path_coris,
    ptid,
    patient_age,
    pat_sex,
    progress_note
FROM RankedImages
WHERE rn = 1
LIMIT 20;



-- Sanity Check 
-- Check for distinct formatting of ptid
-- Use op.pat_mrn NOT op.pat_id 
SELECT DISTINCT ptsrno
FROM axispacs_snowflake.file_paths_and_meta
WHERE devdescription IN ('Optos', 'OPTOS')
LIMIT 1000; -- Sample to get an idea of the format

-- Check for distinct formatting of pat_id
SELECT DISTINCT pat_id
FROM ehr.ophthalmologypatients
LIMIT 1000; -- Sample to get an idea of the format
