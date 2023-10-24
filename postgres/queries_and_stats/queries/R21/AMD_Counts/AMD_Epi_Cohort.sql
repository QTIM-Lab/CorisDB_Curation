-- AMD Data from Epidemiology Cohort
-- - Breakdown of Epidemiology Cohort by 'Ferris Classification (Beckman)'
SELECT ferris, COUNT(*) AS Ferris_Classification
FROM amd.raw_mrns_from_csv	
GROUP BY ferris
ORDER BY Ferris_Classification DESC;


-- Average Number of Visits for each Epi Cohort Patient (AMD Visits):
SELECT AVG(visit_count)
FROM (
    SELECT distinct r.pat_mrn, COUNT(DISTINCT pat_enc_csn_id) AS visit_count
    FROM amd.raw_mrns_from_csv r
    INNER JOIN amd.amd_encounters e ON CAST(r.pat_mrn as VARCHAR) = e.pat_mrn
    where progress_note like '%AMD%'
    GROUP BY r.pat_mrn
) AS subquery
LIMIT 1000;
	
-- Average Number of Visits for each Epi Cohort Patient (Total Visits):

SELECT AVG(visit_count)
FROM (
    SELECT distinct r.pat_mrn, COUNT(DISTINCT pat_enc_csn_id) AS visit_count
    FROM amd.raw_mrns_from_csv r
    INNER JOIN amd.amd_encounters e ON CAST(r.pat_mrn as VARCHAR) = e.pat_mrn
    GROUP BY r.pat_mrn
) AS subquery
LIMIT 1000;

-- Median Number of Visits for each Epi Cohort Patient (AMD Visits):

WITH patient_visit_counts AS (
    SELECT distinct r.pat_mrn, COUNT(DISTINCT pat_enc_csn_id) AS visit_count
    FROM amd.raw_mrns_from_csv r
    INNER JOIN amd.amd_encounters e ON CAST(r.pat_mrn as VARCHAR) = e.pat_mrn
    where progress_note like '%AMD%'
    GROUP BY r.pat_mrn
)
SELECT
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY visit_count) AS median
FROM patient_visit_counts;

-- Median Number of Visits for each Epi Cohort Patient (Total Visits):

WITH patient_visit_counts AS (
    SELECT distinct r.pat_mrn, COUNT(DISTINCT pat_enc_csn_id) AS visit_count
    FROM amd.raw_mrns_from_csv r
    INNER JOIN amd.amd_encounters e ON CAST(r.pat_mrn as VARCHAR) = e.pat_mrn
    GROUP BY r.pat_mrn
)
SELECT
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY visit_count) AS median
FROM patient_visit_counts;

--Number of Autofluoresences for GA Epi Cohort Patients

select devtype_AF, count(distinct ptid) from (
	select 'AF' as devtype_AF,* from axispacs_snowflake.file_paths_and_meta f
	inner join amd.raw_mrns_from_csv amd
	on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
	-- Tags Spectralis OCT (Scans) with filenote as "(######) Single" from axispacs_snowflake.file_paths_and_meta as Auto Fluorescenses
	where ferris like '%GA AMD%' and devsrno = 9 and filenote like '%Single%' -- This is AF
	-- where ferris like '%GA AMD%' and devsrno = 9 and filenote not like '%Single%'-- Ths is non AF
) as AF
group by devtype_AF
limit 100;


--Number of Spectralis OCTs for GA Epi Cohort Patients

select devtype_AF, count(distinct ptid) from (
	select 'AF' as devtype_AF,* from axispacs_snowflake.file_paths_and_meta f
	inner join amd.raw_mrns_from_csv amd
	on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
	where ferris like '%GA AMD%' and devsrno = 9 and filenote not like '%Single%'-- Ths is non AF
) as AF
group by devtype_AF
limit 100;


-- Number of Fundus Photos (all types) for GA Epi Cohort Patients

select f.devname, count(distinct f.ptid) from axispacs_snowflake.file_paths_and_meta f
inner join amd.raw_mrns_from_csv amd
on f.ptid = CAST(amd.pat_mrn as VARCHAR)
where ferris like '%GA AMD%' and f.devname in ('NonMyd', 'Photos', 'Nidek', 'Optos', 'Topcon', 'Eidon')
group by f.devname
limit 10;


