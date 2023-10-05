/* Find a patients images */
CREATE TABLE IF NOT EXISTS dashboard.files AS
    select
    file_path_coris, devname, exdatetime, ptid ,year, month, day,
    dicomstudyuid,
    dicomseriesuid,
    dicomsopinstanceuid,
    dicomacquisitiondatetime,
    'cp' || ' ' || file_path_coris || ' ' || '/projects/coris_db/dashboard_sample_images' as copy_command
    --,*

    from axispacs_snowflake.file_paths_and_meta
    where ptid = ''
    and file_path_coris like '%.dcm'
    -- and ptid = ''
    -- and file_path_coris like '%.dcm'
    -- and exdatetime = '2022-03-02 00:00:00' 
    -- and devname = 'Cirrus OCT'
    -- Specific images
    and (file_path_coris like '%%'
        or file_path_coris like '%%'
        )
    order by devname, exdatetime  limit 1000;

/* Make copy script */


/* Find a patients encounters */
CREATE TABLE IF NOT EXISTS dashboard.encounters AS
    select 
    EXTRACT(YEAR from contact_date) as year,
    EXTRACT(MONTH from contact_date) as month,
    EXTRACT(DAY from contact_date) as day,
    * from ehr.ophthalmologyencountervisit
    where pat_mrn = ''
    and EXTRACT(YEAR from contact_date) = 2020
    and (EXTRACT(MONTH from contact_date) = 6 or EXTRACT(MONTH from contact_date) = 8)
    and (EXTRACT(DAY from contact_date) = 11 or EXTRACT(DAY from contact_date) = 13)

/* Send to Front End */
-- All together but I worry this will duplicate progress note
select * from dashboard.encounters as e
inner join dashboard.files as f
on e.pat_mrn = f.ptid and e.year = f.year and e.month = f.month and e.day = f.day
inner join dashboard.orthanc_ids as o
on o.patientid = CAST(f.ptid as INT) 
-- and o.studyinstanceuid = f.dicomstudyuid -- studies were missing
and o.seriesinstanceuid = f.dicomseriesuid 
and o.sopinstanceuid = f.dicomsopinstanceuid

-- Separate progress note and files
-- Progress note
select * from dashboard.encounters where pat_mrn = ''
-- Files
select * from dashboard.files where ptid = ''