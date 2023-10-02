

select * from glaucoma.fundus_encounters limit 10;

select * from axispacs_snowflake.file_paths_and_meta limit 10;

select * from glaucoma.fundus_09_21_2023 limit 10;

/* NonMyd OD */
select
    -- count(*)
    f.file_path_coris,
    -- fe.pat_enc_csn_id,
    f.fileeye,
    f.ptid as pat_mrn,
    f.devname,
    '/data/FUNDUS_Scott_09_21_2023' || '/' || f.ptid || '/' || fe.pat_enc_csn_id || '/' || f.devname || '/' || regexp_replace(f.file_path_coris, '^.+[/\\]', '') as path_for_scott,
    regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)') AS CDR,
    (regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)'))[1]::float AS CDR_right,
    (regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)'))[2]::float AS CDR_left
    --fe.progress_note
    --,*
from axispacs_snowflake.file_paths_and_meta as f inner join glaucoma.fundus_encounters as fe
    on f.ptid = fe.pat_mrn
    and fe.Year = f.Year
    and fe.Month = f.Month
    and fe.Day = f.Day
where f.devname in ('NonMyd') and f.fileeye ='OD'
limit 4 --and f.ptid = ''


/* NonMyd OS */
select
    -- count(*)
    f.file_path_coris,
    -- fe.pat_enc_csn_id,
    f.fileeye,
    f.ptid as pat_mrn,
    f.devname,
    '/data/FUNDUS_Scott_09_21_2023' || '/' || f.ptid || '/' || fe.pat_enc_csn_id || '/' || f.devname || '/' || regexp_replace(f.file_path_coris, '^.+[/\\]', '') as path_for_scott,
    regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)') AS CDR,
    (regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)'))[1]::float AS CDR_right,
    (regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)'))[2]::float AS CDR_left
    --fe.progress_note
    --,*
from axispacs_snowflake.file_paths_and_meta as f inner join glaucoma.fundus_encounters as fe
    on f.ptid = fe.pat_mrn
    and fe.Year = f.Year
    and fe.Month = f.Month
    and fe.Day = f.Day
where f.devname in ('NonMyd') and f.fileeye ='OS'
limit 4 --and f.ptid = ''


/* Photos OD */
select
    -- count(*)
    f.file_path_coris,
    -- fe.pat_enc_csn_id,
    f.fileeye,
    f.ptid as pat_mrn,
    f.devname,
    '/data/FUNDUS_Scott_09_21_2023' || '/' || f.ptid || '/' || fe.pat_enc_csn_id || '/' || f.devname || '/' || regexp_replace(f.file_path_coris, '^.+[/\\]', '') as path_for_scott,
    regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)') AS CDR,
    (regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)'))[1]::float AS CDR_right,
    (regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)'))[2]::float AS CDR_left
    --fe.progress_note
    --,*
from axispacs_snowflake.file_paths_and_meta as f inner join glaucoma.fundus_encounters as fe
    on f.ptid = fe.pat_mrn
    and fe.Year = f.Year
    and fe.Month = f.Month
    and fe.Day = f.Day
where f.devname in ('Photos') and f.fileeye in ('U')
limit 4 --and f.ptid = ''








select * from ehr.OphthalmologyEncounters WHERE pat_mrn in ('') --in ('') 
limit 10;

select * from ehr.OphthalmologyEncounterVisit WHERE pat_mrn in ('') --in ('') 
limit 10;



select * from ehr.OphthalmologyEncounterVisit WHERE pat_mrn in ('') --in ('') 
limit 10;




select
    -- count(*)
    f.file_path_coris,
    -- fe.pat_enc_csn_id,
    f.fileeye,
    f.ptid as pat_mrn,
    f.devname,
    '/data/FUNDUS_Scott_09_21_2023' || '/' || f.ptid || '/' || fe.pat_enc_csn_id || '/' || f.devname || '/' || regexp_replace(f.file_path_coris, '^.+[/\\]', '') as path_for_scott,
    regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)') AS CDR,
    (regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)'))[1]::float AS CDR_right,
    (regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)'))[2]::float AS CDR_left
    --fe.progress_note
    --,*
    from axispacs_snowflake.file_paths_and_meta as f inner join glaucoma.fundus_encounters as fe
    on f.ptid = fe.pat_mrn
    and fe.Year = f.Year
    and fe.Month = f.Month
    and fe.Day = f.Day
    where f.devname in ('NonMyd')
    limit 8 --and f.ptid = ''


