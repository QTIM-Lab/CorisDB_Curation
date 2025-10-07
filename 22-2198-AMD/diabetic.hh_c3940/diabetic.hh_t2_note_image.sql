-- Active: 1742840235060@@127.0.0.1@5432@coris_db
/*Created date: 3/12/2025
Description:
Task Match images and notes 

The task is now to find out how many images can be successfully matched with a narrative note. 
Warning: some notes may not be from Ophthalmology; how can we automatically check?

Modification Log:
====================================================================*/

-- Drop tables if they exist
DROP TABLE IF EXISTS cohortDiabetic;
DROP TABLE IF EXISTS encYMD;
DROP TABLE IF EXISTS temp_note;
DROP TABLE IF EXISTS OCTCFP;

-- Create unlogged tables
CREATE UNLOGGED TABLE cohortDiabetic AS      -- getting Diabetic cohort and comorbidities
    SELECT 
            dx.arb_person_id,
            person.primarymrn as ptid
        FROM coris_registry.c3304_gbq_t3_diagnosis_20250205 dx
    join coris_registry.c3304_gbq_t1_person_20250205 person on person.arb_person_id = dx.arb_person_id
        WHERE 
            WHERE dx.diagnosiscode like 'E10.3%'
          OR dx.diagnosiscode LIKE 'E11.3%'
          OR dx.diagnosiscode  LIKE '362.0%'
;
            
CREATE INDEX idx_cohortDiabetic ON cohortDiabetic (arb_person_id);

CREATE UNLOGGED TABLE encYMD AS        --getting enc date_key, arb_person_id, arb_encounter_id
    SELECT cohortDiabetic.ptid, 
    enc.arb_encounter_id, 
                    -- EXTRACT(YEAR from "date") as year,
                    -- EXTRACT(MONTH from "date") as month,
                    -- EXTRACT(DAY from "date") as day,
    EXTRACT(YEAR FROM "date") * 10000 + EXTRACT(MONTH FROM "date") * 100 + EXTRACT(DAY FROM "date") AS date_key
    FROM coris_registry.c3304_gbq_t2_encounter_20250205 enc
    join cohortDiabetic on cohortDiabetic.arb_person_id=enc.arb_person_id
;       
CREATE INDEX idx_encYMD_person_date ON encYMD (arb_encounter_id, date_key)
;

CREATE UNLOGGED TABLE temp_note AS     --getting temp_note based on arb_encounter_id (filtered by cohortDiabetic)
SELECT note.arb_encounter_id, 
        noteepicid,
        encYMD.ptid,
        encYMD.date_key
FROM coris_registry.c3304_gbq_t11_notes_20250205 note
join encYMD on encYMD.arb_encounter_id = note.arb_encounter_id
--WHERE notetype = 'Progress Notes'
WHERE notetype = 'Narrative'
;       

CREATE INDEX idx_temp_note ON temp_note (ptid,date_key)
;

CREATE UNLOGGED TABLE OCTCFP AS
    SELECT 
        ptid,
        year * 10000 + month * 100 + day AS date_key,
        file_path_coris
FROM axispacs_snowflake.file_paths_and_meta  
WHERE devproc in ('Cirrus Photo (Scans)','DRSPlus (Anschutz)','Eidon 1 (Anschutz)','Eidon 2 (Anschutz)','Eidon (LoDo)','EyeCubed-Anschutz','EyeCubed-Boulder','EyePrime (Anschutz)','Ellex ULS','Nidek','NonMyd','Panocam','Photos','Spectralis (Scans)','Spectralis (Scans) 3','Spectralis (Scans) 4','Spectralis (Scans) 5','Spectralis (Scans) (AOP Neuro)','Topcon Camera','Topcon 50DX (Anschutz)','UBM','VuPad') 
; 
CREATE INDEX idx_octcfp ON OCTCFP (ptid, date_key)
;

-- Final query
-- EXPLAIN ANALYZE
SELECT
   OCTCFP.ptid,
   temp_note.noteepicid,
   file_path_coris
FROM OCTCFP
JOIN temp_note ON temp_note.ptid = OCTCFP.ptid AND temp_note.date_key = OCTCFP.date_key
;
