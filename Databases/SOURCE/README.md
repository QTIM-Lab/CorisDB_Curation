# SOURCE

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

-- ALTER SCHEMA compass RENAME TO ehr;
-- ALTER SCHEMA ehr RENAME TO compass;

-- DROP SCHEMA IF EXISTS glaucoma;
-- DROP SCHEMA IF EXISTS amd;
-- DROP SCHEMA IF EXISTS parkinsons;
-- DROP SCHEMA IF EXISTS axispacs_snowflake
-- DROP SCHEMA IF EXISTS compass

---- ALTER TABLE public.OphthalmologyDiagnosesDm SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyProviderAll SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyRadiology SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyEncounterVisit SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyFamilyHistory SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyPatientDiagnoses SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologySurgeryAll SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyImplant SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyCurrentMedications SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologySupplyDm SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyImplantDm SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologySurgeryProcedure SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyEncounterCharge SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologySurgeryMedication SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologySurgerySurgeon SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyEncounterExam SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyEncounters SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyVisitSummary SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologySurgery SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyOrders SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyMedicationDm SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyLabOrder SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyMedications SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologySurgeryBill SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologySupply SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyProviderDm SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyEncounterProblemList SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyLabs SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyPatients SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologySurgeryDm SET SCHEMA compass;
---- ALTER TABLE public.OphthalmologyEncounterDiagnoses SET SCHEMA compass;

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
