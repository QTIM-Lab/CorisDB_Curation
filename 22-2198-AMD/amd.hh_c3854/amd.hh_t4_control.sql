/*Created date: 3/12/2025
Description: 

Controls requirements 
    --Has never been diagnosed with AMD 
    --The definition of controls is “patients who were never diagnosed with AMD” or “patient ids not in AMD cohort” 
Modification Log:
    no longer include comorbidities, just never been diagnosis with AMD
====================================================================*/

DROP TABLE IF EXISTS cohortAMD;
CREATE UNLOGGED TABLE cohortAMD AS      -- getting amd cohort --
    SELECT DISTINCT
            dx.arb_person_id
    FROM coris_registry.c3304_gbq_t3_diagnosis_20250205 dx
    join coris_registry.c3304_gbq_t1_person_20250205 person on person.arb_person_id = dx.arb_person_id
    where 
        dx.diagnosiscode like 'H35.31%'
        or dx.diagnosiscode like 'H35.32%'
        or dx.diagnosiscode in ('362.50', '362.51', '362.52')
;

select DISTINCT
    dx.arb_person_id
    --,dx.arb_encounter_id  we are counting encounters so comment out unlike T3
    ,dx.diagnosiscodetype 
    ,dx.diagnosiscode
from coris_registry.c3304_gbq_t3_diagnosis_20250205 dx
WHERE
    dx.arb_person_id NOT in (select cohortAMD.arb_person_id from cohortAMD)
    
    -- AND
    -- (
    -- -- ICD-10 All ophthalmology-related diagnoses
    --     (
    --     dx.diagnosiscodetype = 'ICD-10-CM' AND 
    --         (
    --         dx.Diagnosiscode LIKE 'H0%' OR dx.Diagnosiscode LIKE 'H1%' 
    --         OR dx.Diagnosiscode LIKE 'H2%' OR dx.Diagnosiscode LIKE 'H3%' 
    --         OR dx.Diagnosiscode LIKE 'H4%' OR dx.Diagnosiscode LIKE 'H5%'
    --         )
    --     )
    --     -- ICD-9 all ophthalmology-related diagnoses
    --     OR 
    --     (
    --         dx.diagnosiscodetype = 'ICD-9-CM' AND 
    --         (
    --             dx.Diagnosiscode LIKE '36%' OR dx.Diagnosiscode LIKE '37%'
    --         )
    --     )
    -- )
;








 
