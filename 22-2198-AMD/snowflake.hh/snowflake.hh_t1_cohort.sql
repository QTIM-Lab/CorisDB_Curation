/*Created date: 5/15/2025
Description: 
    Build cohort of (image, narrative note) pairs using snowflake 
    Restrict to imaging modalities of interest from  image_devices_and_modalities.xlsx (the Ys) 
    Include dev-specific columns into the final csv file (devname, devtype, devdescription, devproc) 
Modification Log:
====================================================================*/
CREATE UNLOGGED TABLE pre as
        SELECT DISTINCT 
                person.primarymrn as ptid
                ,EXTRACT(YEAR FROM "dateofnote") * 10000 + EXTRACT(MONTH FROM "dateofnote") * 100 + EXTRACT(DAY FROM "dateofnote") AS note_date_key  
                ,EXTRACT(YEAR FROM encounterdate) * 10000 + EXTRACT(MONTH FROM encounterdate) * 100 + EXTRACT(DAY FROM encounterdate) AS enc_date_key
        FROM coris_registry.c3304_gbq_t1_person_20250429 person
                join coris_registry.c3304_gbq_t11_notes_20250429 note on note.arb_person_id = person.arb_person_id
                join coris_registry.c3304_gbq_t3_diagnosis_20250429 dx on dx.arb_encounter_id = note.arb_encounter_id 
        where note.notetype = 'Narrative' 
        and octet_length (notetext) >5
;

SELECT 
        snowflakepath.ptid
        ,snowflakepath.devname
        ,snowflakepath.devtype
        ,snowflakepath.devdescription
        ,snowflakepath.devproc
        ,snowflakepath.year * 10000 + snowflakepath.month * 100 + snowflakepath.day AS date_key
        ,snowflakepath.fileeye     
FROM axispacs_snowflake.file_paths_and_meta snowflakepath
join pre on pre.ptid = snowflakepath.ptid 
         and pre.enc_date_key = snowflakepath.year * 10000 + snowflakepath.month * 100 + snowflakepath.day

where snowflakepath.devproc in ('Cirrus Photo (Scans)','DRSPlus (Anschutz)','Eidon 1 (Anschutz)','Eidon 2 (Anschutz)','Eidon (LoDo)','Nidek','NonMyd','Optos Advanced','Optos (Anschutz)','Optos (Lone Tree)','Optos Silverstone (Anschutz)','Photos','SlitLamp','Slit Lamp 1 (AOP Neuro)','Slit Lamp 2 (AOP Neuro)','Slit Lamp 3 (AOP Neuro)','SlitLamp (Anschutz)','Spectralis (Scans)','Spectralis (Scans) 3','Spectralis (Scans) 4','Spectralis (Scans) 5','Spectralis (Scans) (AOP Neuro)','Topcon 50DX (Anschutz)','Topcon Camera')
;