--Number of Autofluoresences for NV Epi Cohort Patients

select devtype_AF, count(distinct ptid) from (
	select 'AF' as devtype_AF,* from axispacs_snowflake.file_paths_and_meta f
	inner join amd.raw_mrns_from_csv amd
	on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
	-- Tags Spectralis OCT (Scans) with filenote as "(######) Single" from axispacs_snowflake.file_paths_and_meta as Auto Fluorescenses
	where ferris like '%GA AMD%' and devsrno = 9 and filenote like '%Single%' -- This is AF
	-- where ferris like '%GA AMD%' and devsrno = 9 and filenote not like '%Single%'-- Ths is non AF
) as AF
group by devtype_AF
limit 100;


--Number of Spectralis OCTs for NV Epi Cohort Patients

select devtype_AF, count(distinct ptid) from (
	select 'AF' as devtype_AF,* from axispacs_snowflake.file_paths_and_meta f
	inner join amd.raw_mrns_from_csv amd
	on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
	where ferris like '%NV AMD%' and devsrno = 9 and filenote not like '%Single%'-- Ths is non AF
) as AF
group by devtype_AF
limit 100;


-- Number of Fundus Photos (all types) for NV Epi Cohort Patients

select f.devname, count(distinct f.ptid) from axispacs_snowflake.file_paths_and_meta f
inner join amd.raw_mrns_from_csv amd
on f.ptid = CAST(amd.pat_mrn as VARCHAR)
where ferris like '%NV AMD%' and f.devname in ('NonMyd', 'Photos', 'Nidek', 'Optos', 'Topcon', 'Eidon')
group by f.devname
limit 10;


--Number of Autofluoresences for Advanced Epi Cohort Patients

select devtype_AF, count(distinct ptid) from (
	select 'AF' as devtype_AF,* from axispacs_snowflake.file_paths_and_meta f
	inner join amd.raw_mrns_from_csv amd
	on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
	-- Tags Spectralis OCT (Scans) with filenote as "(######) Single" from axispacs_snowflake.file_paths_and_meta as Auto Fluorescenses
	where ferris like '%Advanced Both%' and devsrno = 9 and filenote like '%Single%' -- This is AF
	-- where ferris like '%GA AMD%' and devsrno = 9 and filenote not like '%Single%'-- Ths is non AF
) as AF
group by devtype_AF
limit 100;


--Number of Spectralis OCTs for Advanced Epi Cohort Patients

select devtype_AF, count(distinct ptid) from (
	select 'AF' as devtype_AF,* from axispacs_snowflake.file_paths_and_meta f
	inner join amd.raw_mrns_from_csv amd
	on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
	where ferris like '%Advanced Both%' and devsrno = 9 and filenote not like '%Single%'-- Ths is non AF
) as AF
group by devtype_AF
limit 100;


-- Number of Fundus Photos (all types) for Advanced Epi Cohort Patients

select f.devname, count(distinct f.ptid) from axispacs_snowflake.file_paths_and_meta f
inner join amd.raw_mrns_from_csv amd
on f.ptid = CAST(amd.pat_mrn as VARCHAR)
where ferris like '%Advanced Both%' and f.devname in ('NonMyd', 'Photos', 'Nidek', 'Optos', 'Topcon', 'Eidon')
group by f.devname
limit 10;


--Number of Autofluoresences for iAMD Epi Cohort Patients

select devtype_AF, count(distinct ptid) from (
	select 'AF' as devtype_AF,* from axispacs_snowflake.file_paths_and_meta f
	inner join amd.raw_mrns_from_csv amd
	on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
	-- Tags Spectralis OCT (Scans) with filenote as "(######) Single" from axispacs_snowflake.file_paths_and_meta as Auto Fluorescenses
	where ferris like '%Int AMD%' and devsrno = 9 and filenote like '%Single%' -- This is AF
	-- where ferris like '%GA AMD%' and devsrno = 9 and filenote not like '%Single%'-- Ths is non AF
) as AF
group by devtype_AF
limit 100;


--Number of Spectralis OCTs for iAMD Epi Cohort Patients

