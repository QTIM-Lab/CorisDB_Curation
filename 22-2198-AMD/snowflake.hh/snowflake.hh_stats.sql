####################images of select devproc, - # pt 35262

select count(distinct ptid)
from axispacs_snowflake.file_paths_and_meta
where devproc in ('Cirrus Photo (Scans)','DRSPlus (Anschutz)','Eidon 1 (Anschutz)','Eidon 2 (Anschutz)','Eidon (LoDo)','Nidek','NonMyd','Optos Advanced','Optos (Anschutz)','Optos (Lone Tree)','Optos Silverstone (Anschutz)','Photos','SlitLamp','Slit Lamp 1 (AOP Neuro)','Slit Lamp 2 (AOP Neuro)','Slit Lamp 3 (AOP Neuro)','SlitLamp (Anschutz)','Spectralis (Scans)','Spectralis (Scans) 3','Spectralis (Scans) 4','Spectralis (Scans) 5','Spectralis (Scans) (AOP Neuro)','Topcon 50DX (Anschutz)','Topcon Camera')
;
####################images of select devproc, - # imgs
select count(file_path_coris)
from axispacs_snowflake.file_paths_and_meta
where devproc in ('Cirrus Photo (Scans)','DRSPlus (Anschutz)','Eidon 1 (Anschutz)','Eidon 2 (Anschutz)','Eidon (LoDo)','Nidek','NonMyd','Optos Advanced','Optos (Anschutz)','Optos (Lone Tree)','Optos Silverstone (Anschutz)','Photos','SlitLamp','Slit Lamp 1 (AOP Neuro)','Slit Lamp 2 (AOP Neuro)','Slit Lamp 3 (AOP Neuro)','SlitLamp (Anschutz)','Spectralis (Scans)','Spectralis (Scans) 3','Spectralis (Scans) 4','Spectralis (Scans) 5','Spectralis (Scans) (AOP Neuro)','Topcon 50DX (Anschutz)','Topcon Camera')
;

####################narrative notes - # pt
create unlogged table image_ptid as
    select distinct ptid
    from axispacs_snowflake.file_paths_and_meta
    where devproc in ('Cirrus Photo (Scans)','DRSPlus (Anschutz)','Eidon 1 (Anschutz)','Eidon 2 (Anschutz)','Eidon (LoDo)','Nidek','NonMyd','Optos Advanced','Optos (Anschutz)','Optos (Lone Tree)','Optos Silverstone (Anschutz)','Photos','SlitLamp','Slit Lamp 1 (AOP Neuro)','Slit Lamp 2 (AOP Neuro)','Slit Lamp 3 (AOP Neuro)','SlitLamp (Anschutz)','Spectralis (Scans)','Spectralis (Scans) 3','Spectralis (Scans) 4','Spectralis (Scans) 5','Spectralis (Scans) (AOP Neuro)','Topcon 50DX (Anschutz)','Topcon Camera')
;
select count(distinct person.primarymrn)
from c3304_gbq_t1_person_20250429 person
join c3304_gbq_t11_notes_20250429 note on note.arb_person_id = person.arb_person_id
join image_ptid on image_ptid.ptid = person.primarymrn
where notetype = 'Narrative' 
;
####################narrative notes - # notes
select count(note.notetext)
from c3304_gbq_t1_person_20250429 person
join c3304_gbq_t11_notes_20250429 note on note.arb_person_id = person.arb_person_id
join image_ptid on image_ptid.ptid = person.primarymrn
where   notetype = 'Narrative'
;
####################narrative notes not null & len>5 - # pt 
select count(distinct person.primarymrn)
from c3304_gbq_t1_person_20250429 person
join c3304_gbq_t11_notes_20250429 note on note.arb_person_id = person.arb_person_id
join image_ptid on image_ptid.ptid = person.primarymrn
where notetype = 'Narrative' 
        and octet_length (notetext) >5

####################narrative notes not null & len>5 - # notes
select count(note.notetext)
from c3304_gbq_t1_person_20250429 person
join c3304_gbq_t11_notes_20250429 note on note.arb_person_id = person.arb_person_id
join image_ptid on image_ptid.ptid = person.primarymrn
where   notetype = 'Narrative'
        and octet_length (notetext) >5
;

####################Exact date match (image, note) - # pt
select count(DISTINCT ptid)
from hh_t1_cohort_20250519
;
####################Exact date match (image, note) - # images
select count(images)
from hh_t2_image_note_20250519
;
####################Exact date match (image, note) - # notes
select count(ptid)
from hh_t2_image_note_20250519
;
####################devproc - modalities - pairs
select devproc, count(images)
from hh_t2_image_note_20250519
group by devproc
;
