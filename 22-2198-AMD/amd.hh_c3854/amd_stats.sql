DROP TABLE IF EXISTS cohortAMD;
DROP TABLE IF EXISTS encYMD;
DROP TABLE IF EXISTS temp_note;
DROP TABLE IF EXISTS OCTCFP;
DROP TABLE IF EXISTS t11;


CREATE UNLOGGED TABLE cohortAMD AS         -- getting amd cohort --
    SELECT DISTINCT
            dx.arb_person_id
            ,person.primarymrn as ptid
    FROM coris_registry.c3304_gbq_t3_diagnosis_20250429 dx
    join coris_registry.c3304_gbq_t1_person_20250429 person on person.arb_person_id = dx.arb_person_id
    where 
        dx.diagnosiscode like 'H35.31%'
        or dx.diagnosiscode like 'H35.32%'
        or dx.diagnosiscode in ('362.50', '362.51', '362.52');

CREATE UNLOGGED TABLE OCTCFP AS
SELECT ptid,
    --year * 10000 + month * 100 + day AS date_key,
    file_path_coris
FROM axispacs_snowflake.file_paths_and_meta  
WHERE devproc in ('Spectralis (Scans)','Spectralis (Scans) 3','Spectralis (Scans) 4','Spectralis (Scans) 5','Spectralis (Scans) (AOP Neuro)') 
; 

CREATE UNLOGGED TABLE pacs AS
SELECT ptid,
    
    file_path_coris
FROM axispacs_snowflake.file_paths_and_meta  
 
; 

CREATE UNLOGGED TABLE t11 AS
SELECT arb_person_id
        ,notetext
    
FROM coris_registry.c3304_gbq_t11_notes_20250429 
where  
 notetype = 'Narrative'
;


##################images###############
select count( file_path_coris)
FROM pacs;

select count( file_path_coris)
FROM pacs
join cohortamd on cohortamd.ptid = pacs.ptid;

select count(file_path_coris)
from OCTCFP 
join cohortamd on cohortamd.ptid = OCTCFP.ptid;

select count(DISTINCT file_path_coris)
FROM pacs
join  cohortamd on cohortamd.ptid = pacs.ptid
join t11 on t11.arb_person_id=cohortamd.arb_person_id;

####################notes#############
select count(notetext)
from t11;

select count(t11.notetext)
from t11
join cohortamd on cohortamd.arb_person_id=t11.arb_person_id
;

select count(t11.notetext)
from t11
join cohortamd on cohortamd.arb_person_id=t11.arb_person_id
join pacs on pacs.ptid = cohortamd.ptid
;

select count( t11.notetext)
from t11
join cohortamd on cohortamd.arb_person_id=t11.arb_person_id
join OCTCFP on OCTCFP.ptid = cohortamd.ptid
;

select count(t11.notetext)
from t11
join cohortamd on cohortamd.arb_person_id=t11.arb_person_id
join pacs on pacs.ptid = cohortamd.ptid
;