-- Randy's Query V2 - pulls last image per patient - 8.7k
-- Extracting img_path, ptid, age, sex
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

-- Randy's Query V3 - pulls all images - 530k
-- Extracting img_path, ptid, age, sex
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


-- Steve's starting code
--All columns join
SELECT * from axispacs_snowflake.file_paths_and_meta as f 
INNER JOIN ehr.ophthalmologypatients as op 
ON f.ptid = CAST(op.pat_id as VARCHAR)
LIMIT 10;

--Getting age from birth_date column
SELECT f.*, op.*, 
       EXTRACT(YEAR FROM AGE(op.birth_date)) AS patient_age
FROM axispacs_snowflake.file_paths_and_meta AS f 
INNER JOIN ehr.ophthalmologypatients AS op 
ON f.ptid = CAST(op.pat_id AS VARCHAR)
LIMIT 10;

--Keeping relevant columns from respective tables
SELECT f.file_path_coris, f.year, f.month, f.day, f.exsrno, f.ptsrno, f.ptid, f.devname, f.devtype, f.fileeye, f.filenote, f.filetype, f.tmstamp, op.pat_id, op.pat_mrn, op.pat_sex, op.birth_date, op.ethnic,
       EXTRACT(YEAR FROM AGE(op.birth_date)) AS patient_age
FROM axispacs_snowflake.file_paths_and_meta AS f 
INNER JOIN ehr.ophthalmologypatients AS op 
ON f.ptid = CAST(op.pat_id AS VARCHAR)
LIMIT 10;

--Joins to include data from ehr.ophthalmologyencounters
