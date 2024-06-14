# SOURCE

## DBs
### Coris Registry from Google Big Query
```sql
CREATE DATABASE coris_registry;
DROP DATABASE coris_registry;
```

### Compass Electronic Health Records (SOURCE)
```sql
CREATE DATABASE source;
DROP DATABASE source;

```

### Axispacs Viewer Database (from Snowflake in Azure)
```sql
CREATE DATABASE axispacs;
DROP DATABASE axispacs;
```
  * snowflake schema
  * dscan scheme

### Forum Images Scanned
```sql
CREATE DATABASE forum;
DROP DATABASE forum;
```
  * dscan scheme

### Hyex Images Scanned
```sql
CREATE DATABASE heyex;
DROP DATABASE heyex;
```
  * dscan scheme

### Dashboard Database
```sql
CREATE DATABASE dashboard;
DROP DATABASE dashboard;
```

## Schemes
### Coris Registry from Google Big Query
To Do...

### Compass Electronic Health Records (SOURCE)
```sql
CREATE SCHEMA IF NOT EXISTS axispacs_snowflake;
CREATE SCHEMA IF NOT EXISTS axispacs_dscan;
CREATE SCHEMA IF NOT EXISTS forum_dscan;
CREATE SCHEMA IF NOT EXISTS glaucoma;
CREATE SCHEMA IF NOT EXISTS amd;
CREATE SCHEMA IF NOT EXISTS parkinsons;
CREATE SCHEMA IF NOT EXISTS dashboard;
CREATE SCHEMA IF NOT EXISTS compass;
CREATE SCHEMA IF NOT EXISTS coris_registry;
CREATE SCHEMA IF NOT EXISTS amd_epidemiology;
```

#### Source data (SOURCE)
Notes:  
* John Finigan moved the data to my home dir: /home/bearceb. I moved to ISILON:QTIM/Raw-Data/EHR/SOURCE
* SOURCE Registry Local Users.xlsx - database scheme
* There is a problem with the files natively where I think line endings somewhere are "CRLF" vs "LF" which is a Windows\Linux,Mac config.

#### Code Scripts
* Below are scripts to help with import to postgres (`CorisDB_Curation/Databases/SOURCE`):
  * **table_def_orig_csvs**
    - csvs from above file representing the data found in the tabs
    - create_tables.sql 
  * **convert_types_and_create_data.py**
    - Uses table_def_orig_csvs to make the create_tables.sql script
    - Creates sample data for test import at sample_data
  * **make_postgres_importable_files.py**
    - CRLF versus LF discrepancies causeing import errors. Will make temporary version of files that can be imported.
    - This will be in folder "tmp_for_import"
  * **sample_data**
    - sample csvs for import
    - programmatically created sql to create tables and import data


### Axispacs Viewer Database (from Snowflake in Azure)
To Do...


### Forum Images Scanned
To Do...

### Hyex Images Scanned
To Do...


## Appendix:
Some useful tid bits:
```sql
-- Alter database owner
ALTER DATABASE coris_db owner to ophuser;

/* Misc server side edits and commands
-- edited: sudo vim /etc/postgresql/15/main/pg_hba.conf to add ophuser to coris_db on line 93.
-- ran: sudo service postgresql restart
-- login
psql -U ophuser coris_db
/*
-- ALTER SCHEMA ehr RENAME TO compass;
-- DROP SCHEMA IF EXISTS glaucoma;
---- ALTER TABLE public.OphthalmologyDiagnosesDm SET SCHEMA compass;
```


