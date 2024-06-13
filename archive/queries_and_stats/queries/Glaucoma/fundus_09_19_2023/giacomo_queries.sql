select * from axispacs_snowflake.file_paths_and_meta limit 10;

/* NonMyd OD */
select
    -- count(*)
    f.file_path_coris,
    -- fe.pat_enc_csn_id,
    f.fileeye,
    f.ptid as pat_mrn,
    f.devname
    -- regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)') AS CDR,
    -- (regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)'))[1]::float AS CDR_right,
    -- (regexp_matches(fe.progress_note, 'C/D Ratio ([0-9]?\.[0-9]+) ([0-9]?\.[0-9]+)'))[2]::float AS CDR_left
    --fe.progress_note
    --,*
from axispacs_snowflake.file_paths_and_meta as f
where f.devname in ('NonMyd') and f.fileeye = 'OD'
limit 4

select distinct devname, devdescription, devtype from axispacs_snowflake.file_paths_and_meta;

select distinct devdescription from axispacs_snowflake.file_paths_and_meta;

select distinct dev from axispacs_snowflake.file_paths_and_meta;

select * from axispacs_snowflake.file_paths_and_meta
where devname like '%Tomey%'
and file_path_coris like '%.dc%'
limit 10;