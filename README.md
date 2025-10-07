# CorisDB Curation


## Overview

### IRBs
We need to collect data according to these IRBs. Therefore we use the below IRB folders and projects within to organize our scripts:  
* 22-2198-AMD  
* 23-0663-GLAUCOMA  
* 23-1641-CATARACT  
* 23-1818-PARKINSONS  
* 23-0284-CORIS  
* 23-1594-ROP  
* 23-1643-DRY-EYE  

### Data and Datastores
We have an assortment of sources of electronic health records (EHR) and tabular data created from scans of images collected into a Postgres server with each source as it's own Schema.


* **CORISDB_REGISTRY** - Newest data and is from Google Big Query. It is hand crafted data exports from Compass and needs special approval. We have asked for specific tables and columns and are regularly delivered that data.
* **SOURCE** - Original data we recieved from Compass and is considered stale as we will not likely get more data in this format. We have moved to the CORISDB_REGISTRY format above but will keep for now as it overlaps with CORISDB_REGISTRY and is a good sanity check.
* **AXISPACS** - Current source of image specific information created for an app called AxisPACS. It has 5 tables:
    - devices - imaging device information  
    - exams - imaging exam info  
    - files - specific file level information  
    - patients - patient info  
    - store - location on Windows drives where info was stored and may still be  as we have a copy of that data(I think)  
* **FORUM** - Datastore holding lots of Humphrey Visual Field scanner data. Holds Cirrus and IOL (Itraocular lense) surgery images (I believe). Most of these images were converted to j2ks or pdfs.
* **HEYEX** - Another repository of images like FORUM. 
* **IMAGEPOOLS** - Another repository of images like FORUM. 

### Schemas
* public:
  - This schema is used for general-purpose data where both `coris_admin` and `coris_user` require full read/write access.
* coris_registry:
  - This schema is used for more restricted data where `coris_admin` has full control, and `coris_user` has read-only access.
* axispacs_snowflake: Imaging data from snowflake at CU in the cloud
* axispacs_dscan: DICOM headers striped from scanned files in axispacs directory


```bash
psql -U ophuser coris_db
psql -U coris_admin coris_db
psql -U coris_user coris_db
```

#### Create Users
Grant Database-Level Admin Rights:
```sql
CREATE USER coris_admin WITH PASSWORD '';
GRANT CONNECT ON DATABASE coris_db TO coris_admin;
GRANT CONNECT ON DATABASE postgres TO coris_admin;
GRANT ALL PRIVILEGES ON DATABASE coris_db TO coris_admin;
-- Grant Role Creation
ALTER USER coris_admin WITH CREATEROLE;
```

```sql
CREATE USER coris_user WITH PASSWORD '';
GRANT CONNECT ON DATABASE coris_db TO coris_user;
GRANT CONNECT ON DATABASE postgres TO coris_user;
```

#### Admin User Settings
Schema public:
```sql
-- current
GRANT USAGE, CREATE ON SCHEMA public TO coris_admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO coris_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO coris_admin;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO coris_admin;
-- future
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO coris_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO coris_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO coris_admin;
```

Schema coris_registry:
```sql
-- Do as coris_admin
psql -U coris_admin coris_db
```

```sql
-- DROP SCHEMA IF EXISTS coris_registry CASCADE;
CREATE SCHEMA IF NOT EXISTS coris_registry AUTHORIZATION coris_admin;
ALTER SCHEMA coris_registry OWNER TO coris_admin;
-- current
GRANT USAGE ON SCHEMA coris_registry TO coris_admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA coris_registry TO coris_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA coris_registry TO coris_admin;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA coris_registry TO coris_admin;
-- future
ALTER DEFAULT PRIVILEGES IN SCHEMA coris_registry GRANT ALL ON TABLES TO coris_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA coris_registry GRANT ALL ON SEQUENCES TO coris_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA coris_registry GRANT ALL ON FUNCTIONS TO coris_admin;

-- (Subtle but apparently key) Ensure future tables created by coris_admin grant SELECT to coris_user
ALTER DEFAULT PRIVILEGES FOR USER coris_admin IN SCHEMA coris_registry 
GRANT SELECT ON TABLES TO coris_user;
```

