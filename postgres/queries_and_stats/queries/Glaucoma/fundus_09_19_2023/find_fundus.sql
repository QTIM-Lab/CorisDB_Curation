/* Ground Truth */
-- pat_mrn=;



/* Manual 09/26/2023 */
-- counts
select devname, count(*) 
from axispacs_snowflake.file_paths_and_meta
where ptid in (select pat_mrn from glaucoma.glaucoma_patients)
group by devname
order by count(*) desc
limit 500


-- Photos -- leaving out...pending final decision
-- select * 
-- from axispacs_snowflake.file_paths_and_meta
-- where devname = 'Photos' and fileeye = 'U'
-- order by ptid
-- limit 500


-- Nidek
select distinct fileeye
from axispacs_snowflake.file_paths_and_meta
where devname = 'NonMyd' and fileeye = 'OU'
order by ptid
limit 500

-- NonMyd
select * 
from axispacs_snowflake.file_paths_and_meta
where devname = 'NonMyd' and fileeye = 'OU'
-- and ptid in (select pat_mrn from glaucoma.glaucoma_patients)
order by ptid
limit 500

--
select
    -- count(*)
    f.file_path_coris,
    -- fe.pat_enc_csn_id,
    f.fileeye,
    f.ptid as pat_mrn,
    f.devname,
    '/data/FUNDUS_Scott_09_21_2023' || '/' || f.ptid || '/' || fe.pat_enc_csn_id || '/' || f.devname || '/' || regexp_replace(f.file_path_coris, '^.+[/\\]', '') as path_for_scott,
    regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)') AS CDR,
    (regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)'))[1]::float AS CDR_right,
    (regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)'))[2]::float AS CDR_left
    --fe.progress_note
    --,*
from axispacs_snowflake.file_paths_and_meta as f inner join glaucoma.fundus_encounters as fe
    on f.ptid = fe.pat_mrn
--     and fe.Year = f.Year
--     and fe.Month = f.Month
--     and fe.Day = f.Day
where f.devname in ('NonMyd') and f.ptid = '' --and f.fileeye ='OD'
limit 100
--
select * from glaucoma.fundus_encounters
where pat_mrn = ''
limit 10





/* Manual 09/19/2023 */
select * from ehr.ophthalmologypatients
where pat_mrn = ''
limit 10;

select * from ehr.ophthalmologyencounters
where pat_mrn = ''
limit 10;

select * from ehr.ophthalmologyencounterexam
where pat_mrn = ''
limit 10;

select * from ehr.ophthalmologyencounterproblemlist
where pat_mrn = ''
limit 10;


select * from ehr.ophthalmologyencountervisit
WHERE progress_note ~ 'C/D Ratio [0-9]+(\.[0-9]+)? [0-9]+(\.[0-9]+)?' limit 10;
-- WHERE progress_note ~ 'C/D Ratio [0-9]+(\.[0-9]+)? [0-9]+(\.[0-9]+)?' and pat_mrn = '' limit 10;
WHERE pat_mrn = '' limit 10; 
-- pat_enc_csn_id's=(,)


select * 
from axispacs_snowflake.file_paths_and_meta --limit 1
where year in (2019,2020,2021,2022) and 
      month in (11,12,3,6,1,5,9) and 
	  day in (10,20,5,17,7,9,8,4) and 
	  ptid = '' --and devname in ('NonMyd','Photos','Nidek')
-- and file_path_coris like '%.dcm'
limit 10



/* Automated 09/19/2023 */
drop table if exists glaucoma.fundus_encounters;
create table if not exists glaucoma.fundus_encounters as
select *,
EXTRACT(YEAR from contact_date) as year,
EXTRACT(MONTH from contact_date) as month,
EXTRACT(DAY from contact_date) as day
from ehr.ophthalmologyencountervisit
WHERE progress_note ~ 'C/D Ratio [0-9]+(\.[0-9]+)? [0-9]+(\.[0-9]+)?'
      and pat_mrn in (select pat_mrn from glaucoma.glaucoma_patients)

-- select pat_mrn from glaucoma.glaucoma_patients where pat_mrn = ''
-- select pat_mrn from glaucoma.glaucoma_patients where pat_mrn = ''

select * from glaucoma.fundus_encounters limit 10;


select * from axispacs_snowflake.file_paths_and_meta --limit 1

where ptid in (select pat_mrn from glaucoma.fundus_encounters) and devname in ('NonMyd','Photos','Nidek')
-- and file_path_coris like '%.dcm'
limit 10


select * from glaucoma.fundus_encounters
where pat_mrn = '' and year in (2015,2017) and month in (5,6) and day in (9,16)
limit 1000;


select distinct filetype from axispacs_snowflake.file_paths_and_meta

limit 100;



DROP MATERIALIZED VIEW IF EXISTS glaucoma.fundus_09_21_2023
CREATE MATERIALIZED VIEW glaucoma.fundus_09_21_2023 AS

-- Just run the indented to craft and tweak then run CREATE MATERIALIZED VIEW to make this
    select
    -- count(*)
    f.year, f.month, f.day,
    fe.year, fe.month, fe.day,
    f.file_path_coris,
    -- fe.pat_enc_csn_id,
    f.fileeye,
    f.ptid as pat_mrn,
    f.devname,
    '/data/FUNDUS_Scott_09_21_2023' || '/' || f.ptid || '/' || fe.pat_enc_csn_id || '/' || f.devname || '/' || regexp_replace(f.file_path_coris, '^.+[/\\]', '') as path_for_scott,
    regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)') AS CDR,
    (regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)'))[1]::float AS CDR_right,
    (regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)'))[2]::float AS CDR_left
    --fe.progress_note
    --,*
    from axispacs_snowflake.file_paths_and_meta as f inner join glaucoma.fundus_encounters as fe
    on f.ptid = fe.pat_mrn and f.year = fe.year and f.month = fe.month and f.day = fe.day

--     inner join ehr.ophthalmologyorders as o
--     on o.pat_enc_csn_id = fe.pat_enc_csn_id
    where f.devname in ('NonMyd','Photos','Nidek') /*and (o.proc_name like '%fundus%' or o.proc_name like '%FUNDUS%') */and f.ptid = ''
--     where (o.proc_name like '%fundus%' or o.proc_name like '%FUNDUS%')
--     and f.year = '2019' and f.month = '09' and f.day = '18'
    limit 100;
    --and f.ptid = ''
    --limit 1000

REFRESH MATERIALIZED VIEW glaucoma.fundus_09_21_2023

(select * from glaucoma.fundus_09_21_2023
where devname in ('NonMyd') and fileeye = 'OS'
limit 2)
UNION ALL
(select * from glaucoma.fundus_09_21_2023
where devname in ('Photos') and fileeye = 'OS'
limit 2)
UNION ALL
(select * from glaucoma.fundus_09_21_2023
where devname in ('Nidek') and fileeye = 'OS'
limit 2)
UNION ALL

(select * from glaucoma.fundus_09_21_2023
where devname in ('NonMyd') and fileeye = 'OD'
limit 2)
UNION ALL
(select * from glaucoma.fundus_09_21_2023
where devname in ('Photos') and fileeye = 'OD'
limit 2)
UNION ALL
(select * from glaucoma.fundus_09_21_2023
where devname in ('Nidek') and fileeye = 'OD'
limit 2)

