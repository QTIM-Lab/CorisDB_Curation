/*Created date: 3/12/2025
Description: We will define amd cohort as a diagnosis of 



Task 1. Patients with amd
Collect a cohort of patients diagnosed with amd (as defined above). For each patient, collect the following pieces of information: 
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
        min(case when dx.diagnosiscode like 'H35.311%' 
                   or dx.diagnosiscode like 'H35.321%'
                   then dx.encounterdate else null end) as earliest_dx_right,
        min(case when dx.diagnosiscode like 'H35.312%' 
                   or dx.diagnosiscode like 'H35.322%'
                   then dx.encounterdate else null end) as earliest_dx_left,
        min(case when dx.diagnosiscode like 'H35.313%' 
                   or dx.diagnosiscode like 'H35.323%'
                   then dx.encounterdate else null end) as earliest_dx_bilateral,
        min(case when dx.diagnosiscode like 'H35.319%' 
                   or dx.diagnosiscode like 'H35.329%' 
                   or dx.diagnosiscode in ('362.50', '362.51', '362.52') 
                   then dx.encounterdate else null end) as earliest_dx_unspecified
    
    FROM coris_registry.c3304_gbq_t3_diagnosis_20250205 dx
    where 
        dx.diagnosiscode like 'H35.31%'
        or dx.diagnosiscode like 'H35.32%'
        or dx.diagnosiscode in ('362.50', '362.51', '362.52')
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








/*
            ********If choose to use exact match of ICD10 and ICD9********

        min(case when dx.diagnosiscode in ('H35.3110','H35.3111', 'H35.3112', 'H35.3113', 'H35.3114', 'H35.3210','H35.3211', 'H35.3212','H35.3213') then dx.encounterdate else null end) as earliest_dx_right,

        min(case when dx.diagnosiscode in ('H35.3120','H35.3121', 'H35.3122', 'H35.3123', 'H35.3124', 'H35.3220','H35.3221', 'H35.3222','H35.3223') then dx.encounterdate else null end) as earliest_dx_left,

        min(case when dx.diagnosiscode in ('H35.3130','H35.3131', 'H35.3132', 'H35.3133', 'H35.3134', 'H35.3230','H35.3231', 'H35.3232','H35.3233') then dx.encounterdate else null end) as earliest_dx_bilateral,

        min(case when dx.diagnosiscode in ('H35.3190','H35.3191', 'H35.3192', 'H35.3193', 'H35.3194', 'H35.3290','H35.3291', 'H35.3292','H35.3293', 'H35.31','H35.311','H35.312','H35.313','H35.319', 'H35.32',

                                           'H35.321','H35.322','H35.323','H35.329', '362.50', '362.51', '362.52') then dx.encounterdate else null end) as earliest_dx_unspecified 

    WHERE dx.diagnosiscode in (                
                -- all right eye
                'H35.3110','H35.3111', 'H35.3112', 'H35.3113', 'H35.3114', 'H35.3210','H35.3211', 'H35.3212','H35.3213', 
                -- all left eye
                'H35.3120','H35.3121', 'H35.3122', 'H35.3123', 'H35.3124', 'H35.3220','H35.3221', 'H35.3222','H35.3223', 
                -- all bilateral
                'H35.3130','H35.3131', 'H35.3132', 'H35.3133', 'H35.3134', 'H35.3230','H35.3231', 'H35.3232','H35.3233', 
                -- all unspecified
                'H35.3190','H35.3191', 'H35.3192', 'H35.3193', 'H35.3194', 
                'H35.3290','H35.3291', 'H35.3292','H35.3293',
                'H35.31','H35.311','H35.312','H35.313','H35.319',
                'H35.32','H35.321','H35.322','H35.323','H35.329',
                '362.50', '362.51', '362.52',
                )
*/