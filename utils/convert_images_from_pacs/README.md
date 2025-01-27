# Convert PACS images to PNG or other human readable format
```bash
pyenv activate corisdb_curation
cd utils/convert_images_from_pacs
```

```bash
IN=/data/CorisDB_Curation/10_15_2024_finding_glaucoma/Data/92996_images/raw
OUT=/data/CorisDB_Curation/10_15_2024_finding_glaucoma/Data/92996_images/pngs_or_other
python preview.py $IN $OUT
```

