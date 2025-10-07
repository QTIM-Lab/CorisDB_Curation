/*Created date: 3/12/2025
Description:
Task 3. Collect comorbidities for AMD patients 

We need to collect comorbidities associated with AMD patients after the time of diagnosis. 

Specifically, we are interested in knowing what the top 10 most common comorbidities in our cohort are. 
Modification Log:
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
CREATE INDEX idx_cohortamd ON cohortAMD (arb_person_id);

DROP TABLE IF EXISTS non_amd_oph;
CREATE TEMP TABLE non_amd_oph AS
  select DISTINCT
      dx.arb_person_id
      ,dx.arb_encounter_id
      ,dx.diagnosiscodetype 
      ,dx.diagnosiscode
  from cohortAMD
  inner join coris_registry.c3304_gbq_t3_diagnosis_20250205 dx on dx.arb_person_id = cohortAMD.arb_person_id
  WHERE 
        -- ICD-10 All ophthalmology-related diagnoses
        (
          dx.diagnosiscodetype = 'ICD-10-CM' AND 
            (
              dx.Diagnosiscode LIKE 'H0%' OR dx.Diagnosiscode LIKE 'H1%' 
              OR dx.Diagnosiscode LIKE 'H2%' OR dx.Diagnosiscode LIKE 'H3%' 
              OR dx.Diagnosiscode LIKE 'H4%' OR dx.Diagnosiscode LIKE 'H5%'
            )
        )
        -- ICD-9 all ophthalmology-related diagnoses
        OR 
          (
            dx.diagnosiscodetype = 'ICD-9-CM' AND 
              (
                dx.Diagnosiscode LIKE '36%' OR dx.Diagnosiscode LIKE '37%'
              )
          )
;


CREATE TEMP TABLE top10ICD9 AS
  Select diagnosiscodetype, diagnosiscode, count(*) 
  from non_amd_oph
  group by 1, 2
  having diagnosiscodetype = 'ICD-9-CM'
  order by count(*) desc
  limit 10
;
CREATE TEMP TABLE top10ICD10 AS
    select diagnosiscodetype, diagnosiscode, count(*) 
    from non_amd_oph
    group by 1, 2
    having diagnosiscodetype = 'ICD-10-CM'
    order by count(*) desc
    limit 10
 ;
 select * from top10ICD9
 union all
 select * from top10ICD10
;

 