select devtype_AF, count(distinct ptid) from (
	select 'AF' as devtype_AF,* from axispacs_snowflake.file_paths_and_meta f
	inner join amd.raw_mrns_from_csv amd
	on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
	where ferris like '%Int AMD%' and devsrno = 9 and filenote not like '%Single%'-- Ths is non AF
) as AF
group by devtype_AF
limit 100;


-- Number of Fundus Photos (all types) for iAMD Epi Cohort Patients

select f.devname, count(distinct f.ptid) from axispacs_snowflake.file_paths_and_meta f
inner join amd.raw_mrns_from_csv amd
on f.ptid = CAST(amd.pat_mrn as VARCHAR)
where ferris like '%Int AMD%' and f.devname in ('NonMyd', 'Photos', 'Nidek', 'Optos', 'Topcon', 'Eidon')
group by f.devname
limit 10;


--Number of Autofluoresences for eAMD Epi Cohort Patients

select devtype_AF, count(distinct ptid) from (
	select 'AF' as devtype_AF,* from axispacs_snowflake.file_paths_and_meta f
	inner join amd.raw_mrns_from_csv amd
	on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
	-- Tags Spectralis OCT (Scans) with filenote as "(######) Single" from axispacs_snowflake.file_paths_and_meta as Auto Fluorescenses
	where ferris like '%Early AMD%' and devsrno = 9 and filenote like '%Single%' -- This is AF
	-- where ferris like '%GA AMD%' and devsrno = 9 and filenote not like '%Single%'-- Ths is non AF
) as AF
group by devtype_AF
limit 100;


--Number of Spectralis OCTs for eAMD Epi Cohort Patients

select devtype_AF, count(distinct ptid) from (
	select 'AF' as devtype_AF,* from axispacs_snowflake.file_paths_and_meta f
	inner join amd.raw_mrns_from_csv amd
	on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
	where ferris like '%Early AMD%' and devsrno = 9 and filenote not like '%Single%'-- Ths is non AF
) as AF
group by devtype_AF
limit 100;


-- Number of Fundus Photos (all types) for eAMD Epi Cohort Patients

select f.devname, count(distinct f.ptid) from axispacs_snowflake.file_paths_and_meta f
inner join amd.raw_mrns_from_csv amd
on f.ptid = CAST(amd.pat_mrn as VARCHAR)
where ferris like '%Early AMD%' and f.devname in ('NonMyd', 'Photos', 'Nidek', 'Optos', 'Topcon', 'Eidon')
group by f.devname
limit 10;

--Number of Autofluoresences for Uncertain AMD Epi Cohort Patients

select devtype_AF, count(distinct ptid) from (
	select 'AF' as devtype_AF,* from axispacs_snowflake.file_paths_and_meta f
	inner join amd.raw_mrns_from_csv amd
	on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
	-- Tags Spectralis OCT (Scans) with filenote as "(######) Single" from axispacs_snowflake.file_paths_and_meta as Auto Fluorescenses
	where ferris like '%Uncertain AMD%' and devsrno = 9 and filenote like '%Single%' -- This is AF
	-- where ferris like '%GA AMD%' and devsrno = 9 and filenote not like '%Single%'-- Ths is non AF
) as AF
group by devtype_AF
limit 100;


--Number of Spectralis OCTs for Uncertain AMD Epi Cohort Patients

select devtype_AF, count(distinct ptid) from (
	select 'AF' as devtype_AF,* from axispacs_snowflake.file_paths_and_meta f
	inner join amd.raw_mrns_from_csv amd
	on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
	where ferris like '%Uncertain AMD%' and devsrno = 9 and filenote not like '%Single%'-- Ths is non AF
) as AF
group by devtype_AF
limit 100;


-- Number of Fundus Photos (all types) for Uncertain AMD Epi Cohort Patients

select f.devname, count(distinct f.ptid) from axispacs_snowflake.file_paths_and_meta f
inner join amd.raw_mrns_from_csv amd
on f.ptid = CAST(amd.pat_mrn as VARCHAR)
where ferris like '%Uncertain AMD%' and f.devname in ('NonMyd', 'Photos', 'Nidek', 'Optos', 'Topcon', 'Eidon')
group by f.devname
limit 10;

