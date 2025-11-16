# AXISPACS DATA

## Python env
```bash
. ~/.bashrc
# pyenv virtualenvs
pyenv deactivate
pyenv activate corisdb_curation
```

## Raw Data
Comes from
* /persist/PACS/VisupacImages
  - XMLs - 14,407,580 # These roughly go together one to one
  - J2Ks - 14,474,611 # These roughly go together one to one
  - DICOMs - 5,353 - Not sure what these are yet
Ex:
```bash
ls /persist/PACS/VisupacImages/1/1/
# Output
# AxisUCH01_1_1_20120807111955168aead4c94f1e7565f.j2k
# AxisUCH01_1_1_20120807111955168aead4c94f1e7565f.xml
```

* /persist/PACS/DICOM
  - J2Ks - 884,945 - these go with DICOMs below and seem to be previews (pdf pages mostly)
  - DICOMs - 1,214,811
  - XMLs - 0
Ex:
```bash
ls /persist/PACS/DICOM/10896/371560/
# Output
# 1.2.276.0.75.2.5.80.25.3.200903095304980.345051356800.1869673671-1.j2k
# 1.2.276.0.75.2.5.80.25.3.200903095304980.345051356800.1869673671.dcm
```

Working area:
```bash
OUT=/scratch90/QTIM/Active/23-0284/EHR/AXISPACS
```
## /persist/PACS/VisupacImages - from Axispacs raw data
Generates raw all files found for different extensions
```bash
IN=/persist/PACS/VisupacImages
echo "file_path" > $OUT/raw_files_lists/VisupacImages_preview_xml_files.csv
find $IN -iname "*.xml" >> $OUT/raw_files_lists/VisupacImages_xml_files.csv

echo "file_path" > $OUT/raw_files_lists/VisupacImages_j2k_files.csv
find $IN -iname "*.j2k" >> $OUT/raw_files_lists/VisupacImages_j2k_files.csv

echo "file_path" > $OUT/raw_files_lists/VisupacImages_dcm_files.csv
find $IN -iname "*.dcm" >> $OUT/raw_files_lists/VisupacImages_dcm_files.csv
```

## /persist/PACS/DICOM - from Axispacs raw data
Generates raw all files found for different extensions
```bash
IN=/persist/PACS/DICOM
echo "file_path" > $OUT/raw_files_lists/DICOM_xml_files.csv
find $IN -iname "*.xml" >> $OUT/raw_files_lists/DICOM_xml_files.csv

echo "file_path" > $OUT/raw_files_lists/DICOM_j2k_files.csv
find $IN -iname "*.j2k" >> $OUT/raw_files_lists/DICOM_j2k_files.csv

echo "file_path" > $OUT/raw_files_lists/DICOM_dicom_files.csv
find $IN -iname "*.dcm" >> $OUT/raw_files_lists/DICOM_dcm_files.csv
```


### DICOMS in parallel
Scans dicom headers
> Should adjust to read csv file like xml parser below
```bash
python CorisDB_Curation/Schemes/parse_dicom_for_postgres_parallel.py \
    --dicom_in $OUT/raw_files_lists/DICOM_dcm_files.csv \
    --out $OUT/parsed/DICOM_parse_dicom_for_postgres_debug.csv \
    --range 1 \
    --series

python CorisDB_Curation/Schemes/parse_dicom_for_postgres_parallel.py \
    --dicom_in $OUT/raw_files_lists/VisupacImages_dcm_files.csv \
    --out $OUT/parsed/VisupacImages_parse_dicom_for_postgres.csv # \
    # --range 100000
    # --series \
```


### XMLs in parallel
Scans xml files from a csv as a listed input
```bash
# in series for debugging slower
python CorisDB_Curation/Schemes/read_xml_parallel.py \
    --xml_path '/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/visupac_preview_xml_files.csv' \
    --out '/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/parsed/VisupacImages_XMLs.csv'
    --edit # \
    # --range 10
    # --series \
```

## Final Clean Up and Consolidation

What we need:
* raw files lists:
  - VisupacImages_xmls_files.csv
  - VisupacImages_j2ks_files.csv
  - VisupacImages_dcm_files.csv
  - DICOM_xml_files.csv - no files
  - DICOM_j2k_files.csv
  - DICOM_dcm_files.csv
* parsed:
  - DICOMs:
    * DICOM_parse_dicom_for_postgres.csv
    * VisupacImages_parse_dicom_for_postgres.csv
  - VisupacImages:
    * VisupacImages_XMLs.csv - all
    * VisupacImages_XMLs_int_pids.csv - pids that can be parsed as int
    * VisupacImages_XMLs_problem_pids.csv - pids that cannot be parsed as int
* curated tables:
  - `all_dicoms` = *VisupacImages_parse_dicom_for_postgres.csv* + *DICOM_parse_dicom_for_postgres.csv*
    * From *VisupacImages_dcm_files.csv* and *DICOM_dcm_files.csv*.
    * Create `basename` file name col for joins and make sure to trim patterns like `.dcm`
  - `all_xmls` - *VisupacImages_XMLs.csv* - parsed xmls from *VisupacImages_xmls_files.csv*
    * Create `basename` file name col for joins and make sure to trim patterns like `.xml` and `.XML`
  - `all_j2ks`
    * j2k and xml matches: look up each j2k from *VisupacImages_j2ks_files.csv* in `all_xmls` and get metadata
      - Create `basename` file name col for joins and make sure to trim patterns like `.j2k`, `.J2K`, etc.
    * j2k and dicom matches: look up each j2k from *DICOM_j2k_files.csv* in `all_dicoms` and get metadata
      - Create `basename` file name col for joins and make sure to trim patterns like `-1.j2k`, `-2.j2k`, `-1.J2K`, `-2.J2K`, etc.
    * create merge with superset of dicom and xml columns that could have either or both source column data (ie dicom info and xml info) as well as orphans with neither
  - `all_files`: holy grail
    * `all_dicoms` and `all_j2ks` have to be merged 



Use this script like a jupyter notebook (not to be run all at once but methodically line by line):
`/scratch90/QTIM/Active/23-0284/EHR/CorisDB_Curation/Schemes/AXISPACS/clean_up.py`

## SOClassUID Description
Add this as it is not in the dicoms themselves:
`/scratch90/QTIM/Active/23-0284/EHR/CorisDB_Curation/Schemes/add_sopclass_description.py`

We need to do this for dicom files so that we aren't dealing with things like `1.2.840.10008.5.1.4.1.1.77.1.5.1` but rather `Ophthalmic Photography 8 Bit Image Storage`


## Image Classifications
> `/scratch90/QTIM/Active/23-0284/EHR/AXISPACS`
* image classification for cohort identification
  - `dicom_image_types`:
    * axispacs_image_types_dicom_manually_curated.csv - manually curated image classifications for creating cohorts
  - `j2k_image_types`:
    * axispacs_image_types_j2k_manually_curated.csv - manually curated image classifications for creating cohorts


Count of images by critical feature columns
* `/scratch90/QTIM/Active/23-0284/EHR/CorisDB_Curation/Schemes/AXISPACS/axispacs/row_counts_by_column_types_for_dicom.py`
* `/scratch90/QTIM/Active/23-0284/EHR/CorisDB_Curation/Schemes/AXISPACS/axispacs/row_counts_by_column_types_for_j2k.py`

After prioritizing images with higher occurence we manually opened and classified them to create a key. Using this key we create key map tables for the critical features.
* `/scratch90/QTIM/Active/23-0284/EHR/CorisDB_Curation/Schemes/AXISPACS/axispacs/create_classification_categories.py`

