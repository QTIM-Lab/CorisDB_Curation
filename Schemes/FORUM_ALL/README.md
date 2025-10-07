# Forum All Images Scanned

## SCHEMA
```sql
CREATE SCHEMA IF NOT EXISTS forum_all;
```


## Python env
```bash
. ~/.bashrc
pyenv virtualenvs
pyenv deactivate
pyenv activate corisdb_curation
```



## Raw Data
Comes from
* /persist/PACS/forum_all
  - DICOMs - 37,640
  - BMPs - 0
  - XMLs - 0
  - PNGs - 0
  - J2Ks - 0

```bash
OUT=/scratch90/QTIM/Active/23-0284/EHR/FORUM_ALL
IN=/persist/PACS/forum_all
mkdir -p $OUT/raw_files_lists

# dcm
echo "file_path" > $OUT/raw_files_lists/forum_all_preview_dcm_files.csv
find $IN -iname "*.dcm" >> $OUT/raw_files_lists/forum_all_preview_dcm_files.csv

# j2k
echo "file_path" > $OUT/raw_files_lists/forum_all_preview_j2k_files.csv
find $IN -iname "*.j2k" >> $OUT/raw_files_lists/forum_all_preview_j2k_files.csv

# bmp
echo "file_path" > $OUT/raw_files_lists/forum_all_preview_bmp_files.csv
find $IN -iname "*.bmp" >> $OUT/raw_files_lists/forum_all_preview_bmp_files.csv

# xml
echo "file_path" > $OUT/raw_files_lists/forum_all_preview_xml_files.csv
find $IN -iname "*.xml" >> $OUT/raw_files_lists/forum_all_preview_xml_files.csv

# png
echo "file_path" > $OUT/raw_files_lists/forum_all_preview_png_files.csv
find $IN -iname "*.png" >> $OUT/raw_files_lists/forum_all_preview_png_files.csv
```


### DICOMS in parallel
Scans dicom headers
> Should adjust to read csv file like xml parser below
```bash
python CorisDB_Curation/Schemes/parse_dicom_for_postgres_parallel.py \
    --dicom_in $OUT/raw_files_lists/forum_all_preview_dcm_files.csv \
    --out $OUT/parsed/forum_all_parse_dicom_for_postgres.csv \
    --series
    --range 10 \