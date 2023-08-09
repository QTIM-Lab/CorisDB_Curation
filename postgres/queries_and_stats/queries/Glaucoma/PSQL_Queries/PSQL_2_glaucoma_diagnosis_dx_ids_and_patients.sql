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

-- Codes: https://www.icd10data.com/

/* Quick Exploration for Steve*/
select distinct dx_id , dx_name, code, code_type
from public.ophthalmologydiagnosesdm
where code like '%H40%'
/* Quick Exploration for Steve*/

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