Schema axispacs_snowflake:
```sql
-- Do as coris_admin
psql -U coris_admin coris_db
```
```sql
-- DROP SCHEMA IF EXISTS axispacs_snowflake CASCADE;
CREATE SCHEMA IF NOT EXISTS axispacs_snowflake AUTHORIZATION coris_admin;
ALTER SCHEMA axispacs_snowflake OWNER TO coris_admin;
-- current
GRANT USAGE ON SCHEMA axispacs_snowflake TO coris_admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA axispacs_snowflake TO coris_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA axispacs_snowflake TO coris_admin;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA axispacs_snowflake TO coris_admin;
-- future
ALTER DEFAULT PRIVILEGES IN SCHEMA axispacs_snowflake GRANT ALL ON TABLES TO coris_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA axispacs_snowflake GRANT ALL ON SEQUENCES TO coris_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA axispacs_snowflake GRANT ALL ON FUNCTIONS TO coris_admin;

-- (Subtle but apparently key) Ensure future tables created by coris_admin grant SELECT to coris_user
ALTER DEFAULT PRIVILEGES FOR USER coris_admin IN SCHEMA axispacs_snowflake 
GRANT SELECT ON TABLES TO coris_user;
```

#### Regular User Settings
Schema public:
```sql
-- current
GRANT USAGE, CREATE ON SCHEMA public TO coris_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO coris_user;
-- future
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO coris_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT EXECUTE ON FUNCTIONS TO coris_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT ON SEQUENCES TO coris_user;
```

Schema coris_registry:
```sql
-- current
GRANT USAGE ON SCHEMA coris_registry TO coris_user;
REVOKE CREATE ON SCHEMA coris_registry FROM coris_user;
GRANT SELECT ON ALL TABLES IN SCHEMA coris_registry TO coris_user;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA coris_registry TO coris_user;
-- future
ALTER DEFAULT PRIVILEGES IN SCHEMA coris_registry GRANT SELECT ON TABLES TO coris_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA coris_registry GRANT EXECUTE ON FUNCTIONS TO coris_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA coris_registry GRANT USAGE, SELECT ON SEQUENCES TO coris_user;
```

Schema axispacs_snowflake:
```sql
-- current
GRANT USAGE ON SCHEMA axispacs_snowflake TO coris_user;
GRANT SELECT ON ALL TABLES IN SCHEMA axispacs_snowflake TO coris_user;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA axispacs_snowflake TO coris_user;
-- future
ALTER DEFAULT PRIVILEGES IN SCHEMA axispacs_snowflake GRANT SELECT ON TABLES TO coris_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA axispacs_snowflake GRANT EXECUTE ON FUNCTIONS TO coris_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA axispacs_snowflake GRANT USAGE, SELECT ON SEQUENCES TO coris_user;
```

Delete user:
```sql
REASSIGN OWNED BY coris_admin TO postgres;
DROP OWNED BY coris_admin;
DROP ROLE coris_admin;
REASSIGN OWNED BY coris_user TO postgres;
DROP OWNED BY coris_user;
DROP ROLE coris_user;
```

Look into the `CorisDB_Curation/Schemas` folder to find scripts related to specific Schemas. Current Schema list (06_12_2024):

* **coris_registry** - Latest and greatest from Google Big Query 
* **source (empty)** - Older EHR data 
* **axispacs_snowflake** - As it sounds. Axispacs has ehr like tabular data and accompanying images. This is the database that links to those images. 
* **axispacs** - We used couchdb and pydicom to strip important DICOM tags for axispacs DICOMS and stored them in tabular format. `dscan` stands for directory scan.
* **coris_db** - Original source db. At the time we put all the datasource ideas as Schemas. This is probably sub-optimal. Therefore we are  
* **forum** - We had no database for these images. All we have are the images which are DICOM. However we scanned the headers and extracted the  details into csvs which we imported to have something to grab onto. `dscan` stands for directory scan.
* **heyex** - Same as forum_dscan for folder /persist/PACS/RMLEI-Hyex-Spectralis-data 
* **imagepools** - Same as forum_dscan for folder /persist/PACS/imagepools
* **template0** - This comes with postgres and we don't need to worry about and should not touch  
* **template1** - This comes with postgres and we don't need to worry about and should not touch  
* **postgres** - This comes with postgres and we don't need to worry about and should not touch  

**Other Schemas Users Made and We Can't Verify its fidelity**:

* **amd**
* **amd_epidemiology**
* **glaucoma**
* **parkinsons**

### GUIS
Advaith Veturi has made some visualization tools


### Notebooks
Advaith Veturi has made some notebooks


### Utils
Utility scripts to preview images or do other nifty things


### Appendix
Some useful tid bits or old things I wasn't ready to get rid of just yet:
```sql
-- CREATE SCHEMA IF NOT EXISTS glaucoma -- later...or maybe never;
-- CREATE SCHEMA IF NOT EXISTS amd -- later...or maybe never;
-- CREATE SCHEMA IF NOT EXISTS parkinsons -- later...or maybe never;
-- CREATE SCHEMA IF NOT EXISTS dashboard -- later...or maybe never;
-- CREATE SCHEMA IF NOT EXISTS compass -- later...or maybe never;
-- CREATE SCHEMA IF NOT EXISTS amd_epidemiology -- later...or maybe never;

-- Alter database owner
-- ALTER DATABASE coris_db owner to ophuser;

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