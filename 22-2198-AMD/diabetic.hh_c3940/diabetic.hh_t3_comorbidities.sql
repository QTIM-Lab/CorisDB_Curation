/*Created date: 4/12/2025
Description:
Task 3. Collect comorbidities for diabetic retinopathy patients 

We need to collect comorbidities associated with diabetic patients after the time of diagnosis. 

Specifically, we are interested in knowing what the top 10 most common comorbidities in our cohort are. 
Modification Log:
====================================================================*/

drop table if exists earliest_dx;
CREATE TEMP TABLE earliest_dx AS
    SELECT 
      dx.arb_person_id,
      --dx.arb_encounter_id,
      MIN(dx.encounterdate) AS earliest_encounter_date
    FROM coris_registry.c3304_gbq_t3_diagnosis_20250205 dx
    WHERE dx.diagnosiscode like 'E10.3%'
          OR dx.diagnosiscode LIKE 'E11.3%'
          OR dx.diagnosiscode  LIKE '362.0%'
    GROUP BY dx.arb_person_id
;
drop table if exists non_diabetic_oph;
CREATE TEMP TABLE non_diabetic_oph AS
    select distinct
      t1.primarymrn as mrn
      ,dx.arb_encounter_id 
      ,dx.diagnosiscodetype 
      ,dx.diagnosiscode

  from coris_registry.c3304_gbq_t1_person_20250205 t1
  join coris_registry.c3304_gbq_t3_diagnosis_20250205 dx on dx.arb_person_id = t1.arb_person_id
  join earliest_dx on earliest_dx.arb_person_id = t1.arb_person_id
  WHERE dx.encounterdate < earliest_dx.earliest_encounter_date
      AND (
        -- ICD-10 Ophthalmology-related diagnoses
        (dx.diagnosiscodetype = 'ICD-10-CM' AND 
         (dx.Diagnosiscode LIKE 'H0%' OR dx.Diagnosiscode LIKE 'H1%' 
          OR dx.Diagnosiscode LIKE 'H2%' OR dx.Diagnosiscode LIKE 'H3%' 
          OR dx.Diagnosiscode LIKE 'H4%' OR dx.Diagnosiscode LIKE 'H5%'))
        -- ICD-9 Ophthalmology-related diagnoses
        OR (dx.diagnosiscodetype = 'ICD-9-CM' AND 
            (dx.Diagnosiscode LIKE '36%' OR dx.Diagnosiscode LIKE '37%'))
      )
      AND NOT (
        -- Exclude specific target diagnoses
          dx.diagnosiscode like 'E10.3%'
          OR dx.diagnosiscode LIKE 'E11.3%'
          OR dx.diagnosiscode  LIKE '362.0%'    
      )
;
drop table if exists top10ICD9;
CREATE TEMP TABLE top10ICD9 AS
  Select diagnosiscodetype, diagnosiscode, count(*) 
  from non_diabetic_oph
  group by 1, 2
  having diagnosiscodetype = 'ICD-9-CM'
  order by count(*) desc
  limit 10
;
drop table if exists top10ICD10;
CREATE TEMP TABLE top10ICD10 AS
    select diagnosiscodetype, diagnosiscode, count(*) 
    from non_diabetic_oph
    group by 1, 2
    having diagnosiscodetype = 'ICD-10-CM'
    order by count(*) desc
    limit 10
 ;
 select * from top10ICD9
 union all
 select * from top10ICD10

-- ICD-9-CM	365.11	3700
-- ICD-9-CM	375.15	3602
-- ICD-9-CM	366.16	3006
-- ICD-9-CM	365.00	2367
-- ICD-9-CM	365.70	2116
-- ICD-9-CM	362.52	1857
-- ICD-9-CM	367.4	1576
-- ICD-9-CM	366.10	1521
-- ICD-9-CM	367.20	1467
-- ICD-9-CM	366.9	1415
-- ICD-10-CM	H04.123	2578
-- ICD-10-CM	H04.129	2418
-- ICD-10-CM	H25.13	2177
-- ICD-10-CM	H40.1190	1819
-- ICD-10-CM	H25.9	1754
-- ICD-10-CM	H52.4	1704
-- ICD-10-CM	H26.9	1688
-- ICD-10-CM	H40.9	1595
-- ICD-10-CM	H40.009	1590
-- ICD-10-CM	H52.203	1099
