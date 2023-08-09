/* Glaucoma Queries */
SELECT table_name, column_name, data_type FROM information_schema.columns --limit 100;
WHERE table_name like '%glaucoma%';

/* DANGER */
DROP TABLE IF EXISTS glaucoma.glaucoma_summary_stats; -- Backed Up
DROP VIEW IF EXISTS glaucoma.glaucoma_demographics; -- Backed Up
DROP VIEW IF EXISTS glaucoma.last_encounters; -- Backed Up
DROP TABLE IF EXISTS glaucoma.glaucoma_encounters; -- Backed Up
DROP TABLE IF EXISTS glaucoma.glaucoma_visits; -- Backed Up
DROP TABLE IF EXISTS glaucoma.glaucoma_patients; -- Backed Up
DROP TABLE IF EXISTS glaucoma.glaucoma_counts;
DROP TABLE IF EXISTS glaucoma.diagnosis_and_patient; -- Backed Up
DROP VIEW IF EXISTS glaucoma.glaucoma_diagnosis_dx_ids; -- Backed Up

DROP TABLE IF EXISTS glaucoma.glaucoma_encounter_visit_join; -- Backed Up
/* DANGER */

/* [1] Count of unique patients in CORIS */

-- select count (distinct pat_id) from public.ophthalmologypatients limit 2; -- 
-- select * from public.ophthalmologypatients limit 10;

/* [2] Count of unique patients in CORIS with a diagnosis for glaucoma disease */
-- so need to look up the ICD 9 and 10 codes

-- There is a table that matches the description of the code
-- and the code itself that would be a good place to start.
-- Additionally might want to look on the web for the appropriate codes
-- Then need to find the patients that have that code

-- select * from public.ophthalmologydiagnosesdm limit 10; -- has the code_type col with codes Jayashree is talking about.
-- select * from public.ophthalmologyencounterdiagnoses limit 10; -- helpful
-- select * from public.ophthalmologyencountervisit order by pat_id limit 10; -- helpful for visits but not diagnosis
-- select * from public.ophthalmologypatientdiagnoses limit 10; -- helpful

DROP VIEW IF EXISTS glaucoma.glaucoma_diagnosis_dx_ids;
CREATE VIEW glaucoma.glaucoma_diagnosis_dx_ids AS
    select distinct dx_id
    -- select distinct dx_id , dx_name, code, code_type
    from public.ophthalmologydiagnosesdm
    where dx_name like '%glaucoma%'
    -- where dx_name like '%glaucoma%' and (code like '%H40.11%' or code like '%365.11%')
    order by dx_id; -- 1,579
-- select count(*)
-- from public.ophthalmologyencounterdiagnoses -- 
-- where dx_id in (select dx_id from glaucoma.glaucoma_diagnosis_dx_ids);
-- select dm_codes.dx_id, dm_codes.dx_name, dm_codes.code, dm_codes.code_type
-- from public.ophthalmologydiagnosesdm as dm_codes
-- right join glaucoma.glaucoma_diagnosis_dx_ids as glaucoma_dx_ids
-- on dm_codes.dx_id = glaucoma_dx_ids.dx_id
-- order by dm_codes.dx_id

DROP TABLE IF EXISTS glaucoma.diagnosis_and_patient;
CREATE TABLE glaucoma.diagnosis_and_patient AS
    select
    distinct
    encounter_diagnoses.dx_id as dx_id,
    pat_id,
    pat_mrn
    --count(pat_id) as pat_id,
    -- count(distinct pat_id) as distinct_pat_id_counts
    from public.ophthalmologyencounterdiagnoses as encounter_diagnoses
    right join glaucoma.glaucoma_diagnosis_dx_ids as glaucoma_dx_ids
    on encounter_diagnoses.dx_id = glaucoma_dx_ids.dx_id
    where encounter_diagnoses.dx_id is not null
    order by pat_id -- 
;
select dx_id, count(pat_id) as distinct_pat_id_counts from glaucoma.diagnosis_and_patient
group by dx_id -- 
order by dx_id
;
select distinct pat_id, pat_mrn
    from public.ophthalmologyencounterdiagnoses as oed
    inner join glaucoma.glaucoma_diagnosis_dx_ids as pddi
    on oed.dx_id = pddi.dx_id
;

