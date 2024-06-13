# Dicom file from forum
```python
ds = pydicom.dcmread('')
ds.get((0x0010, 0x0020)).value # patient -- ''
ds.get((0x0008, 0x0060)).value # modality -- ''
ds.get((0x0008, 0x0016)).value # sop_class_uid -- ''
str(ds.get((0x0008, 0x0016))).split("UI:")[-1].strip() # sop_class_desc -- 'Ophthalmic Visual Field Static Perimetry Measurements Storage'
ds.get((0x0020, 0x000d)).value # study_instance_uid -- ''
ds.get((0x0020, 0x000e)).value # series_instance_uid -- ''
ds.get((0x0008, 0x0018)).value # sop_instance_uid -- ''
```
# Look in axis pacs
```sql
-- can't find forum file instance uid but can find study id in exams.
select * from axispacs_snowflake.file_paths_and_meta
where file_path_coris = '%%'; -- can't find
select * from axispacs_snowflake.files
where dicomsopinstanceuid = ''; -- can't find

select * from axispacs_snowflake.exams
where dicomstudyinstanceuid = ''
   or exid = ''; -- found

-- Exam: 585683

select * from axispacs_snowflake.files
where exsrno = 
```

# Look for part of file name in forum to see all potential files:
```bash
ls /data/PACS/forum/2023/2/23 | grep 1.2.276......................


# SOPClass: Ophthalmic Visual Field Static Perimetry Measurements Storage

```

# Make exam set for exploring
```bash
cp /data/PACS/forum/2023/2/23/1.2.276.0.75.2.............dcm /projects/coris_db/postgres/queries_and_stats/queries/all_devices/HVFs/preview/raw/
cp /data/PACS/forum/2023/2/23/1.2.276.0.75.2.............dcm /projects/coris_db/postgres/queries_and_stats/queries/all_devices/HVFs/preview/raw/
cp /data/PACS/forum/2023/2/23/1.2.276.0.75.2.............dcm /projects/coris_db/postgres/queries_and_stats/queries/all_devices/HVFs/preview/raw/
cp /data/PACS/forum/2023/2/23/1.2.276.0.75.2.............dcm /projects/coris_db/postgres/queries_and_stats/queries/all_devices/HVFs/preview/raw/
cp /data/PACS/forum/2023/2/23/1.2.276.0.75.2.............dcm /projects/coris_db/postgres/queries_and_stats/queries/all_devices/HVFs/preview/raw/
cp /data/PACS/forum/2023/2/23/1.2.276.0.75.2.............dcm /projects/coris_db/postgres/queries_and_stats/queries/all_devices/HVFs/preview/raw/
cp /data/PACS/forum/2023/2/23/1.2.276.0.75.2.............dcm /projects/coris_db/postgres/queries_and_stats/queries/all_devices/HVFs/preview/raw/
```