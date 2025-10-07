
-- Find encounters and make | arb_encounter_id | diagnosis_pk | table
drop table if exists coris_registry.bb_gbq_encounter_diagnosis_20240925;
create table coris_registry.bb_gbq_encounter_diagnosis_20240925 as  
select
-- count(*)
d.arb_encounter_id as arb_encounter_id,
d_only_and_no_encounter.diagnosis_pk as diagnosis_pk
-- d.diagnosiscode,
-- d.diagnosiscodetype,
-- d.diagnosisdescription,
-- d.provenance
from coris_registry.c3304_gbq_t3_diagnosis_20240925 as d
inner join coris_registry.bb_gbq_diagnosis_20240925 as d_only_and_no_encounter
on 
    d.diagnosiscode = d_only_and_no_encounter.diagnosiscode and 
    d.diagnosiscodetype = d_only_and_no_encounter.diagnosiscodetype and 
    d.diagnosisdescription = d_only_and_no_encounter.diagnosisdescription and 
    d.provenance = d_only_and_no_encounter.provenance
order by d.arb_encounter_id, diagnosis_pk
;