DROP TABLE IF EXISTS glaucoma.glaucoma_patients;
CREATE TABLE glaucoma.glaucoma_patients AS
    select distinct pat_id, pat_mrn
    from
    (select distinct pat_id, pat_mrn
    from public.ophthalmologyencounterdiagnoses as oed
    inner join glaucoma.glaucoma_diagnosis_dx_ids as pddi
    on oed.dx_id = pddi.dx_id -- 
    UNION ALL
    select distinct pat_id, pat_mrn
    from public.ophthalmologypatientdiagnoses as opd
    inner join glaucoma.glaucoma_diagnosis_dx_ids as pddi
    on opd.dx_id = pddi.dx_id -- 
    UNION ALL
    select distinct pat_id, pat_mrn
    from public.ophthalmologyencounterproblemlist as oepl
    inner join glaucoma.glaucoma_diagnosis_dx_ids as pddi
    on oepl.dx_id = pddi.dx_id -- 
    -- UNION ALL 
    -- select distinct pat_id, pat_mrn
    -- from public.ophthalmologyencountervisit
    -- where progress_note like '%glaucoma%' -- 
    -- UNION ALL
    -- select distinct pat_id, pat_mrn
    -- from public.ophthalmologylabs
    -- where component_name like '%glaucoma%'
    -- or    result_flag like '%glaucoma%'
    -- or    line_comment like '%glaucoma%'
    -- or    results_comp_cmt like '%glaucoma%'
    -- or    results_cmt like '%glaucoma%' -- 5
    order by pat_id
    ) as glaucoma_pat_ids; -- 

DROP TABLE IF EXISTS glaucoma.glaucoma_visits;
CREATE TABLE glaucoma.glaucoma_visits AS
    select
    pat_enc_csn_id, pat_id, pat_mrn, contact_date, progress_note
    from public.ophthalmologyencountervisit
    -- This filter is just glaucoma patients...but those patients could have non glaucoma encounters
    where pat_id in (select pat_id from glaucoma.glaucoma_patients) and (progress_note like '%glaucoma%' or progress_note like '%Glaucoma%'); -- 

DROP TABLE IF EXISTS glaucoma.glaucoma_encounters;
CREATE TABLE glaucoma.glaucoma_encounters AS
    select
    pat_enc_csn_id, pat_id, pat_mrn, pat_age_at_enc, contact_date, enc_close_time
    from public.ophthalmologyencounters
    -- This filter is just glaucoma patients...but those patients could have non glaucoma encounters
    where pat_id in (select pat_id from glaucoma.glaucoma_patients) and 
          pat_enc_csn_id in (select pat_enc_csn_id from glaucoma.glaucoma_visits); -- 

select count(*) from glaucoma.glaucoma_encounters; --
select count(distinct pat_enc_csn_id) from glaucoma.glaucoma_encounters; -- 

select count(*) from public.ophthalmologyencounters; -- 
select count(distinct pat_enc_csn_id) from public.ophthalmologyencounters; -- 
select * from public.ophthalmologyencounters order by pat_id, pat_age_at_enc limit 10; -- 

DROP VIEW IF EXISTS glaucoma.last_encounters;
CREATE VIEW glaucoma.last_encounters AS
    select 
    pat_id,
    pat_mrn,
    max(contact_date) as last_contact_date,
    max(pat_age_at_enc) as pat_age_at_enc
    from glaucoma.glaucoma_encounters
    group by pat_id, pat_mrn
    order by pat_id; -- 

DROP VIEW IF EXISTS glaucoma.glaucoma_demographics;
CREATE VIEW glaucoma.glaucoma_demographics AS
    select
    op.pat_id,
    op.pat_mrn,
    -- le.pat_age_at_enc,
    DATE_PART('year', -- grab year from AGE funtion that takes two dates
              AGE(
              case when op.last_contact_date is null 
                   then '2023-05-30' -- if there is no last_contact_date calc current age
                   else op.last_contact_date 
                   end::date, op.birth_date::date
              )
             ) AS calc_age_years,
    op.birth_date,
      -- le.last_contact_date, -- bad idea
    op.last_contact_date, -- bad idea
    op.ethnic,
    op.race,
    case
        -- Name change
        when op.race = 'White or Caucasian' then 'White'
        when op.race = 'Black or African American' then 'Black'
        when op.race = 'American Indian or Alaska Native' then 'American Indian or Alaska Native'
        when op.race = 'Asian Indian' 
          or op.race = 'Other Asian'
          or op.race = 'Vietnamese' 
          or op.race = 'Japanese' 
          or op.race = 'Chinese' 
          or op.race = 'Filipino' 
          or op.race = 'Korean' 
          then 'Asian'
        when op.race = 'Native Hawaiian and Other Pacific Islander'
          or op.race = 'Native Hawaiian' 
          or op.race = 'Other Pacific Islander' 
          then 'Native Hawaiian and Other Pacific Islander'
        when op.race = 'More Than One Race' then 'More Than One Race'
        -- Other bin
        when op.race is null then 'Other'
        when op.race = 'Patient Declined' then 'Other'
        when op.race = 'Unknown' then 'Other'
        when op.race = 'Other' then 'Other'
        else 'Missing Category' -- White, Black or African American
    end as race_binned,
    op.pat_sex
    -- ,*
    -- count(*)
    from public.ophthalmologypatients as op
    inner join glaucoma.glaucoma_patients as gp
    on op.pat_id = gp.pat_id
                    /* I think this is a bad idea
                        -- inner join glaucoma.last_encounters as le
                        -- on op.pat_id = le.pat_id
                    */
    -- where op.last_contact_date is null
    order by op.pat_id;

