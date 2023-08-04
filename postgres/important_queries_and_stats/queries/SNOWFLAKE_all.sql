-- Have to go to: 
-- https://cwufjhr-qb78737.snowflakecomputing.com

SELECT * 
FROM patients limit 50;

SELECT * 
FROM exams limit 5;

SELECT * 
FROM files
where filepathnew is not null
limit 5; -- Results_Snowflake_Queries/5_random_files.csv

SELECT CURRENT_DATABASE(), CURRENT_SCHEMA();

DROP TABLE IF EXISTS project.glaucoma_patients;
CREATE OR REPLACE TABLE project.glaucoma_patients (
  pat_id STRING,
  pat_mrn STRING
  );

DROP TABLE IF EXISTS project.all_patients_from_coris_db;
CREATE OR REPLACE TABLE project.all_patients_from_coris_db (
  pat_id STRING,
  pat_mrn STRING
  );


LIST @EYEPACS.project.%glaucoma_patients;
-- Not working in Snowflake UI | You can do manually (https://docs.snowflake.com/en/user-guide/data-load-web-ui)
PUT 'file:///home/bbearce/Downloads/glaucoma_patients_from_coris_db.csv' @EYEPACS.project.%glaucoma_patients;
COPY INTO file:///home/bbearce/Downloads/glaucoma_patients_from_coris_db.csv @EYEPACS.project.%glaucoma_patients;

COPY INTO glaucoma_patients
  FROM @%glaucoma_patients
  FILE_FORMAT = (type = csv field_optionally_enclosed_by='"')
  PATTERN = '.*glaucoma_patients_from_coris_db.csv.gz'
  ON_ERROR = 'skip_file';


-- See data
select * from project.glaucoma_patients limit 10;
select * from project.all_patients_from_coris_db limit 10;
select count(*) from project.glaucoma_patients;
delete  from project.glaucoma_patients;
select count(*) from project.all_patients_from_coris_db;


-- See what MRNs are in CORIS and not Snowflake and vice versa
-- Look at Glaucoma too
select count(*) from public.patients
where ptid is null 
where ptid is not null; 

-- Only in Snowflake
select sf_pat.ptid as SF_PAT_MRN_ONLY, coris.pat_mrn as CORIS_PAT_MRN
-- select count(sf_pat.ptid)
from public.patients sf_pat -- REFERENCE
left join project.all_patients_from_coris_db as coris
on sf_pat.ptid = coris.pat_mrn
where coris.pat_mrn is null and sf_pat.ptid is not null; 

-- Only in CORIS
select coris.pat_mrn as CORIS_PAT_MRN_ONLY, sf_pat.ptid as SF_PAT_MRN
-- select count (*)
from public.patients sf_pat
right join project.all_patients_from_coris_db as coris -- REFERENCE
on sf_pat.ptid = coris.pat_mrn
where sf_pat.ptid is null and coris.pat_mrn is not null; 

-- In common between CORIS and Snowflake
select count (distinct coris.pat_mrn)
from public.patients sf_pat
inner join project.all_patients_from_coris_db as coris
on sf_pat.ptid = coris.pat_mrn 
-- where coris.pat_mrn is not null and sf_pat.ptid is not null 
order by coris.pat_mrn;

-- Glaucoma in common with Snowflake
select count (distinct g.pat_mrn)
from public.patients sf_pat
inner join project.glaucoma_patients as g
on sf_pat.ptid = g.pat_mrn 
order by g.pat_mrn;


select count(distinct ptid) from public.patients; 
select count(distinct pat_mrn) from project.all_patients_from_coris_db; 

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
from public.patients sf_pat
right join project.glaucoma_patients as g -- RIGHT JOIN!!!
on sf_pat.ptid = g.pat_mrn
inner join public.exams as e
on sf_pat.ptsrno = e.ptsrno
inner join public.files as f
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
