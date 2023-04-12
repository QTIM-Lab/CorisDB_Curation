# CORIS DB

## DB
### Make new DB
```sql
-- Create a new DB
CREATE DATABASE coris_db;

-- Alter database owner
ALTER DATABASE coris_db owner to ophuser;

/* Misc server side edits and commands
-- edited: sudo vim /etc/postgresql/15/main/pg_hba.conf to add ophuser to coris_db on line 93.
-- ran: sudo service postgresql restart
-- login
psql -U ophuser coris_db

/*
```

### Make new Scheme for new tables
```sql
CREATE SCHEMA IF NOT EXISTS glaucoma;
CREATE SCHEMA IF NOT EXISTS amd;
CREATE SCHEMA IF NOT EXISTS parkinsons;

-- DROP SCHEMA IF EXISTS glaucoma;
-- DROP SCHEMA IF EXISTS amd;
-- DROP SCHEMA IF EXISTS parkinsons;


```


## Source data (SOURCE)
* John Finigan moved the data to my home dir: /home/bearceb. I need to move it to it's main spot /data/coris_db
* sudo ls /data/coris_db gives permission denied so we can do that later.
* There is a problem with the files natively where I think line endings somewhere are "CRLF" vs "LF" which is a Windows\Linux,Mac config.

## Code
Code for table loading and scheme creation located here: /projects/coris_db currently /projects/CORIS_DB

* initial_psql_scripts.sql
  - creates database coris_db
  - changes owner
  - makes config edits to allow ophuser to login to coris_db
* SOURCE Registry Local Users.xlsx - database scheme
* table_def_orig_csvs
  - csvs from above file representing the data found in the tabs
  - create_tables.sql 
* convert_types_and_create_data.py
  - Uses table_def_orig_csvs to make the create_tables.sql script
  - Creates sample data for test import at sample_data
* make_postgres_importable_files.py
  - CRLF versus LF discrepancies causeing import errors. Will make temporary version of files that can be imported.
  - This will be in folder "tmp_for_import"
* sample_data
  - sample csvs for inmport

Project dependency management:
* pyproject.toml
* pdm.lock
* .pdm.toml 
