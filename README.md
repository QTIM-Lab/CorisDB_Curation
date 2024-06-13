# CorisDB Curation

```bash
pyenv virtualenv 3.11.1 corisdb_curation
pyenv activate corisdb_curation
# poetry init # first time only
poetry install
```

## Overview

### IRBs
We need to collect data according to these IRBs
* 22-2198-AMD
* 23-0663-GLAUCOMA
* 23-1641-CATARACT
* 23-1818-PARKINSONS
* 23-0284-CORIS
* 23-1594-ROP
* 23-1643-DRY-EYE

### Databases

We have an assortment of sources of electronic health records (EHR) and tabular data created from scans of images collected into a Postgres server with each source as it's own database.

Look into the `CorisDB_Curation/Databases` folder to find these:

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

### Postgres

