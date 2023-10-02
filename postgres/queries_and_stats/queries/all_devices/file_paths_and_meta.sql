select filenamenew
from axispacs_snowflake.files as f limit 1000000

/* File Extensions */
-- select
--     -- filenamenew,
--     distinct CASE
--         WHEN filenamenew ~ '\.' THEN
--             substring(filenamenew from '\.([^\.]*)$')
--         ELSE
--             NULL
--     END AS file_extension
-- from axispacs_snowflake.files as f
-- limit 1000;

DROP MATERIALIZED VIEW IF EXISTS axispacs_snowflake.file_paths_and_meta
CREATE MATERIALIZED VIEW axispacs_snowflake.file_paths_and_meta AS

    select
    case
        when f.filenamenew like '%.dcm%'
        then '/data/PACS/DICOM/' || p.ptsrno || '/' || e.exsrno || '/' || f.filenamenew
        when f.filenamenew like '%.j2k%'
        then '/data/PACS/VisupacImages/' || p.ptsrno || '/' || e.exsrno || '/' || f.filenamenew
    end as file_path_coris
    ,f.dicomseriesuid
    ,f.dicomsopinstanceuid
    ,f.dicomacquisitiondatetime
    ,e.exdevtype
    ,e.exdatetime
    ,EXTRACT(YEAR from e.exdatetime) as year 
    ,EXTRACT(MONTH from e.exdatetime) as month
    ,EXTRACT(DAY from e.exdatetime) as day
    ,e.exsrno
    ,p.ptsrno
    ,p.ptid
    ,d.devname
    ,d.devdescription
    ,d.devtype
    ,d.devproc
    ,d.dicomaetitle
    ,d.devsrno
    ,f.fileeye
    ,f.filenote
    ,f.filetype
    ,f.filedata
    from axispacs_snowflake.files as f
    inner join axispacs_snowflake.exams as e
    on e.exsrno = f.exsrno
    inner join axispacs_snowflake.patients as p
    on p.ptsrno = e.ptsrno
    inner join axispacs_snowflake.devices as d
    on d.devsrno = e.exdevtype
    -- limit 10;

REFRESH MATERIALIZED VIEW axispacs_snowflake.file_paths_and_meta;