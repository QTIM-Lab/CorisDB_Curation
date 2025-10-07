-- Active: 1742840235060@@127.0.0.1@5432@coris_db
/*Created date: 3/12/2025
Description:
Task Match images and notes 

The task is now to find out how many images can be successfully matched with a note. 
Warning: some notes may not be from Ophthalmology; how can we automatically check?

Modification Log:
====================================================================*/
-- Drop tables if they exist
DROP TABLE IF EXISTS cohortGlaucoma;
DROP TABLE IF EXISTS encYMD;
DROP TABLE IF EXISTS temp_note;
DROP TABLE IF EXISTS OCTCFP;


CREATE UNLOGGED TABLE cohortGlaucoma AS         -- getting Glaucoma cohort --
    SELECT DISTINCT
            dx.arb_person_id
            ,person.primarymrn as ptid
    FROM coris_registry.c3304_gbq_t3_diagnosis_20250205 dx
    join coris_registry.c3304_gbq_t1_person_20250205 person on person.arb_person_id = dx.arb_person_id

    where 
        dx.diagnosiscode like 'H40.%'
        or dx.diagnosiscode like '365.%'
;

CREATE INDEX idx_cohortGlaucoma ON cohortGlaucoma (arb_person_id);

CREATE UNLOGGED TABLE encYMD AS         --getting enc date_key, arb_person_id, arb_encounter_id
    SELECT  cohortGlaucoma.ptid, 
            enc.arb_encounter_id,        --getting arb_encounter_id to match with T11 Note
            EXTRACT(YEAR FROM "date") * 10000 + EXTRACT(MONTH FROM "date") * 100 + EXTRACT(DAY FROM "date") AS date_key
    FROM coris_registry.c3304_gbq_t2_encounter_20250205 enc
    join cohortGlaucoma on cohortGlaucoma.arb_person_id=enc.arb_person_id
;       
CREATE INDEX idx_encYMD_person_date ON encYMD (arb_encounter_id, date_key);

CREATE UNLOGGED TABLE temp_note AS     --getting temp_note based on arb_encounter_id (filtered by cohortGlaucoma)
SELECT  note.arb_encounter_id, 
        encYMD.ptid,
        encYMD.date_key
FROM coris_registry.c3304_gbq_t11_notes_20250205 note
join encYMD on encYMD.arb_encounter_id = note.arb_encounter_id
WHERE notetype = 'Progress Notes';       

CREATE INDEX idx_temp_note ON temp_note (ptid,date_key);

CREATE UNLOGGED TABLE OCTCFP AS
SELECT ptid,
    year * 10000 + month * 100 + day AS date_key,
    file_path_coris
FROM axispacs_snowflake.file_paths_and_meta  
WHERE devproc in ('Spectralis (Scans)','Spectralis (Scans) 3','Spectralis (Scans) 4','Spectralis (Scans) 5','Spectralis (Scans) (AOP Neuro)') 
; 
CREATE INDEX idx_octcfp ON OCTCFP (ptid, date_key);

-- Final query
-- EXPLAIN ANALYZE
SELECT
   OCTCFP.ptid,
   temp_note.arb_encounter_id,
   file_path_coris
FROM OCTCFP
JOIN temp_note ON temp_note.ptid = OCTCFP.ptid AND temp_note.date_key = OCTCFP.date_key;


