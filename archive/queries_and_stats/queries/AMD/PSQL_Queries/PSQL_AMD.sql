-- AMD in common with Snowflake
-- SELECT count(distinct pat_mrn) FROM amd.amd_patients;
-- SELECT distinct pat_id, pat_mrn FROM amd.amd_patients;
-- SELECT pat_id, pat_mrn FROM amd.amd_patients;

select count (distinct a.pat_mrn)
from axispacs_snowflake.patients ap_pat
inner join (SELECT pat_id, pat_mrn FROM amd.amd_patients) as a
on ap_pat.ptid = a.pat_mrn
-- order by a.pat_mrn;


select * from axispacs_snowflake.exams where exdatetime > '2022-12-31 00:00:00' order by exdatetime desc limit 100;
select count(*) from axispacs_snowflake.file_paths_and_meta
where ptid in (SELECT pat_mrn FROM amd.amd_patients)
limit 10;


SELECT ap.ptid AS mrn
FROM axispacs_snowflake.file_paths_and_meta AS ap
INNER JOIN amd.amd_patients AS a ON ap.ptid = a.pat_mrn


select
ptid as mrn,
* from axispacs_snowflake.file_paths_and_meta
where ptid in (SELECT pat_mrn FROM amd.amd_patients)
  and ptid = '' --and exdatetime = '2014-06-19 00:00:00'
order by exdatetime
limit 100000;


select * from axispacs_snowflake.exams
where exdatetime = '2014-06-19 00:00:00' and ptsrno = 13874
order by exdatetime 
limit 100000;

select appt_serial_no, enc_closed_user_id, pcp_prov_id, visit_prov_id, department_id, appt_prc_id, appt_entry_user_id, checkin_user_id, account_id, coverage_id, visit_epm_id, visit_epp_id, serv_area_id,
* from ehr.ophthalmologyencounters
where pat_mrn = '' and pat_enc_csn_id = '' and
      (
        (EXTRACT(YEAR from entry_time) = '2014' and
        EXTRACT(MONTH from entry_time) = '06' and
        EXTRACT(DAY from entry_time) = '19') or
        (EXTRACT(YEAR from appt_made_date) = '2014' and--
        EXTRACT(MONTH from appt_made_date) = '06' and
        EXTRACT(DAY from appt_made_date) = '19') or
        (EXTRACT(YEAR from contact_date) = '2014' and----
        EXTRACT(MONTH from contact_date) = '06' and
        EXTRACT(DAY from contact_date) = '19') or
        (EXTRACT(YEAR from appt_time) = '2014' and----
        EXTRACT(MONTH from appt_time) = '06' and
        EXTRACT(DAY from appt_time) = '19') or
        (EXTRACT(YEAR from begin_checkin_dttm) = '2014' and
        EXTRACT(MONTH from begin_checkin_dttm) = '06' and
        EXTRACT(DAY from begin_checkin_dttm) = '19') or
        (EXTRACT(YEAR from checkin_time) = '2014' and----
        EXTRACT(MONTH from checkin_time) = '06' and
        EXTRACT(DAY from checkin_time) = '19') or
        (EXTRACT(YEAR from checkout_time) = '2014' and
        EXTRACT(MONTH from checkout_time) = '06' and
        EXTRACT(DAY from checkout_time) = '19') or
        (EXTRACT(YEAR from enc_close_time) = '2014' and
        EXTRACT(MONTH from enc_close_time) = '06' and
        EXTRACT(DAY from enc_close_time) = '19') or
        (EXTRACT(YEAR from update_date) = '2014' and--
        EXTRACT(MONTH from update_date) = '06' and
        EXTRACT(DAY from update_date) = '19') or
        (EXTRACT(YEAR from effective_date_dttm) = '2014' and--
        EXTRACT(MONTH from effective_date_dttm) = '06' and
        EXTRACT(DAY from effective_date_dttm) = '19')
      )
limit 100000;


select * from ehr.ophthalmologyencountervisit
where pat_mrn = '' and pat_enc_csn_id = '' and
      (EXTRACT(YEAR from contact_date) = '2014' and
       EXTRACT(MONTH from contact_date) = '06' and
       EXTRACT(DAY from contact_date) = '19')
limit 10;

select * from ehr.ophthalmologyencounterexam
where pat_mrn = '' and pat_enc_csn_id = ''
  and (EXTRACT(YEAR from cur_value_datetime) = '2014' and
       EXTRACT(MONTH from cur_value_datetime) = '06' and
       EXTRACT(DAY from cur_value_datetime) = '19' and
       EXTRACT(YEAR from contact_date) = '2014' and
       EXTRACT(MONTH from contact_date) = '06' and
       EXTRACT(DAY from contact_date) = '19')
