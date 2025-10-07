import os, pandas as pd, pydicom, pdb, numpy, json

forum = "/projects/coris_db/postgres/queries_and_stats/queries/all_devices/HVFs/scan_forum/scan_forum_2023.csv"

forum_df = pd.read_csv(forum)
forum_df.columns
Index(['forum_file_path', 'year', 'patient', 'modality', 'sop_class_uid',
       'sop_class_printed', 'study_instance_uid', 'series_instance_uid',
       'sop_instance_uid'],
      dtype='object')

forum_df[forum_df['patient'] == ]
forum_df[forum_df['forum_file_path'].str.find('/data/PACS/forum/2023/8/30') != -1]
forum_df.sort_values('forum_file_path')