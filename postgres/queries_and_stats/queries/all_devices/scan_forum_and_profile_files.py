import os, pandas as pd, pydicom, pdb

DIR="/data/PACS/forum"
OUT="/projects/coris_db/postgres/queries_and_stats/queries/all_devices/scan_forum"

# Looking for:
## (0010, 0020) Patient ID
## (0008, 0060) Modality                            CS: 
## (0008, 0016) SOP Class UID - UI: Encapsulated PDF Storage
## (0020, 000d) Study Instance UID                  UI: 
## (0020, 000e) Series Instance UID                 UI: 
## (0008, 0018) SOP Instance UID                    UI: 


forum_profile = pd.DataFrame({"forum_file_path":[],
                              "year":[],
                              "patient":[],
                              "modality":[],
                              "sop_class_uid":[],
                              "sop_class_printed":[],
                              "study_instance_uid":[],
                              "series_instance_uid":[],
                              "sop_instance_uid":[],
                              })

processed = 0
processed_list = []
year = 2023
for root, dirs, files in os.walk(os.path.join(DIR,str(year)), topdown=False):
    files_filtered = [i for i in files if i[0] != "."]
    for name in files_filtered:
        # pdb.set_trace()
        processed += 1
        pdb.set_trace()
        try:
            ds = pydicom.dcmread(os.path.join(root, name))
            record = {"forum_file_path":[os.path.join(root, name)],
                    "year":[year],
                    "patient":[ds.get((0x0010, 0x0020)).value],
                    "modality":[ds.get((0x0008, 0x0060)).value],
                    "sop_class_uid":[ds.get((0x0008, 0x0016)).value],
                    "sop_class_printed":[str(ds.get((0x0008, 0x0016)))],
                    "study_instance_uid":[ds.get((0x0020, 0x000d)).value],
                    "series_instance_uid":[ds.get((0x0020, 0x000e)).value],
                    "sop_instance_uid":[ds.get((0x0008, 0x0018)).value],
                    }
        except:
            print("Tag retrieval error!\n\n")
            pdb.set_trace()
        record_df = pd.DataFrame(record)
        forum_profile = pd.concat([forum_profile, record_df], axis=0)
        processed_list.append(os.path.join(root, name))
        if processed % 100 == 0:
            print(f"processed: {processed}")
        if processed % 10000 == 0:
            print(f"processed: {processed}")
            forum_profile.to_csv(os.path.join(OUT, f"scan_forum_{year}.csv"), index=False)
            # pdb.set_trace()