limit 100;

select * from ehr.ophthalmologyradiology order by begin_exam_dttm limit 100000
where pat_mrn = '' and
      (
        (EXTRACT(YEAR from begin_exam_dttm) = '2014' and
        EXTRACT(MONTH from begin_exam_dttm) = '06' and
        EXTRACT(DAY from begin_exam_dttm) = '19') or
        (EXTRACT(YEAR from end_exam_dttm) = '2014' and
        EXTRACT(MONTH from end_exam_dttm) = '06' and
        EXTRACT(DAY from end_exam_dttm) = '19') or
        (EXTRACT(YEAR from finalizing_dttm) = '2014' and
        EXTRACT(MONTH from finalizing_dttm) = '06' and
        EXTRACT(DAY from finalizing_dttm) = '19')
      )
limit 100;


/* Workflow */


/* OLD - 09/18/2023 */
-- Get patient or patients
SELECT pat_mrn
FROM amd.amd_patients
limit 5; -- ('')
-- ###### has no data in axispacs...

/* Progress Note */
-- we need encounters as that is the highlest level thing besides patient mrn itself
-- We want to extract the contact_date for other queries
-- We need this query for the progress notes but will make a temp table to access the rest of the data
select * from ehr.ophthalmologyencountervisit
-- where pat_mrn in ('') order by pat_mrn, contact_date, pat_enc_csn_id;
where pat_mrn in (SELECT pat_mrn FROM amd.amd_patients) order by pat_mrn, contact_date, pat_enc_csn_id;
select * from ehr.ophthalmologyencountervisit order by contact_date desc limit 100;


CREATE TEMP TABLE IF NOT EXISTS encounters_mrns_contact_dates as
-- select * from ehr.ophthalmologyencountervisit where pat_mrn in ('') order by pat_mrn, contact_date, pat_enc_csn_id;
select * from ehr.ophthalmologyencountervisit where pat_mrn in (SELECT pat_mrn FROM amd.amd_patients) order by pat_mrn, contact_date, pat_enc_csn_id;
-- select * from encounters_mrns_contact_dates;
-- select contact_date from encounters_mrns_contact_dates;
select * from axispacs_snowflake.file_paths_and_meta
-- where ptid in ('')
where ptid in (SELECT pat_mrn FROM amd.amd_patients)



CREATE TEMP TABLE IF NOT EXISTS encounters_mrns_contact_dates as
-- select * from ehr.ophthalmologyencountervisit where pat_mrn in ('') order by pat_mrn, contact_date, pat_enc_csn_id;
select * from ehr.ophthalmologyencountervisit where pat_mrn in (SELECT pat_mrn FROM amd.amd_patients) order by pat_mrn, contact_date, pat_enc_csn_id;
-- select * from encounters_mrns_contact_dates;
-- select contact_date from encounters_mrns_contact_dates;
select * from axispacs_snowflake.file_paths_and_meta
where ptid in (SELECT pat_mrn FROM amd.amd_patients) and
      EXTRACT(YEAR from exdatetime) in (select EXTRACT(YEAR from contact_date) from encounters_mrns_contact_dates) and
      EXTRACT(MONTH from exdatetime) in (select EXTRACT(MONTH from contact_date) from encounters_mrns_contact_dates) and
      EXTRACT(DAY from exdatetime) in (select EXTRACT(DAY from contact_date) from encounters_mrns_contact_dates)






CREATE TEMP TABLE IF NOT EXISTS encounters_mrns_contact_dates as
-- select * from ehr.ophthalmologyencountervisit where pat_mrn in ('') order by pat_mrn, contact_date, pat_enc_csn_id;
select 
EXTRACT(YEAR from contact_date) as year,
EXTRACT(MONTH from contact_date) as month,
EXTRACT(DAY from contact_date) as day,
* 
from ehr.ophthalmologyencountervisit where pat_mrn in (SELECT pat_mrn FROM amd.amd_patients) order by pat_mrn, contact_date, pat_enc_csn_id;
-- select * from encounters_mrns_contact_dates;
-- select contact_date from encounters_mrns_contact_dates;
select * from axispacs_snowflake.file_paths_and_meta as ap --limit 10
inner join encounters_mrns_contact_dates as e
on ap.ptid = e.pat_mrn and e.year = ap.year and e.month = ap.month and e.day = ap.day


