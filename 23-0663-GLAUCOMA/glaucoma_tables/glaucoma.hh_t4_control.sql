/*Created date: 
Description: 

Controls requirements 
    --Has never been diagnosed with glaucoma 
    --May or may not have been diagnosed with a group of relevant comorbidities  
Modification Log:

====================================================================*/

DROP TABLE IF EXISTS cohortGlaucoma;
CREATE UNLOGGED TABLE cohortGlaucoma AS      -- getting Glaucoma cohort --
    SELECT DISTINCT
            dx.arb_person_id
    FROM coris_registry.c3304_gbq_t3_diagnosis_20250205 dx
    join coris_registry.c3304_gbq_t1_person_20250205 person on person.arb_person_id = dx.arb_person_id
    where 
        dx.diagnosiscode like 'H40.%'
        or dx.diagnosiscode like '365.%'
;

select DISTINCT
    dx.arb_person_id
    --,dx.arb_encounter_id  we are counting encounters so comment out unlike T3
    ,dx.diagnosiscodetype 
    ,dx.diagnosiscode
from coris_registry.c3304_gbq_t3_diagnosis_20250205 dx
WHERE
    dx.arb_person_id NOT in (select cohortGlaucoma.arb_person_id from cohortGlaucoma)
    





 
