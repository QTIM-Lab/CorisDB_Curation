-- -- Only in Snowflake
-- select ap_pat.ptid as ap_PAT_MRN_ONLY, coris.pat_mrn as CORIS_PAT_MRN
-- -- select count(ap_pat.ptid)
-- from axispacs_snowflake.patients ap_pat -- REFERENCE
-- left join (SELECT pat_id, pat_mrn FROM public.ophthalmologypatients) as coris
-- on ap_pat.ptid = coris.pat_mrn
-- where coris.pat_mrn is null and ap_pat.ptid is not null; -- 

-- -- Only in CORIS
-- select coris.pat_mrn as CORIS_PAT_MRN_ONLY, ap_pat.ptid as ap_PAT_MRN
-- -- select count (*)
-- from axispacs_snowflake.patients ap_pat
-- right join (SELECT pat_id, pat_mrn FROM public.ophthalmologypatients) as coris -- REFERENCE
-- on ap_pat.ptid = coris.pat_mrn
-- where ap_pat.ptid is null and coris.pat_mrn is not null; -- 

-- In common between CORIS and Snowflake
-- select coris.pat_mrn
-- select count (distinct coris.pat_mrn)
-- from axispacs_snowflake.patients ap_pat
-- inner join (SELECT pat_id, pat_mrn FROM public.ophthalmologypatients) as coris
-- on ap_pat.ptid = coris.pat_mrn
-- order by coris.pat_mrn;

-- Glaucoma in common with Snowflake
SELECT count(distinct pat_mrn) FROM glaucoma.glaucoma_patients;
SELECT distinct pat_id, pat_mrn FROM glaucoma.glaucoma_patients;

select count (distinct g.pat_mrn)
from axispacs_snowflake.patients ap_pat
inner join (SELECT pat_id, pat_mrn FROM glaucoma.glaucoma_patients) as g
on ap_pat.ptid = g.pat_mrn
-- order by g.pat_mrn;


select * from axispacs_snowflake.exams where exdatetime > '2022-12-31 00:00:00' order by exdatetime desc limit 100;
select count(*) from axispacs_snowflake.file_paths_and_meta
where ptid in (SELECT pat_mrn FROM glaucoma.glaucoma_patients)
limit 10;

select
ptid as mrn,
* from axispacs_snowflake.file_paths_and_meta
where ptid in (SELECT pat_mrn FROM glaucoma.glaucoma_patients)
  and ptid = '' and exdatetime = '2014-06-19 00:00:00'
order by exdatetime
limit 100000;

select * from axispacs_snowflake.exams
where exdatetime = '2014-06-19 00:00:00' and ptsrno = 13874
order by exdatetime 
limit 100000;

select appt_serial_no, enc_closed_user_id, pcp_prov_id, visit_prov_id, department_id, appt_prc_id, appt_entry_user_id, checkin_user_id, account_id, coverage_id, visit_epm_id, visit_epp_id, serv_area_id,
* from public.ophthalmologyencounters
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


select * from public.ophthalmologyencountervisit
where pat_mrn = '' and pat_enc_csn_id = '' and
      (EXTRACT(YEAR from contact_date) = '2014' and
       EXTRACT(MONTH from contact_date) = '06' and
       EXTRACT(DAY from contact_date) = '19')
limit 10;

select * from public.ophthalmologyencounterexam
where pat_mrn = '' and pat_enc_csn_id = ''
  and (EXTRACT(YEAR from cur_value_datetime) = '2014' and
       EXTRACT(MONTH from cur_value_datetime) = '06' and
       EXTRACT(DAY from cur_value_datetime) = '19' and
       EXTRACT(YEAR from contact_date) = '2014' and
       EXTRACT(MONTH from contact_date) = '06' and
       EXTRACT(DAY from contact_date) = '19')
limit 100;

select * from public.ophthalmologyradiology order by begin_exam_dttm limit 100000
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
-- Get patient or patients
SELECT pat_mrn
FROM glaucoma.glaucoma_patients
limit 5; -- ('')
-- 5356094 has no data in axispacs...

