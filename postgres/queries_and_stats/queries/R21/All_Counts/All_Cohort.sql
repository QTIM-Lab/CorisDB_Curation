-- All patients in Coris DB

-- Total Number of Unique Patients:
select count(distinct pat_mrn) from ehr.ophthalmologypatients

-- Average Number of Visits for each Patient:
SELECT AVG(visit_count)
FROM (
    SELECT DISTINCT pat_mrn, COUNT(DISTINCT pat_enc_csn_id) AS visit_count
    FROM ehr.ophthalmologyencounters
    GROUP BY pat_mrn
) AS subquery;

--Number of Visits
Select Count(DISTINCT pat_enc_csn_id)
FROM ehr.ophthalmologyencounters;


-- Median Number of Visits for each Patient:
WITH patient_visit_counts AS (
    SELECT pat_mrn, COUNT(DISTINCT pat_enc_csn_id) AS visit_count
    FROM ehr.ophthalmologyencounters
    GROUP BY pat_mrn
)

SELECT
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY visit_count) AS median
FROM patient_visit_counts;

-- Ratio of Male to Female Patients:
SELECT
    pat_sex,
    COUNT(DISTINCT pat_mrn) AS patient_count,
    COUNT(DISTINCT pat_mrn) / SUM(COUNT(DISTINCT pat_mrn)) OVER () AS sex_ratio
FROM  ehr.ophthalmologypatients
GROUP BY pat_sex;

--Average Age of Patients at Encounter:



-- Total Number of Images on all Devices (ONH Photos (Nidek, NonMyd, Photos), Cirrus OCTs, HVF):

SELECT count(DISTINCT file_path_coris) from 
axispacs_snowflake.file_paths_and_meta;

-- Total Number of OCT Images
SELECT count(DISTINCT file_path_coris) from 
axispacs_snowflake.file_paths_and_meta
Where devdescription like '%OCT%';

-- Total Number of Non-OCT "2D" Images
SELECT count(DISTINCT file_path_coris) from 
axispacs_snowflake.file_paths_and_meta
Where devdescription not like '%OCT%';

-- Total Number of Non-OCT "2D" Images
-- 2,567,140
-- Total Number of OCT Images
-- 7,431,851
-- Total
-- 9,998,991

-- Total Number of 3D OCT Images - devdescription like '%OCT%' and filenote like '%Volume%'
SELECT count(DISTINCT file_path_coris) from 
axispacs_snowflake.file_paths_and_meta
Where devdescription like '%OCT%' and filenote like '%Volume%';

-- Total Number of Non-OCT "2D" Images - Where filenote not like '%Volume%';
SELECT count(DISTINCT file_path_coris) from 
axispacs_snowflake.file_paths_and_meta
Where devdescription not like '%OCT%' and filenote not like '%Volume%';

-- Total Number of 2D OCT Images - Where devdescription like '%OCT%'  and filenote not like '%Volume%';
-- 1,140,961
-- Total Number of 3D OCT Images - devdescription like '%OCT%' and filenote like '%Volume%'
-- 5,958,256
-- Total Number of Non-OCT "2D" Images
-- 2,567,140