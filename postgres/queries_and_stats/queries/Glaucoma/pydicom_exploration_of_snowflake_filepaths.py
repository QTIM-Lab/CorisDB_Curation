# bash
# eval $(pdm venv activate coris_db)
# pdm add <package name>

import pydicom, pdb, shutil
import pandas as pd, os

CSV_DIR="/projects/coris_db/postgres/important_queries_and_stats/queries/Glaucoma/Results_Snowflake_Queries"
files = pd.read_csv(os.path.join(CSV_DIR, "glaucoma_patients_dcm.csv"), quotechar='"')
# files.fillna('', inplace=True)
files.columns

VisupacImagesSLCE="/data/PACS/DICOM"
VisupacImagesGlaucoma="/data/PACS-Glaucoma/DICOM"
snowflake_path='\\\\uch.ad.pvt\\apps\\VisupacImages'
index_images = "/projects/coris_db/postgres/important_queries_and_stats/queries/Glaucoma/Indexed_Images"

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

keep = ['G_PAT_MRN', 'E_PTSRNO', 'F_EXSRNO', 'F_FILENAMENEW',
        'E_EXDATETIME', 'F_FILEPATHVisupac']
new_names = {'G_PAT_MRN': 'MRN',
             'E_PTSRNO': 'PTSRNO',
             'F_EXSRNO': 'EXSRNO',
             'F_FILENAMENEW': 'SOPInstance',
             'E_EXDATETIME': 'EXDATETIME',
             'F_FILEPATHVisupac': 'FILEPATHVisupac',
             }
indexed_glaucoma = files[keep]
indexed_glaucoma.rename(columns=new_names, inplace=True)
indexed_glaucoma.head()

# indexed_glaucoma[indexed_glaucoma['Modality'] == 'Not Found']['FILEPATHVisupac'].iloc[0]
# indexed_glaucoma[indexed_glaucoma['FILEPATHVisupac'] == '']

DICOM_TAGS_OF_INTEREST={
    # File Meta - Meta header in Orthanc
    'MediaStorageSOPClassUID':{'tag':(0x0002, 0x0002), 'type':'file_meta'},
    # Dataset
    'AcquisitionDateTime':{'tag':(0x0008, 0x002a), 'type':'dataset'},
    'BitsAllocated':{'tag':(0x0028, 0x0100), 'type':'dataset'},
    'ImageType':{'tag':(0x0008, 0x0008), 'type':'dataset'},
    'InstitutionName':{'tag':(0x0008, 0x0080), 'type':'dataset'},
    'ImageLaterality':{'tag':(0x0020, 0x0062), 'type':'dataset'},
    'Laterality':{'tag':(0x0020, 0x0060), 'type':'dataset'},
    'Manufacturer':{'tag':(0x0008, 0x0070), 'type':'dataset'},
    'ManufacturerModelName':{'tag':(0x0008, 0x1090), 'type':'dataset'},
    'MIMETypeOfEncapsulatedDocument':{'tag':(0x0042, 0x0012), 'type':'dataset'},
    'Modality':{'tag':(0x0008, 0x0060), 'type':'dataset'},
    'ModalityLUTSequence':{'tag':(0x0028, 0x3000), 'type':'dataset'},
    'PhotometricInterpretation':{'tag':(0x0028, 0x0004), 'type':'dataset'},
    'PixelSpacing':{'tag':(0x0028, 0x0030), 'type':'dataset'},
    'SeriesDescription':{'tag':(0x0008, 0x103e), 'type':'dataset'},
    'StudyInstanceUID':{'tag':(0x0020, 0x000d), 'type':'dataset'},
    'SeriesInstanceUID':{'tag':(0x0020, 0x000e), 'type':'dataset'},
    'SOPInstanceUID':{'tag':(0x0008, 0x0018), 'type':'dataset'},
    'StationName':{'tag':(0x0008, 0x1010), 'type':'dataset'},
    'StudyDate':{'tag':(0x0008, 0x0020), 'type':'dataset'},
    'StudyTime':{'tag':(0x0008, 0x0033), 'type':'dataset'},
    'WideFieldOphthalmicPhotographyQualityRatingSequence':{'tag':(0x0022, 0x1525), 'type':'dataset'},
    'WideFieldOphthalmicPhotographyThresholdQualityRating':{'tag':(0x0022, 0x1527), 'type':'dataset'},
    'WideFieldOphthalmicPhotographyQualityThresholdSequence':{'tag':(0x0022, 0x1526), 'type':'dataset'},
    # Nested
    # 'AnatomicegionSequence':{'tag':(0x0008, 0x2218), 'type':'nested'}, # Special nested tag | Underneath we want all as sep columns
    # 'AcquisitionDeviceTypeCodeSequence':{'tag':(0x0022, 0x0015), 'type':'nested'}, # again everything inside
    # 'ChannelDescriptionCodeSequence':{'tag':(0x0022, 0x001a), 'type':'nested'}, # all underneath
    # 'Code Meaning':{'tag':(0x0018, 0x0012), 'type':'nested'}, # Underneath look for Code meaning...
    }

