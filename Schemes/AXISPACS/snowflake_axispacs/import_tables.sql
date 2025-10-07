-- Bulk Insert
\copy axispacs_snowflake.devices FROM '/scratch90/QTIM/Active/23-0284/EHR/SNOWFLAKE/devices.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;
\copy axispacs_snowflake.exams FROM '/scratch90/QTIM/Active/23-0284/EHR/SNOWFLAKE/exams.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;
\copy axispacs_snowflake.files FROM '/scratch90/QTIM/Active/23-0284/EHR/SNOWFLAKE/files.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;
\copy axispacs_snowflake.patients FROM '/scratch90/QTIM/Active/23-0284/EHR/SNOWFLAKE/patients.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;
\copy axispacs_snowflake.store FROM '/scratch90/QTIM/Active/23-0284/EHR/SNOWFLAKE/store.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;


-- Delete
delete from  axispacs_snowflake.device;
delete from  axispacs_snowflake.exams;
delete from  axispacs_snowflake.files;
delete from  axispacs_snowflake.patients;
delete from  axispacs_snowflake.store;


-- Counts
select count(*) from  axispacs_snowflake.devices; -- 
select count(*) from  axispacs_snowflake.exams; -- 
select count(*) from  axispacs_snowflake.files; -- 
select count(*) from  axispacs_snowflake.patients; -- 
select count(*) from  axispacs_snowflake.store; -- 