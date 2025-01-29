# SOURCE

## SCHEMA
```sql
CREATE SCHEMA IF NOT EXISTS source;
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





