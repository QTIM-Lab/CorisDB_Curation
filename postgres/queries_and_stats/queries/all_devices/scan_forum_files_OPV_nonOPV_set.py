import os, pandas as pd, pydicom, pdb
import psycopg


DIR="/projects/coris_db/postgres/queries_and_stats/queries/all_devices/scan_forum/scan_forum_2023_errored_out_195910_records.csv"

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
