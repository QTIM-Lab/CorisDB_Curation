DROP TABLE IF EXISTS amd.files;
CREATE TABLE IF NOT EXISTS amd.files as
select
distinct
file_path_coris,
pat_enc_csn_id,
pat_age_at_enc,
exdatetime,
exsrno,
ptid as pat_mrn,
devname,
devdescription,
devtype,
devproc,
devsrno,
filenote,
filedata
from amd.amd_encounters as e --limit 10;
inner join axispacs_snowflake.file_paths_and_meta as f
on e.pat_mrn = f.ptid
    and e.year = f.year
    and e.month = f.month
    and e.day = f.day