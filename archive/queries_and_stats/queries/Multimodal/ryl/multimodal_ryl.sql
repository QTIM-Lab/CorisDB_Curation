-- Randy's version 
-- Selects all columns from table "file_paths_and_meta" in the schema "axispacs_snowflake" 
-- and all columns from table "ophthalmologypatients" in the schema "ehr", joining them based
--  on matching patient IDs, limited to 10 rows.
SELECT * from axispacs_snowflake.file_paths_and_meta as f 
INNER JOIN ehr.ophthalmologypatients as op 
ON f.ptid = CAST(op.pat_id as VARCHAR)
WHERE f.devtype IN ('Optos', 'OPTOS')
LIMIT 20;

--Getting age from birth_date column
-- Selects all columns from table "file_paths_and_meta" and all columns 
-- from table "ophthalmologypatients", calculates patient age from birth date, 
-- joining them based on matching patient IDs, limited to 10 rows.

SELECT f.*, op.*, 
       EXTRACT(YEAR FROM AGE(op.birth_date)) AS patient_age
FROM axispacs_snowflake.file_paths_and_meta AS f 
INNER JOIN ehr.ophthalmologypatients AS op 
ON f.ptid = CAST(op.pat_id AS VARCHAR)
WHERE f.devtype IN ('Optos', 'OPTOS')
LIMIT 20;

-- 1.1 Keeping relevant columns from respective tables
-- Selects specific columns from both tables "file_paths_and_meta" 
-- and "ophthalmologypatients", calculates patient age from birth date, 
-- joining them based on matching patient IDs, limited to 10 rows.

-- 1.2 Removing some columns 
-- SELECT f.file_path_coris, f.year, f.month, f.day, f.exsrno, f.ptsrno, f.ptid, f.devname, f.devtype, f.fileeye, f.filenote, f.filetype, f.tmstamp, op.pat_id, op.pat_mrn, op.pat_sex, op.birth_date, op.ethnic,

SELECT f.file_path_coris, f.ptid, f.devname, f.devtype, op.pat_id, op.pat_sex, op.birth_date, op.ethnic,
       EXTRACT(YEAR FROM AGE(op.birth_date)) AS patient_age
FROM axispacs_snowflake.file_paths_and_meta AS f 
INNER JOIN ehr.ophthalmologypatients AS op 
ON f.ptid = CAST(op.pat_id AS VARCHAR)
WHERE f.devtype IN ('Optos', 'OPTOS')
LIMIT 20;

--Joins to include data from ehr.ophthalmologyencounters


-- Sanity check -
-- Check for distinct formatting of ptid
SELECT DISTINCT ptid
FROM axispacs_snowflake.file_paths_and_meta
WHERE devdescription IN ('Optos', 'OPTOS')
LIMIT 100; -- Sample to get an idea of the format

-- Check for distinct formatting of pat_id
SELECT DISTINCT pat_mrn
FROM ehr.ophthalmologypatients
LIMIT 100; -- Sample to get an idea of the format