DROP TABLE IF EXISTS glaucoma.glaucoma_summary_stats;
CREATE TABLE glaucoma.glaucoma_summary_stats AS
    -- between is inclusive so <lower bound> <= x <= <upper bound> equates to true.
    select 'Total_Patients_In_Coris_DB' as age_and_other_bins, count(distinct pat_id) as patient_counts from public.ophthalmologypatients
    union (
        select 'glaucoma_Patients' as age_and_other_bins, count(*) from glaucoma.glaucoma_demographics)
    union (
    select 'Males' as age_and_other_bins, count(pat_sex) as patient_counts from glaucoma.glaucoma_demographics
        where pat_sex = 'Male')
    union (
    select 'Females' as age_and_other_bins, count(pat_sex) as patient_counts from glaucoma.glaucoma_demographics
        where pat_sex = 'Female')
    union (
    select '0-18' as age_and_other_bins, count(calc_age_years) as patient_counts from glaucoma.glaucoma_demographics
        where calc_age_years between 0 and 18)
    union (
    select '19-49' as age_and_other_bins, count(calc_age_years) as patient_counts from glaucoma.glaucoma_demographics
        where calc_age_years between 19 and 49)
    union (
    select '50-59' as age_and_other_bins,count(calc_age_years) as patient_counts from glaucoma.glaucoma_demographics
        where calc_age_years between 50 and 59)
    union (
    select '60-69' as age_and_other_bins,count(calc_age_years) as patient_counts from glaucoma.glaucoma_demographics
        where calc_age_years between 60 and 69)
    union (
    select '70-79' as age_and_other_bins,count(calc_age_years) as patient_counts from glaucoma.glaucoma_demographics
        where calc_age_years between 70 and 79)
    union (
    select '80-89' as age_and_other_bins,count(calc_age_years) as patient_counts from glaucoma.glaucoma_demographics
        where calc_age_years between 80 and 89)
    union (
    select '90+' as age_and_other_bins, count(calc_age_years) as patient_counts from glaucoma.glaucoma_demographics
                where calc_age_years >= 90)
    order by age_and_other_bins;

DROP TABLE IF EXISTS glaucoma.glaucoma_encounter_visit_join;
CREATE TABLE glaucoma.glaucoma_encounter_visit_join AS
    select
    --*,
    ge.pat_enc_csn_id as ge_pat_enc_csn_id,
    gv.pat_enc_csn_id as gv_pat_enc_csn_id,
    ge.pat_id as ge_pat_id,
    gv.pat_id as gv_pat_id,
    gv.pat_mrn as gv_pat_mrn,
    ge.contact_date as ge_contact_date,
    gv.contact_date as gv_contact_date,
    gv.progress_note as gv_progress_note
    from glaucoma.glaucoma_encounters as ge
    inner join glaucoma.glaucoma_visits as gv -- IT'S AN INNER JOIN (overlap)
    on ge.pat_enc_csn_id = gv.pat_enc_csn_id and ge.pat_id = gv.pat_id
    order by ge.pat_enc_csn_id, ge.pat_id, ge.contact_date;

\copy (SELECT * FROM glaucoma.glaucoma_patients) TO '/data/Glaucoma_FROM_PACS/output.csv' WITH (FORMAT CSV, HEADER)
\copy (SELECT * FROM glaucoma.glaucoma_patients) TO '/data/Glaucoma_FROM_PACS/glaucoma_patients_from_coris_db.csv' WITH (FORMAT CSV, HEADER)
\copy (SELECT pat_id, pat_mrn FROM public.ophthalmologypatients) TO '/data/Glaucoma_FROM_PACS/all_patients_from_coris_db.csv' WITH (FORMAT CSV, HEADER)
