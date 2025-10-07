/*Created date: 4/12/2025
Description: 

Controls requirements 
    --Has never been diagnosed with diabetic retinopathy 
    --May or may not have been diagnosed with a group of relevant comorbidities 
        -- ('365.11', '375.15', '366.16', '365.00', '365.70', '362.52', '367.4', '366.10', '367.20', '366.9', 'H04.123', 'H04.129', 'H25.13', 'H40.1190', 'H25.9', 'H52.4', 'H26.9', 'H40.9', 'H40.009', 'H52.203') 
Modification Log:
====================================================================*/
DROP TABLE IF EXISTS cohortDiabetic;
CREATE UNLOGGED TABLE cohortDiabetic AS      -- getting Glaucoma cohort --
    SELECT DISTINCT
            dx.arb_person_id
    FROM coris_registry.c3304_gbq_t3_diagnosis_20250205 dx
    join coris_registry.c3304_gbq_t1_person_20250205 person on person.arb_person_id = dx.arb_person_id
    WHERE dx.diagnosiscode like 'E10.3%'
          OR dx.diagnosiscode LIKE 'E11.3%'
          OR dx.diagnosiscode  LIKE '362.0%'
;

select DISTINCT
    dx.arb_person_id
    --,dx.arb_encounter_id  we are counting encounters so comment out unlike T3
    ,dx.diagnosiscodetype 
    ,dx.diagnosiscode
from coris_registry.c3304_gbq_t3_diagnosis_20250205 dx
WHERE
    dx.arb_person_id NOT in (select cohortDiabetic.arb_person_id from cohortDiabetic)



 
