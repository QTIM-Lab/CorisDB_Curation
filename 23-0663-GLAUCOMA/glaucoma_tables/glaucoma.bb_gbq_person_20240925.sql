/* A new person table for glaucoma that is filterd from ICD 9 codes from
   - glaucoma.bb_gbq_glaucoma_diagnosis_<date> 
   - coris_registry.c3304_gbq_t1_person_<date>
*/

-- Use glaucoma.bb_gbq_glaucoma_encounter_diagnosis_<date> table to:
  -- filter global enounters for glaucoma encounters
  -- filter glaucoma encounters for glaucoma patients
  -- ultimately we want a subset that looks just like the patient's table in coris_registry
  
-- | arb_person_id | primarymrn | birthdate | name | sex | race | ethnicity | primarylanguage | needinterpreter | payorfinancialclass | zipcode | deceasedyn | cdphe_dod | dateofdeathemr | causeofdeat |
drop table if exists glaucoma.bb_gbq_glaucoma_person_20240925;
create table glaucoma.bb_gbq_glaucoma_person_20240925 as  
SELECT 
-- DUE TO A PERSON BEING ABLE TO HAVE MULTIPLE ENCOUNTERS AND DIAGNOSES PER ENCOUNTER,
-- CERTAIN VIEWS WHEN USING THIS QUERY CAN SEEM LIKE ROWS ARE BEING DUPLICATED.
-- FOR THE FINAL PERSON TABLE FOR GLAUCOMA, WE NEED "distinct" AS WE ARE HIDING THE COLS
-- THAT CAUSE THE DUPLICATION (ENCOUNTERS AND DIAGNOSES). SO THERE ISN'T A BUG.
--
distinct 
-- count(*)
/* encounter_diagnosis columns */
-- glaucoma_e_d.diagnosis_pk,
/* encounter columns */
-- e.arb_person_id,
-- e.arb_encounter_id,
-- e.department,
-- e.departmentspecialty,
-- e.encountertype,
-- e.patientclass,
-- e."date",
-- e.admissiondate,
-- e.dischargedate,
-- e.losdays,
-- e.loshours,
-- e.iculosdays,
-- e.providername,
-- e.primaryspecialty,
-- e.payorfinancialclass,
-- e.payorname,
/* patient columns */
p.arb_person_id,
p.primarymrn,
p.birthdate,
p.name,
p.sex,
p.race,
p.ethnicity,
p.primarylanguage,
p.needinterpreter,
p.payorfinancialclass,
p.zipcode,
p.deceasedyn,
p.cdphe_dod,
p.dateofdeathemr,
p.causeofdeath
from coris_registry.c3304_gbq_t2_encounter_20240207 as e
inner join glaucoma.bb_gbq_glaucoma_encounter_diagnosis_20240925 as glaucoma_e_d
on e.arb_encounter_id = glaucoma_e_d.arb_encounter_id
inner join coris_registry.c3304_gbq_t1_person_20240925 as p
on p.arb_person_id = e.arb_person_id;
