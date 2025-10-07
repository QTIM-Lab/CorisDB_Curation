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


/* Materialized View Version of File Paths and Meta */
-- Materialized view can auto update and might be nice for when data and coming in at a faster pace.
-- Table is likely...all we need
-- Justification:
--   If others are querying a table (potential materialized view) as part their work flows and the view
--   relies on other tables that are being updated in a way that makes updating the table annoying, 
--   you can make it a materialized view to automate the updates.
/* Materialized View Version of File Paths and Meta */


DROP TABLE IF EXISTS axispacs_snowflake.file_paths_and_meta_left_join; -- Table Version
CREATE TABLE axispacs_snowflake.file_paths_and_meta_left_join AS -- Table Version
-- DROP MATERIALIZED VIEW IF EXISTS axispacs_snowflake.file_paths_and_meta; -- Materialized View
-- CREATE MATERIALIZED VIEW axispacs_snowflake.file_paths_and_meta AS -- Materialized View
    select
    case
        when f.filenamenew like '%.dcm%'
        then '/persist/PACS/DICOM/' || p.ptsrno || '/' || e.exsrno || '/' || f.filenamenew
        when f.filenamenew like '%.j2k%'
        then '/persist/PACS/VisupacImages/' || p.ptsrno || '/' || e.exsrno || '/' || f.filenamenew
    end as file_path_coris
    ,f.dicomstudyuid
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
    ,f.tmstamp
    ,f.filedata
    from axispacs_snowflake.files as f
    inner join axispacs_snowflake.exams as e
    on e.exsrno = f.exsrno
    inner join axispacs_snowflake.patients as p
    on p.ptsrno = e.ptsrno
    inner join axispacs_snowflake.devices as d
    on d.devsrno = e.exdevtype
    -- limit 10;

-- REFRESH MATERIALIZED VIEW axispacs_snowflake.file_paths_and_meta; -- Materialized View

