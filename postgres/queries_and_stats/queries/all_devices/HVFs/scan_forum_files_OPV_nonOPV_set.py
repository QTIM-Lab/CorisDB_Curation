import os, pandas as pd, pydicom, pdb
import psycopg


DIR="/projects/coris_db/postgres/queries_and_stats/queries/all_devices/HVFs/scan_forum/scan_forum_2023_errored_out_195910_records.csv"
DIR="/projects/coris_db/postgres/queries_and_stats/queries/all_devices/HVFs/scan_forum/scan_forum_2023.csv"

scan_forum_csv = pd.read_csv(DIR)

scan_forum_csv.columns
vf_header = ['forum_file_path', 'patient', 'modality', 'sop_class_uid',
          'sop_class_printed', 'study_instance_uid', 'series_instance_uid',
          'sop_instance_uid', 'year']

VFs = scan_forum_csv[scan_forum_csv['sop_class_printed'] == '(0008, 0016) SOP Class UID                       UI: Ophthalmic Visual Field Static Perimetry Measurements Storage']

# Attach exam info
## Get exams
with psycopg.connect("dbname= user= password=") as conn:
    # Open a cursor to perform database operations
    with conn.cursor() as cur:
        # Execute a command: this creates a new table
        cur.execute("""
        SELECT column_name
        FROM information_schema.columns
        WHERE table_schema = 'axispacs_snowflake'
        AND table_name   = 'exams'
        """)
        rows = cur.fetchall()
        header = [i[0] for i in rows]
        # Pass data to fill a query placeholders and let Psycopg perform
        # the correct conversion (no SQL injections!)
        cur.execute("SELECT * FROM axispacs_snowflake.exams")
        rows = cur.fetchall()
        exams = pd.DataFrame(rows, columns=header)
        # You can use `cur.fetchmany()`, `cur.fetchall()` to return a list
        # Make the changes to the database persistent
        ## conn.commit()


## Join exams
exams[pd.isna(exams['dicomstudyinstanceuid'])]
exams[exams['dicomstudyinstanceuid'] == '']

VFs_Exams_left = pd.merge(VFs, exams, how="left", left_on="study_instance_uid", right_on="dicomstudyinstanceuid")
VFs_Exams_inner = pd.merge(VFs, exams, how="inner", left_on="study_instance_uid", right_on="dicomstudyinstanceuid")

VFs_Exams_inner
VFs_Exams_left[~pd.isna(VFs_Exams_left['dicomstudyinstanceuid'])][['forum_file_path','dicomstudyinstanceuid','exsrno','study_instance_uid']].iloc[0]
VFs_Exams_left[~pd.isna(VFs_Exams_left['dicomstudyinstanceuid'])][['dicomstudyinstanceuid','exsrno','study_instance_uid']+vf_header].iloc[0]['forum_file_path']
# VFs_Exams_left[pd.isna(VFs_Exams_left['dicomstudyinstanceuid'])][['dicomstudyinstanceuid','exsrno','study_instance_uid']+vf_header].iloc[0]['forum_file_path']

VFs_Exams[['dicomstudyinstanceuid','exsrno']+vf_header]


# Use this dicom to find all files and records associated with it
ds = pydicom.dcmread('/data/PACS/forum/2023/2/23/1.2.27....................dcm')
ds.get((0x0010, 0x0020)).value # patient -- ''
ds.get((0x0008, 0x0012)).value # instance_creation_date -- ''
ds.get((0x0008, 0x0060)).value # modality -- ''
ds.get((0x0008, 0x0016)).value # sop_class_uid -- ''
str(ds.get((0x0008, 0x0016))).split("UI:")[-1].strip() # sop_class_desc -- 'Ophthalmic Visual Field Static Perimetry Measurements Storage'
ds.get((0x0020, 0x000d)).value # study_instance_uid -- '1.2.276.0.75............'
ds.get((0x0020, 0x000e)).value # series_instance_uid -- '1.2.276.0.75............'
ds.get((0x0008, 0x0018)).value # sop_instance_uid -- '1.2.276.0.75............'

ls /data/PACS/forum/2023/2/23 | wc -l
ls /data/PACS/forum/2023/2/23 | grep 1.2.27............



# From HVF_axispacs_forum.md:
ds1 = pydicom.dcmread('/data/PACS/forum/2023/2/23/1.2...........dcm')
ds2 = pydicom.dcmread('/data/PACS/forum/2023/2/23/1.2...........dcm')
ds3 = pydicom.dcmread('/data/PACS/forum/2023/2/23/1.2...........dcm')
ds4 = pydicom.dcmread('/data/PACS/forum/2023/2/23/1.2...........dcm')
ds5 = pydicom.dcmread('/data/PACS/forum/2023/2/23/1.2...........dcm')
ds6 = pydicom.dcmread('/data/PACS/forum/2023/2/23/1.2...........dcm')
ds7 = pydicom.dcmread('/data/PACS/forum/2023/2/23/1.2...........dcm')

# SOP
ds1.get((0x0008, 0x0018)).value
ds2.get((0x0008, 0x0018)).value
ds3.get((0x0008, 0x0018)).value
ds4.get((0x0008, 0x0018)).value
ds5.get((0x0008, 0x0018)).value
ds6.get((0x0008, 0x0018)).value
ds7.get((0x0008, 0x0018)).value

# Class UID
str(ds1.get((0x0008, 0x0016))).split("UI:")[-1].strip()
str(ds2.get((0x0008, 0x0016))).split("UI:")[-1].strip()
str(ds3.get((0x0008, 0x0016))).split("UI:")[-1].strip()
str(ds4.get((0x0008, 0x0016))).split("UI:")[-1].strip()
str(ds5.get((0x0008, 0x0016))).split("UI:")[-1].strip()
str(ds6.get((0x0008, 0x0016))).split("UI:")[-1].strip()
str(ds7.get((0x0008, 0x0016))).split("UI:")[-1].strip()
