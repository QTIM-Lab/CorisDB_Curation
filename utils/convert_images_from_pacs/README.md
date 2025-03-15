# Convert PACS images to PNG or other human readable format

## DICOMParser (New)
```bash
pyenv activate corisdb_curation
# poetry install
cd utils/convert_images_from_pacs
git clone https://github.com/msaifee786/hvf_extraction_script.git
pip install hvf_extraction_script

python opvs.py
```


## Preview (old)

```bash
IN=
OUT=
python preview.py $IN $OUT
```

