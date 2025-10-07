-- # GLC - 10/23/2023
-- Number of Unique Glaucoma Patients by Year:
SELECT extract(YEAR from contact_date), count(DISTINCT pat_mrn) 
FROM "glaucoma"."glaucoma_encounters" 
Group by extract(YEAR from contact_date)
LIMIT 1000;

-- Total Number of Unique Glaucoma Patients:
select count(pat_mrn) from glaucoma.glaucoma_patients

-- Number of Unique Glaucoma Patient Visits per Year:
SELECT extract(YEAR from contact_date), count(DISTINCT pat_enc_csn_id) 
FROM "glaucoma"."glaucoma_encounters" 
Group by extract(YEAR from contact_date)
LIMIT 1000;

-- Average Number of Visits for each Glaucoma Patient (Glaucoma Visits):

SELECT AVG(visit_count)
FROM (
    SELECT DISTINCT pat_mrn, COUNT(DISTINCT pat_enc_csn_id) AS visit_count
    FROM "glaucoma"."glaucoma_visits"
    where progress_note like '%glaucoma%'
    GROUP BY pat_mrn
) AS subquery
LIMIT 1000;

-- Average Number of Visits for each Glaucoma Patient (Total Visits):

SELECT AVG(visit_count)
FROM (
    SELECT DISTINCT pat_mrn, COUNT(DISTINCT pat_enc_csn_id) AS visit_count
    FROM "glaucoma"."glaucoma_visits"
    GROUP BY pat_mrn
) AS subquery
LIMIT 1000;


-- Median Number of Visits for each Glaucoma Patient (Glaucoma Visits):

WITH patient_visit_counts AS (
    SELECT pat_mrn, COUNT(DISTINCT pat_enc_csn_id) AS visit_count
    FROM "glaucoma"."glaucoma_visits"
    where progress_note like '%glaucoma%'
    GROUP BY pat_mrn
)

SELECT
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY visit_count) AS median
FROM patient_visit_counts;

-- Median Number of Visits for each Glaucoma Patient (Total Visits):
WITH patient_visit_counts AS (
    SELECT pat_mrn, COUNT(DISTINCT pat_enc_csn_id) AS visit_count
    FROM "glaucoma"."glaucoma_visits"
    GROUP BY pat_mrn
)

SELECT
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY visit_count) AS median
FROM patient_visit_counts;


-- Ratio of Male to Female Glaucoma Patients:
SELECT count(DISTINCT pat_mrn), pat_sex 
FROM glaucoma.glaucoma_demographics
LIMIT 1000;


SELECT
    pat_sex,
    COUNT(DISTINCT pat_mrn) AS patient_count,
    COUNT(DISTINCT pat_mrn) / SUM(COUNT(DISTINCT pat_mrn)) OVER () AS sex_ratio
FROM glaucoma.glaucoma_demographics
GROUP BY pat_sex;

--Average Age of Glaucoma Patients at Encounter:

SELECT AVG(calc_age_years)
FROM glaucoma.glaucoma_demographics
LIMIT 1000;

-- Total Number of Images by Type of Glaucoma Specific Devices (ONH Photos (Nidek, NonMyd, Photos), Cirrus OCTs, HVF):

SELECT devdescription_ONHP, count(DISTINCT exsrno) from 
(select *, CASE WHEN devdescription like '%Nidek%'
                    or devdescription like '%NonMyd%'
                    or devdescription like '%Photos%' THEN 'ONH Photos' else devdescription END AS devdescription_ONHP
FROM axispacs_snowflake.file_paths_and_meta) as temp
where ptid in (SELECT pat_mrn FROM glaucoma.glaucoma_patients)
and (devdescription like '%Nidek%'
or devdescription like '%NonMyd%'
or devdescription like '%Photos%'
or devdescription like '%Cirrus OCT%'
or devdescription like '%Visual Field%')
GROUP BY devdescription_ONHP
limit 1000;

-- - Number of Imaging Visits by type per year (all device types)
SELECT extract(YEAR from exdatetime), devdescription, count(DISTINCT exsrno) from axispacs_snowflake.file_paths_and_meta
where ptid in (SELECT pat_mrn FROM glaucoma.glaucoma_patients)
GROUP BY extract(YEAR from exdatetime), devdescription
limit 1000;

--  -Number of types of images (fundus photos (Non-Myd, Photos, Nidek), Cirrus OCTs, HVF)
SELECT extract(YEAR from exdatetime), devdescription_ONHP, count(DISTINCT exsrno) from 
(select *, CASE WHEN devdescription like '%Nidek%'
                    or devdescription like '%NonMyd%'
                    or devdescription like '%Photos%' THEN 'ONH Photos' else devdescription END AS devdescription_ONHP
FROM axispacs_snowflake.file_paths_and_meta) as temp
where ptid in (SELECT pat_mrn FROM glaucoma.glaucoma_patients)
and (devdescription like '%Nidek%'
or devdescription like '%NonMyd%'
or devdescription like '%Photos%'
or devdescription like '%Cirrus OCT%'
or devdescription like '%Visual Field%')
GROUP BY extract(YEAR from exdatetime), devdescription_ONHP
limit 1000;