-- Stats for HVF
select count(*) from axispacs_snowflake.file_paths_and_meta --limit 10;
where file_path_coris like '%.dcm' and devname = 'HFA3 (x3)'
limit 10; --

select count(*) from axispacs_snowflake.file_paths_and_meta --limit 10;
where file_path_coris like '%.dcm' and devname = 'HVF (x2) Cherry creek-Main'
limit 10; --0

select count(*) from axispacs_snowflake.file_paths_and_meta --limit 10;
where file_path_coris like '%.dcm' and devname = 'HVF'
limit 10; --0

-- Get Samples
select * from axispacs_snowflake.file_paths_and_meta --limit 10;
where file_path_coris like '%.dcm' and devname = 'HFA3 (x3)' and exdatetime > '2023-02-01 00:00:00' and ptsrno = 
limit 100; --

-- ptsrno: 
-- /data/PACS/DICOM/
-- /data/PACS/DICOM/
-- /data/PACS/DICOM/
-- /data/PACS/DICOM/
-- /data/PACS/DICOM/
-- /data/PACS/DICOM/

select * from axispacs_snowflake.files
where dicommodality = 'OPV'
order by dicomacquisitiondatetime
limit 10;

select * from axispacs_snowflake.file_paths_and_meta
where file_path_coris like '%'

select * from axispacs_snowflake.file_paths_and_meta --limit 10;
where file_path_coris like '%.dcm' and devname = 'HFA3 (x3)' and  and exdatetime < '2022-01-01 00:00:00'
limit 100; --


/* Individual Exploration of Error Case */
--------------
select * from axispacs_snowflake.files
where filenamenew = ''

Exam=''

select * from axispacs_snowflake.exams
where exsrno = 

examdevtype=''

select * from axispacs_snowflake.devices where devsrno = 
--------------
