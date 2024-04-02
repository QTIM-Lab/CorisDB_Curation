-- Bulk Insert
\copy axispacs_snowflake.devices FROM '/data/Snowflake_AxisPACS/devices.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;
\copy axispacs_snowflake.exams FROM '/data/Snowflake_AxisPACS/exams.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;
\copy axispacs_snowflake.files FROM '/data/Snowflake_AxisPACS/files.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;
\copy axispacs_snowflake.patients FROM '/data/Snowflake_AxisPACS/patients.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;
\copy axispacs_snowflake.store FROM '/data/Snowflake_AxisPACS/store.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;


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