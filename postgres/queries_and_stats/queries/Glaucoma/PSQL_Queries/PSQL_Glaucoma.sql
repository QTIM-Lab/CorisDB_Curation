-- Have to go to: 
-- https://cwufjhr-qb78737.snowflakecomputing.com

SELECT * FROM axispacs_snowflake.patients
where ptid = '';

SELECT * FROM devices where devtype in ('OPTOS','Optos') limit 100;
SELECT distinct devtype FROM devices limit 100;

SELECT CURRENT_DATABASE(), CURRENT_SCHEMA();

DROP TABLE IF EXISTS axispacs_snowflake.glaucoma_patients;
CREATE OR REPLACE TABLE axispacs_snowflake.glaucoma_patients (
  pat_id STRING,
  pat_mrn STRING
  );

/* Might be useless if all in postgres */
DROP TABLE IF EXISTS axispacs_snowflake.all_patients_from_coris_db;
CREATE OR REPLACE TABLE axispacs_snowflake.all_patients_from_coris_db (
  pat_id STRING,
  pat_mrn STRING
  );
/**/




/* All Ophthalmology Patients (pat_id, pat_mrn) */
SELECT pat_id, pat_mrn FROM public.ophthalmologypatients;


-- -- See data
-- select * from project.glaucoma_patients limit 10;
-- select * from project.all_patients_from_coris_db limit 10;
-- select count(*) from project.glaucoma_patients;
-- delete  from project.glaucoma_patients;
-- select count(*) from project.all_patients_from_coris_db;


-- See what MRNs are in CORIS and not Snowflake and vice versa
-- Look at Glaucoma too
select count(*) from axispacs_snowflake.patients
where ptid is null -- 
where ptid is not null; -- 

-- Only in Snowflake
select sf_pat.ptid as SF_PAT_MRN_ONLY, coris.pat_mrn as CORIS_PAT_MRN
-- select count(sf_pat.ptid)
from axispacs_snowflake.patients sf_pat -- REFERENCE
left join (SELECT pat_id, pat_mrn FROM public.ophthalmologypatients) as coris
on sf_pat.ptid = coris.pat_mrn
where coris.pat_mrn is null and sf_pat.ptid is not null; -- 

-- Only in CORIS
select coris.pat_mrn as CORIS_PAT_MRN_ONLY, sf_pat.ptid as SF_PAT_MRN
-- select count (*)
from axispacs_snowflake.patients sf_pat
right join (SELECT pat_id, pat_mrn FROM public.ophthalmologypatients) as coris -- REFERENCE
on sf_pat.ptid = coris.pat_mrn
where sf_pat.ptid is null and coris.pat_mrn is not null; -- 

-- In common between CORIS and Snowflake
-- select coris.pat_mrn
select count (distinct coris.pat_mrn)
from axispacs_snowflake.patients sf_pat
inner join (SELECT pat_id, pat_mrn FROM public.ophthalmologypatients) as coris
on sf_pat.ptid = coris.pat_mrn
order by coris.pat_mrn;

-- Glaucoma in common with Snowflake
-- select distinct g.pat_mrn
select count (distinct g.pat_mrn)
from axispacs_snowflake.patients sf_pat
inner join (SELECT pat_id, pat_mrn FROM glaucoma.glaucoma_patients) as g
on sf_pat.ptid = g.pat_mrn
-- order by g.pat_mrn;


select count(distinct ptid) from axispacs_snowflake.patients; -- 
select count(distinct pat_mrn) from (SELECT pat_id, pat_mrn FROM public.ophthalmologypatients); -- 

-- Find Glaucoma patients
select
sf_pat.ptid as sf_pat_ptid, g.pat_mrn as g_pat_mrn, -- join
sf_pat.ptsrno as sf_pat_ptsrno, e.ptsrno as e_ptsrno, -- join
e.exsrno as e_exsrno, f.exsrno as f_exsrno, -- join
f.filepath as f_filepath,
f.filename as f_filename,
f.filepathnew as f_filepathnew,
f.filenamenew as f_filenamenew,
e.exdatetime as e_exdatetime,
e.tmstamp as e_tmstamp,
f.tmstamp as f_tmstamp
--select count(*)
from axispacs_snowflake.patients sf_pat
right join project.glaucoma_patients as g -- RIGHT JOIN!!!
on sf_pat.ptid = g.pat_mrn
inner join axispacs_snowflake.exams as e
on sf_pat.ptsrno = e.ptsrno
inner join axispacs_snowflake.files as f
on e.exsrno = f.exsrno
where g.pat_mrn is not null
and f_filenamenew not like '%.dcm' and f_filenamenew not like '%.dcm'
--and f_filenamenew like '%.dcm' and f_filenamenew like '%.dcm'
order by f_filenamenew desc
limit 5;

SELECT * 
FROM patients limit 50;

SELECT * 
FROM exams limit 5;

SELECT * 
FROM files
where filepathnew is not null
limit 5; -- Results_Snowflake_Queries/5_random_files.csv