-- we need encounters as that is the highlest level thing besides patient mrn itself
-- We want to extract the contact_date for other queries
-- We need this query for the progress notes but will make a temp table to access the rest of the data
select * from public.ophthalmologyencountervisit
where pat_mrn in ('') order by pat_mrn, contact_date, pat_enc_csn_id;
select * from public.ophthalmologyencountervisit order by contact_date desc limit 100;



CREATE TEMP TABLE IF NOT EXISTS encounters_mrns_contact_dates as
select * from public.ophthalmologyencountervisit where pat_mrn in ('') order by pat_mrn, contact_date, pat_enc_csn_id;
-- select * from encounters_mrns_contact_dates;
-- select contact_date from encounters_mrns_contact_dates;
select * from axispacs_snowflake.file_paths_and_meta
where ptid in ('')






CREATE TEMP TABLE IF NOT EXISTS encounters_mrns_contact_dates as
select * from public.ophthalmologyencountervisit where pat_mrn in ('') order by pat_mrn, contact_date, pat_enc_csn_id;
-- select * from encounters_mrns_contact_dates;
-- select contact_date from encounters_mrns_contact_dates;
select * from axispacs_snowflake.file_paths_and_meta
where ptid in ('') and
      EXTRACT(YEAR from exdatetime) in (select EXTRACT(YEAR from contact_date) from encounters_mrns_contact_dates) and
      EXTRACT(MONTH from exdatetime) in (select EXTRACT(MONTH from contact_date) from encounters_mrns_contact_dates) and
      EXTRACT(DAY from exdatetime) in (select EXTRACT(DAY from contact_date) from encounters_mrns_contact_dates)






CREATE TEMP TABLE IF NOT EXISTS encounters_mrns_contact_dates as
select * from public.ophthalmologyencountervisit where pat_mrn in ('') order by pat_mrn, contact_date, pat_enc_csn_id;
-- select * from encounters_mrns_contact_dates;
-- select contact_date from encounters_mrns_contact_dates;
select * from axispacs_snowflake.file_paths_and_meta
where ptid in ('') and
      EXTRACT(YEAR from exdatetime) in (select EXTRACT(YEAR from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
      EXTRACT(MONTH from exdatetime) in (select EXTRACT(MONTH from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
      EXTRACT(DAY from exdatetime) in (select EXTRACT(DAY from contact_date) from encounters_mrns_contact_dates where pat_mrn = '')
union all
select * from axispacs_snowflake.file_paths_and_meta
where ptid in ('') and
      EXTRACT(YEAR from exdatetime) in (select EXTRACT(YEAR from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
      EXTRACT(MONTH from exdatetime) in (select EXTRACT(MONTH from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
      EXTRACT(DAY from exdatetime) in (select EXTRACT(DAY from contact_date) from encounters_mrns_contact_dates where pat_mrn = '')
union all
select * from axispacs_snowflake.file_paths_and_meta
where ptid in ('') and
      EXTRACT(YEAR from exdatetime) in (select EXTRACT(YEAR from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
      EXTRACT(MONTH from exdatetime) in (select EXTRACT(MONTH from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
      EXTRACT(DAY from exdatetime) in (select EXTRACT(DAY from contact_date) from encounters_mrns_contact_dates where pat_mrn = '')
union all
select * from axispacs_snowflake.file_paths_and_meta
where ptid in ('') and
      EXTRACT(YEAR from exdatetime) in (select EXTRACT(YEAR from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
      EXTRACT(MONTH from exdatetime) in (select EXTRACT(MONTH from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
      EXTRACT(DAY from exdatetime) in (select EXTRACT(DAY from contact_date) from encounters_mrns_contact_dates where pat_mrn = '')
union all
select * from axispacs_snowflake.file_paths_and_meta
where ptid in ('') and
      EXTRACT(YEAR from exdatetime) in (select EXTRACT(YEAR from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
      EXTRACT(MONTH from exdatetime) in (select EXTRACT(MONTH from contact_date) from encounters_mrns_contact_dates where pat_mrn = '') and
      EXTRACT(DAY from exdatetime) in (select EXTRACT(DAY from contact_date) from encounters_mrns_contact_dates where pat_mrn = '')