CREATE TEMP TABLE IF NOT EXISTS encounters_mrns_contact_dates as
-- select * from ehr.ophthalmologyencountervisit where pat_mrn in ('') order by pat_mrn, contact_date, pat_enc_csn_id;
select * from ehr.ophthalmologyencountervisit where pat_mrn in (SELECT pat_mrn FROM amd.amd_patients) order by pat_mrn, contact_date, pat_enc_csn_id;
-- select * from encounters_mrns_contact_dates;
-- select contact_date from encounters_mrns_contact_dates;
select * from axispacs_snowflake.file_paths_and_meta as ap --limit 10
inner join encounters_mrns_contact_dates as e
on ap.ptid = e.pat_mrn
and EXTRACT(YEAR from e.contact_date) = EXTRACT(YEAR from ap.exdatetime) and 
      EXTRACT(MONTH from e.contact_date) = EXTRACT(MONTH from ap.exdatetime) and
      EXTRACT(DAY from e.contact_date) = EXTRACT(DAY from ap.exdatetime)


-- where ptid in ('') and
--       EXTRACT(YEAR from exdatetime) in (select EXTRACT(YEAR from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
--       EXTRACT(MONTH from exdatetime) in (select EXTRACT(MONTH from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
--       EXTRACT(DAY from exdatetime) in (select EXTRACT(DAY from contact_date) from encounters_mrns_contact_dates where pat_mrn = '')
-- union all
-- select * from axispacs_snowflake.file_paths_and_meta
-- where ptid in ('') and
--       EXTRACT(YEAR from exdatetime) in (select EXTRACT(YEAR from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
--       EXTRACT(MONTH from exdatetime) in (select EXTRACT(MONTH from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
--       EXTRACT(DAY from exdatetime) in (select EXTRACT(DAY from contact_date) from encounters_mrns_contact_dates where pat_mrn = '')
-- union all
-- select * from axispacs_snowflake.file_paths_and_meta
-- where ptid in ('') and
--       EXTRACT(YEAR from exdatetime) in (select EXTRACT(YEAR from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
--       EXTRACT(MONTH from exdatetime) in (select EXTRACT(MONTH from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
--       EXTRACT(DAY from exdatetime) in (select EXTRACT(DAY from contact_date) from encounters_mrns_contact_dates where pat_mrn = '')
-- union all
-- select * from axispacs_snowflake.file_paths_and_meta
-- where ptid in ('') and
--       EXTRACT(YEAR from exdatetime) in (select EXTRACT(YEAR from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
--       EXTRACT(MONTH from exdatetime) in (select EXTRACT(MONTH from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
--       EXTRACT(DAY from exdatetime) in (select EXTRACT(DAY from contact_date) from encounters_mrns_contact_dates where pat_mrn = '')
-- union all
-- select * from axispacs_snowflake.file_paths_and_meta
-- where ptid in ('') and
--       EXTRACT(YEAR from exdatetime) in (select EXTRACT(YEAR from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
--       EXTRACT(MONTH from exdatetime) in (select EXTRACT(MONTH from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
--       EXTRACT(DAY from exdatetime) in (select EXTRACT(DAY from contact_date) from encounters_mrns_contact_dates where pat_mrn = '')


/* New 09/18/2023 */
select * from amd.amd_encounters limit 10;
--psql -U ophuser coris_db
--\copy amd.amd_encounters TO '/projects/coris_db/postgres/queries_and_stats/queries/AMD/Indexed_Images/09_18_2023_all_amd/encounters.csv' DELIMITER ',' CSV HEADER;
select * from axispacs_snowflake.file_paths_and_meta limit 10;

DROP TABLE IF EXISTS amd.amd_files;
CREATE TABLE IF NOT EXISTS amd.amd_files as
select
distinct
file_path_coris,
pat_enc_csn_id,
pat_age_at_enc,
exdatetime,
exsrno,
ptid as pat_mrn,
devname,
devdescription,
devtype,
devproc,
devsrno,
filenote,
filedata
from amd.amd_encounters as e --limit 10;
inner join axispacs_snowflake.file_paths_and_meta as f
on e.pat_mrn = f.ptid
    and e.year = f.year
    and e.month = f.month
    and e.day = f.day

--psql -U ophuser coris_db
--\copy amd.files TO '/projects/coris_db/postgres/queries_and_stats/queries/AMD/Indexed_Images/09_18_2023_all_amd/files.csv' DELIMITER ',' CSV HEADER;


select * from amd.files limit 100;
-- select * from amd.files where pat_mrn = '' limit 100; -- sanity check from source
-- select * from amd.raw_mrns_from_csv where pat_mrn = ''; -- sanity check from source



/* New 09/18/2023 */

