# CorisDB Curation

```bash
pyenv install 3.11.1
pyenv virtualenv 3.11.1 corisdb_curation
pyenv activate corisdb_curation
# poetry config virtualenvs.create false
# poetry config virtualenvs.in-project false
# poetry init # first time only
poetry install
```

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

We have an assortment of sources of electronic health records (EHR) and tabular data created from scans of images collected into a Postgres server with each source as it's own scheme.


* **CORISDB_REGISTRY** - Newest data and is from Google Big Query. It is hand crafted data exports from Compass and needs special approval. We have asked for specific tables and columns and are regularly delivered that data.
* **SOURCE** - Original data we recieved from Compass and is considered stale as we will not likely get more data in this format. We have moved to the CORISDB_REGISTRY format above but will keep for now as it overlaps with CORISDB_REGISTRY and is a good sanity check.
* **AXISPACS** - Current source of image specific information created for an app called AxisPACS. It has 5 tables:
    - devices - imaging device information  
    - exams - imaging exam info  
    - files - specific file level information  
    - patients - patient info  
    - store - location on Windows drives where info was stored and may still be  as we have a copy of that data(I think)  
* **COUCHDB** - Not too important right now but is a noSQL database and we were using it to store png renders of DICOMs with pixel data as well as the DICOM header in json queryable format.
* **ORTHANC** - A Medical DICOM PACS for serving DICOMs and comes with some handy viewers.
* **FORUM** - Datastore holding lots of Humphrey Visual Field scanner data. Holds Cirrus and IOL (Itraocular lense) surgery images (I believe). Most of these images were converted to j2ks or pdfs.
* **HEYEX** - Another repository of images like FORUM. 

### Archive
If you were here before June 2024 you likely were using the scripts in this folder. Eveything in the future should be moved to one of the IRB folders listed above. 

### Schemes

Login:  
* User ophuser  
* Pass: OOOp...........you know if you know  

```bash
psql -U ophuser coris_db
```

Look into the `CorisDB_Curation/Schemes` folder to find scripts related to specific schemes. Current scheme list (06_12_2024):

* **coris_registry** - Latest and greatest from Google Big Query 
* **source (empty)** - Older EHR data 
* **axispacs_snowflake** - As it sounds. Axispacs has ehr like tabular data and accompanying images. This is the database that links to those images. 
* **axispacs_dscan** - We used couchdb and pydicom to strip important DICOM tags for axispacs DICOMS and stored them in tabular format. `dscan` stands for directory scan.
* **coris_db** - Original source db. At the time we put all the datasource ideas as schemes. This is probably sub-optimal. Therefore we are  
* **forum_dscan** - We had no database for these images. All we have are the images which are DICOM. However we scanned the headers and extracted the  details into csvs which we imported to have something to grab onto. `dscan` stands for directory scan.
* **heyex** - "..." from forum description. Not available yet 
* **template0** - This comes with postgres and we don't need to worry about and should not touch  
* **template1** - This comes with postgres and we don't need to worry about and should not touch  
* **postgres** - This comes with postgres and we don't need to worry about and should not touch  

**Other Schemes Users Made and We Can't Verify its fidelity**:

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