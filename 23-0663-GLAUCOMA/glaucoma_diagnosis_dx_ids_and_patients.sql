
/* Glaucoma Diagnosis ICD Codes */


drop table if exists glaucoma.bb_gbq_t3_glaucoma_diagnosis_20240925;
create table glaucoma.bb_gbq_t3_glaucoma_diagnosis_20240925 as 
    select 
    diagnosis_pk,
    diagnosiscodetype, 
    diagnosiscode, 
    diagnosisdescription, 
    provenance
    from coris_registry.BB_gbq_t3_diagnosis_20240925
    where diagnosiscode like '%H40%' OR diagnosiscode like '%365%';


select * from glaucoma.bb_gbq_t3_glaucoma_diagnosis_20240925;
-- limit 101;


-- select distinct (provenance) FROM coris_registry.c3304_gbq_t3_diagnosis_20240925
-- -- 'Billing Diagnosis'
-- -- 'Encounter Diagnosis'
-- -- 'Problem list'