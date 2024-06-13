import os, shutil, pandas as pd, pydicom, pdb
from PIL import Image, ImageDraw, ImageFont


IN="/projects/coris_db/postgres/queries_and_stats/queries/all_devices/all_devices_1_each.csv"
RAW="/projects/coris_db/postgres/queries_and_stats/queries/all_devices/preview/raw"

all_devices_1_each=pd.read_csv(IN)

all_devices_1_each.columns
header=[['file_path_coris', 'exdevtype', 'exsrno', 'ptsrno', 'devname',
       'devdescription', 'devtype', 'devproc', 'dicomaetitle', 'devsrno']]

# file_name = all_devices_1_each['file_path_coris'].iloc[0]

list_of_not_found_images = []
for file_name in all_devices_1_each['file_path_coris']:
    try:
        shutil.copy(file_name, RAW)
    except:
        list_of_not_found_images.append(file_name)


# list_of_not_found_images:
# ['']