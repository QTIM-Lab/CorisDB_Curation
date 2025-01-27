
/* Glaucoma Diagnosis ICD Codes from coris_registry.bb_gbq_t3_diagnosis_<date> */

-- | diagnosis_pk | diagnosiscodetype | diagnosiscode | diagnosisdescription | provenance |
drop table if exists glaucoma.bb_gbq_diagnosis_20240925;
create table glaucoma.bb_gbq_diagnosis_20240925 as 
    select 
    diagnosis_pk,
    diagnosiscodetype, 
    diagnosiscode, 
    diagnosisdescription, 
    provenance
    from coris_registry.BB_gbq_diagnosis_20240925
    where diagnosiscode like '%H40%' OR diagnosiscode like '%365%';


/* FYI - Provenenance for where diagnosis codes come from */
-- select distinct (provenance) FROM coris_registry.c3304_gbq_t3_diagnosis_20240925
-- -- 'Billing Diagnosis'
-- -- 'Encounter Diagnosis'
-- -- 'Problem list'
