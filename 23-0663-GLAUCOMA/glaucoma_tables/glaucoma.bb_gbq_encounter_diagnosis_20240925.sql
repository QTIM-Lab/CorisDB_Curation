-- Encounters with Glaucoma diagnosis ICD 9 Code
-- Find relevant encounters and make | arb_encounter_id | diagnosis_pk | table
drop table if exists glaucoma.bb_gbq_encounter_diagnosis_20240925;
create table glaucoma.bb_gbq_encounter_diagnosis_20240925 as  
select
-- count(*)
d.arb_encounter_id as arb_encounter_id,
glaucoma_d.diagnosis_pk as diagnosis_pk
-- d.diagnosiscode,
-- d.diagnosiscodetype,
-- d.diagnosisdescription,
-- d.provenance
from coris_registry.c3304_gbq_t3_diagnosis_20240925 as d
inner join glaucoma.bb_gbq_diagnosis_20240925 as glaucoma_d
on 
    d.diagnosiscode = glaucoma_d.diagnosiscode and 
    d.diagnosiscodetype = glaucoma_d.diagnosiscodetype and 
    d.diagnosisdescription = glaucoma_d.diagnosisdescription and 
    d.provenance = glaucoma_d.provenance
order by d.arb_encounter_id, diagnosis_pk
;

