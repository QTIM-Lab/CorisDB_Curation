# bash
# eval $(pdm venv activate coris_db)
# pdm add <package name>

import pydicom, pdb, shutil
import pandas as pd, os

CSV_DIR="/projects/coris_db/postgres/important_queries_and_stats/queries/Glaucoma/Results_Snowflake_Queries"
INDEXED_GLAUCOMA_IMAGES_PATH = "/projects/coris_db/postgres/important_queries_and_stats/queries/Glaucoma/Indexed_Images"

files = pd.read_csv(os.path.join(CSV_DIR, "glaucoma_patients_dcm.csv"), quotechar='"')
# files.fillna('', inplace=True)
files.columns

VisupacImagesSLCE="/data/PACS/DICOM"
VisupacImagesGlaucoma="/data/PACS-Glaucoma/DICOM"
snowflake_path='\\\\uch.ad.pvt\\apps\\VisupacImages'

# Explore a bit
# files['F_FILENAME'][0]
# files['F_FILENAMENEW'][0]
# files['F_FILEPATH'][0]
# files['F_FILEPATHNEW'][0]
# For j2k files
# files['F_FILEPATHVisupac'] = files['F_FILEPATH'].str.replace(snowflake_path, VisupacImagesSLCE).str.replace('\\','/')
# Dicoms
files['F_FILEPATHVisupac'] = files.apply(lambda row: os.path.join(VisupacImagesSLCE, str(row['SF_PAT_PTSRNO']), str(row['F_EXSRNO']), row['F_FILENAMENEW']), axis=1)
# files['F_FILEPATHVisupac'][0]


# Copy images
def copy_image_from_VisupacsImagesSLCE_to_VisupacImagesGlaucoma(num_of_files_to_copy=10):
    copied = 0
    for file in files['F_FILEPATHVisupac']:
        if copied == 10:
            break
        orig = file
        dest = file.replace(VisupacImagesSLCE, VisupacImagesGlaucoma)        
        dest_folder = os.path.dirname(dest)
        if not os.path.exists(dest_folder):
            os.makedirs(dest_folder)
        shutil.copy(orig, dest)
        copied += 1
        # pdb.set_trace()
        
# copy_image_from_VisupacsImagesSLCE_to_VisupacImagesGlaucoma()

# Make Image Key
glaucoma_patient_images = pd.DataFrame(files['F_FILEPATHVisupac'])
glaucoma_patient_images['SOPInstanceUID'] = files['F_FILEPATHVisupac'].apply(os.path.basename).str.replace('.dcm','')
glaucoma_patient_images.to_csv(os.path.join(INDEXED_GLAUCOMA_IMAGES_PATH,"glaucoma_file_paths_dcm.csv"), index=None)