/*Created date: 3/12/2025
Description: We will define Diabetic Retinopathy cohort as a diagnosis of 

--ICD-10 Codes
'E10.319', 'E10.321', 'E10.329', 'E10.331', 'E10.339', 'E10.341', 'E10.349', 'E10.351', 'E10.359', 'E11.319', 'E11.321', 'E11.329', 'E11.331', 'E11.339', 'E11.341', 'E11.349', 'E11.351', 'E11.359'
--ICD-9 Codes
'362.01', '362.02', '362.03', '362.04', '362.05', '362.06', '362.07'

Task 1. Patients with diabetic retinopathy
Collect a cohort of patients diagnosed with diabetic retinopathy (as defined above). For each patient, collect the following pieces of information: 
--Patient mrn 
--Age at earliest diagnosis 
--Gender 
--Race 
--Ethnicity 
Modification Log:

====================================================================*/

drop table if exists earliest_dx;
CREATE UNLOGGED TABLE earliest_dx AS
    SELECT 
        dx.arb_person_id, 
        MIN(dx.encounterdate) AS earliest_encounter_date     
    FROM coris_registry.c3304_gbq_t3_diagnosis_20250205 dx
    WHERE dx.diagnosiscode like 'E10.3%'
          OR dx.diagnosiscode LIKE 'E11.3%'
          OR dx.diagnosiscode  LIKE '362.0%'
    GROUP BY dx.arb_person_id
;

SELECT DISTINCT
    person.PrimaryMrn,
    EXTRACT(YEAR FROM AGE(earliest_dx.earliest_encounter_date, person.birthdate)) AS AgeAtDx,
    person.sex,
    person.Race,
    person.Ethnicity
FROM coris_registry.c3304_gbq_t1_person_20250205 AS person
INNER JOIN earliest_dx ON person.arb_person_id = earliest_dx.arb_person_id
WHERE 
    earliest_dx.earliest_encounter_date IS NOT NULL


                                                           



