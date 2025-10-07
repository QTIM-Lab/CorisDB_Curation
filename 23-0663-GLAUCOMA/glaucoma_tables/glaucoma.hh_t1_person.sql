/*Created date: 
Description:


Task 1. Patients with glaucoma 
Collect a cohort of patients diagnosed with AMD (as defined above). For each patient, collect the following pieces of information: 
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
        min(case when dx.diagnosiscode like 'H40.0%1' 
                   or dx.diagnosiscode like 'H40.1%1%'
                   or dx.diagnosiscode like 'H40.2%1%'
                   or dx.diagnosiscode like 'H40.31%'
                   or dx.diagnosiscode like 'H40.41%'
                   or dx.diagnosiscode like 'H40.51%'
                   or dx.diagnosiscode like 'H40.61%'
                   or dx.diagnosiscode like 'H40.8%1%'
                   then dx.encounterdate else null end) as earliest_dx_right,
        min(case when dx.diagnosiscode like 'H40.0%2%' 
                   or dx.diagnosiscode like 'H40.1%2%' 
                   or dx.diagnosiscode like 'H40.2%2%' 
                   or dx.diagnosiscode like 'H40.32%'
                   or dx.diagnosiscode like 'H40.42%'
                   or dx.diagnosiscode like 'H40.52%'
                   or dx.diagnosiscode like 'H40.62%'
                   or dx.diagnosiscode like 'H40.8%2%'
                   then dx.encounterdate else null end) as earliest_dx_left,
        min(case when dx.diagnosiscode like 'H40.0%3%' 
                   or dx.diagnosiscode like 'H40.1%3%' 
                   or dx.diagnosiscode like 'H40.2%3%' 
                   or dx.diagnosiscode like 'H40.33%'
                   or dx.diagnosiscode like 'H40.43%'
                   or dx.diagnosiscode like 'H40.53%'
                   or dx.diagnosiscode like 'H40.63%'
                   or dx.diagnosiscode like 'H40.8%3%'
                   then dx.encounterdate else null end) as earliest_dx_bilateral,
        min(case when dx.diagnosiscode like 'H40.0%9%' 
                   or dx.diagnosiscode like 'H40.1%9%' 
                   or dx.diagnosiscode like 'H40.2%9%'
                   or dx.diagnosiscode like 'H40.8%9%'
                   or dx.diagnosiscode in ('H40.10','H40.10X0','H40.20','H40.20X0','H40.30','H40.30X0',
                                   'H40.40','H40.40X0','H40.50','H40.50X0','H40.60','H40.60X0','H40.9') 

                   or dx.diagnosiscode like '365.%'
                   then dx.encounterdate else null end) as earliest_dx_unspecified
    
    FROM coris_registry.c3304_gbq_t3_diagnosis_20250205 dx
    where 
        dx.diagnosiscode like 'H40.%'
        or dx.diagnosiscode like '365.%'
    GROUP BY dx.arb_person_id
;

SELECT DISTINCT
     person.arb_person_id, -- add arb_person_id for control table
     person.PrimaryMrn,
     person.birthdate,
     earliest_dx.earliest_dx_right,
     earliest_dx.earliest_dx_left,
     earliest_dx.earliest_dx_bilateral,
     earliest_dx.earliest_dx_unspecified,
    --  EXTRACT(YEAR FROM AGE(earliest_dx.earliest_dx_right, person.birthdate)) AS AgeAtDx_right,
    --  EXTRACT(YEAR FROM AGE(earliest_dx.earliest_dx_left, person.birthdate)) AS AgeAtDx_left,
    --  EXTRACT(YEAR FROM AGE(earliest_dx.earliest_dx_bilateral, person.birthdate)) AS AgeAtDx_bilateral,
    --  EXTRACT(YEAR FROM AGE(earliest_dx.earliest_dx_unspecified, person.birthdate)) AS AgeAtDx_unspecified,
     person.sex,
     person.Race,
     person.Ethnicity
FROM coris_registry.c3304_gbq_t1_person_20250205 AS person
INNER JOIN earliest_dx ON person.arb_person_id = earliest_dx.arb_person_id
where EXTRACT(YEAR FROM AGE(earliest_dx.earliest_dx_right, person.birthdate)) is not null
      or EXTRACT(YEAR FROM AGE(earliest_dx.earliest_dx_left, person.birthdate)) is not null
      or EXTRACT(YEAR FROM AGE(earliest_dx.earliest_dx_bilateral, person.birthdate)) is not null
      or EXTRACT(YEAR FROM AGE(earliest_dx.earliest_dx_unspecified, person.birthdate)) is not null
    