# Make blanks 
for tag in DICOM_TAGS_OF_INTEREST.keys():
    indexed_glaucoma[tag] = 'Not Found'
indexed_glaucoma['FileExists'] = False
indexed_glaucoma.columns

# Helper function to get dicom values from tags
def get_dicom_tag_value(dicom_dataset, tag):
    tag_value = dicom_dataset.get(tag, None)
    return tag_value.value if tag_value is not None else None

# Ex: Load the DICOM file
dicom_file_path = ''
ds = pydicom.dcmread(dicom_file_path, defer_size=100, force=True)
tag = (0x0020, 0x000d)
value = get_dicom_tag_value(ds, tag)
value = get_dicom_tag_value(ds.file_meta, tag)
print(value)
ds.file_dataset

dir(ds)

def index_glaucoma_images(num_of_files=-1):
    processed = 0
    for file in indexed_glaucoma['FILEPATHVisupac']:
        # print(processed)
        if processed == num_of_files:
            break
        if processed % 100 == 0 and processed != 0:
            # pdb.set_trace()
            print(f"processed {processed} of ~260,000")
            indexed_glaucoma.sort_values("FileExists", ascending=False).to_csv(os.path.join(index_images,"indexed_glaucoma_files.csv"), index=None)
        try:
            # debug
            # file = ''
            ds = pydicom.dcmread(os.path.join(file))
            indexed_glaucoma.loc[indexed_glaucoma['FILEPATHVisupac'] == file, "FileExists"] = True
        except:
            print(f"File {file} doesn't exist")
            # pdb.set_trace()
            pass
        for tag in DICOM_TAGS_OF_INTEREST.keys():    
            try:
                # debugg
                # print(tag)
                # tag = 'Modality'
                if DICOM_TAGS_OF_INTEREST[tag]['type'] == 'dataset':
                    value = get_dicom_tag_value(ds, DICOM_TAGS_OF_INTEREST[tag]['tag'])
                elif DICOM_TAGS_OF_INTEREST[tag]['type'] == 'file_meta':
                    value = get_dicom_tag_value(ds.file_meta, DICOM_TAGS_OF_INTEREST[tag]['tag'])
                else: # Nested
                    print("Finish nested...")
                    value = 'nested'
                    pdb.set_trace()
                # pdb.set_trace()
                if isinstance(value, type(None)):
                    value = 'Not Found'
                elif not (isinstance(value, int) or isinstance(value, float) or isinstance(value, str)):
                    value = [str(i) for i in value]
                    value = '\\'.join(value)
                    # pdb.set_trace()
                # print(value)
                indexed_glaucoma.loc[indexed_glaucoma['FILEPATHVisupac'] == file, tag] = value
            except:
                # print(tag)
                pass
        processed += 1

index_glaucoma_images()



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
        # shutil.copy(orig, dest)
        copied += 1
        # pdb.set_trace()
        

# copy_image_from_VisupacsImagesSLCE_to_VisupacImagesGlaucoma()