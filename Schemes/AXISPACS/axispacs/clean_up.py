import os
import pandas as pd
import pdb
from tqdm import tqdm

AXISPACS_DIR='/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/'

# all_dicoms

VisupacImages_dicoms = pd.read_csv(os.path.join(AXISPACS_DIR, 'parsed', 'VisupacImages_parse_dicom_for_postgres.csv'))
VisupacImages_dicoms['basename'] = VisupacImages_dicoms['file_path'].apply(lambda row: os.path.basename(row).lower().split('.dcm')[0])
VisupacImages_dicoms.shape # 5,353
DICOM_dicoms = pd.read_csv(os.path.join(AXISPACS_DIR, 'parsed', 'DICOM_parse_dicom_for_postgres.csv'))
DICOM_dicoms['basename'] = DICOM_dicoms['file_path'].apply(lambda row: os.path.basename(row).lower().split('.dcm')[0])
DICOM_dicoms.shape # 1,214,811

all_dicoms = pd.concat([VisupacImages_dicoms, DICOM_dicoms], axis=0)
# all_dicoms.to_csv(os.path.join(AXISPACS_DIR, 'all_dicoms.csv'), index=None)
all_dicoms.shape # 1,220,164
all_dicoms.columns
# ['file_path', 'mrn', 'StudyInstanceUID', 'SeriesInstanceUID',
#        'SOPInstanceUID', 'Modality', 'StudyDate', 'SeriesNumber',
#        'InstanceNumber', 'AcquisitionDateTime', 'SOPClassUID', 'SOPClassDescription', 'ImageType',
#        'MIMETypeOfEncapsulatedDocument', 'InstitutionName', 'Manufacturer',
#        'ManufacturerModelName', 'Laterality', 'BitsAllocated',
#        'PhotometricInterpretation', 'PixelSpacing', 'StationName',
#        'SeriesDescription', 'StudyTime', 'DocType', 'AverageRNFLThickness',
#        'OpticCupVolume_mm_squared', 'OpticDiskArea_mm_squared',
#        'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR', 'basename']
all_dicoms.rename(columns={'PatientID':'mrn'},inplace=True)
all_dicoms['StudyDate'] = pd.to_datetime(all_dicoms['StudyDate'].astype("Int64").astype(str), format="%Y%m%d", errors="coerce")


# all_xmls

all_xmls = pd.read_csv(os.path.join(AXISPACS_DIR, 'parsed', 'VisupacImages_XMLs_int_pids.csv')) # 14,014,399 ! not same as total xml count as some pids were corrupt and we filtered out
all_xmls = pd.read_csv(os.path.join(AXISPACS_DIR, 'parsed', 'VisupacImages_XMLs.csv')) # 14,407,580! if using all
all_xmls.shape
all_xmls.columns
all_xmls.rename(columns={'PID':'mrn'}, inplace=True )

header_xmls = ['file_path', 'mrn', 'FirstName', 'LastName', 'DOB', 'Gender',
'ExamDate', 'Laterality', 'DeviceID', 'DataFile', 'ImageWidth',
'ImageType', 'ImageNumber', 'ImageHeight', 'ImageGroup', 'ImageFile',
'AttendingPhysician', 'ReportType', 'Pathology', 'Procedure',
'Layer_Name', 'Start_X', 'Start_Y', 'End_X', 'End_Y', 'SizeX', 'SizeZ',
'ScanPattern', 'Scale_X', 'Scale_Y', 'Scale_Z', 'XSlo', 'YSlo',
'TimeStamp_TotalSeconds', 'basename']

all_xmls['basename'] = all_xmls['file_path'].apply(lambda row: os.path.basename(row).lower().split('.xml')[0])
# all_xmls[header_xmls].to_csv(os.path.join(AXISPACS_DIR, 'all_xmls.csv'), index=None)


# all_j2ks

DICOM_j2k_files = pd.read_csv(os.path.join(AXISPACS_DIR, 'raw_files_lists', 'DICOM_j2k_files.csv'))
DICOM_j2k_files['basename'] = DICOM_j2k_files['file_path'].apply(lambda row: os.path.basename(row).lower().split('.j2k')[0].split('-')[0])
DICOM_j2k_files['basename'][0]
DICOM_j2k_files.shape # 884,945

VisupacImages_j2k_files = pd.read_csv(os.path.join(AXISPACS_DIR, 'raw_files_lists', 'VisupacImages_j2k_files.csv'))
VisupacImages_j2k_files['basename'] = VisupacImages_j2k_files['file_path'].apply(lambda row: os.path.basename(row).lower().split('.j2k')[0])
VisupacImages_j2k_files.shape # 14,474,611

## Question: Are the j2ks related between the DICOM dir and VisupacImages dir?
##  - since no j2ks in common by basename of file we can separate parsing by DICOM and VisupacImages below...
j2ks_in_common = set(VisupacImages_j2k_files['basename']).intersection(set(DICOM_j2k_files['basename'])); len(j2ks_in_common) # 0




## /persist/PACS/VisupacImages: xmls with their likely j2k pairs
def find_j2k_xml(row):
    # pdb.set_trace()
    xml_rows = all_xmls[all_xmls['basename'] == row['basename']]
    if xml_rows.shape[0] > 1:
        pdb.set_trace()
    elif xml_rows.shape[0] == 0:
        return pd.Series({col: pd.NA for col in all_xmls.columns if col != "basename"})
    return xml_rows.iloc[0]


### DATA EXPLORATION
# j2ks_in_common = set(VisupacImages_j2k_files['basename']).intersection(set(all_xmls['basename'])); len(j2ks_in_common) # 14,206,594 | 13,887,946 (no corrupt pids) ! basenames not j2k_files
# j2ks_not_in_common = set(VisupacImages_j2k_files['basename']) - set(all_xmls['basename']); len(j2ks_not_in_common) # 66,715 | 385,363 (no corrupt pids) ! basenames not j2k_files
# j2ks_not_in_common = set(all_xmls['basename']) - set(VisupacImages_j2k_files['basename']); len(j2ks_not_in_common) # 0
# all_xmls[all_xmls['basename'].isin(j2ks_in_common)]
# all_xmls[all_xmls['basename'].isin(j2ks_not_in_common)]
### looks good; deeper analysis pending later...
# j2ks_xmls_in_common_files_preview = VisupacImages_j2k_files[VisupacImages_j2k_files['basename'].isin(j2ks_in_common)] # 14,407,586 | XX (no corrupt pids)
# j2ks_xmls_not_in_common_files_preview = VisupacImages_j2k_files[VisupacImages_j2k_files['basename'].isin(j2ks_not_in_common)] # 67,025 | 460,100 (no corrupt pids)
# xmls_j2ks_in_common_files_preview = all_xmls[all_xmls['basename'].isin(j2ks_in_common)]
# len(j2ks_xmls_in_common_files_preview['j2k_path'].unique()) # 14,014,511
# len(j2ks_xmls_not_in_common_files_preview['j2k_path'].unique()) # 460,100
# len(xmls_j2ks_in_common_files_preview['file_path'].unique()) #  14,014,399; all accounted for
# j2ks_xmls_in_common_files_preview.sort_values('basename')
# grouped_j2ks_by_basename = j2ks_xmls_in_common_files_preview.groupby('basename').count().reset_index()
# grouped_j2ks_by_basename.head()
# by spot check the qbelow duplicates are identical. More code needed to say with certainty
# xmsl_with_multiple_j2ks_or_duplicate_files = xmls_j2ks_in_common_files_preview[xmls_j2ks_in_common_files_preview['basename'].isin(grouped_j2ks_by_basename[grouped_j2ks_by_basename['j2k_path'] >2]['basename'])]
# xmsl_with_multiple_j2ks_or_duplicate_files.sort_values('basename', inplace=True)
# xmsl_with_multiple_j2ks_or_duplicate_files.shape
# xmsl_with_multiple_j2ks_or_duplicate_files.to_csv(os.path.join(AXISPACS_DIR, 'xmsl_with_multiple_j2ks_or_duplicate_files.csv'), index=None)

# j2ks_xml_join = pd.merge(VisupacImages_j2k_files, all_xmls[['file_path', 'file_path_j2k_maybe']], how='left', left_on='j2k_path', right_on='file_path_j2k_maybe')
j2ks_xml_join = pd.merge(VisupacImages_j2k_files, all_xmls, how='left', left_on='file_path', right_on='file_path_j2k_maybe')
j2ks_xml_join.rename(columns={'file_path_x':'file_path_j2k'}, inplace=True)
j2ks_xml_join.rename(columns={'file_path_y':'file_path_xml'}, inplace=True)
# j2ks_xml_join.columns
# j2ks_xml_join.iloc[0]['file_path_j2k']
# j2ks_xml_join.iloc[0]['file_path_xml']

j2ks_xml_join.rename(columns={'basename_x':'basename'}, inplace=True )
j2ks_xml_join.drop(columns=['basename_y'], inplace=True)
# j2ks_xml_join.head()
# j2ks_xml_join[pd.isna(j2ks_xml_join['file_path_j2k_maybe'])].shape # 67,059 | 460,222 (no corrupt pids)
# j2ks_xml_join[~pd.isna(j2ks_xml_join['file_path_j2k_maybe'])].shape # 14,407,552 | 14,014,389 (no corrupt pids)


j2ks_without_xml_data = j2ks_xml_join[pd.isna(j2ks_xml_join['file_path_j2k_maybe'])][0:10].copy() # also these might be useless
# j2ks_without_xml_data = j2ks_xml_join[pd.isna(j2ks_xml_join['file_path_j2k_maybe'])].copy() # If we really want: will take a looooooooong time
# j2ks_without_xml_data.to_csv(os.path.join(AXISPACS_DIR, 'parsed', 'j2ks_without_xml_data.csv'), index=None)
# only process non joined data to be somewhat efficient as this is a slow apply func
tqdm.pandas()
xml_info_for_non_intuitive_paths = j2ks_without_xml_data.progress_apply(lambda row: find_j2k_xml(row), axis=1)
# keep only columns that don't already exist in the destination DF
xml_info_for_non_intuitive_paths = xml_info_for_non_intuitive_paths.loc[:, ~xml_info_for_non_intuitive_paths.columns.isin(j2ks_without_xml_data.columns)]
# add them without touching existing columns
j2ks_without_xml_data = j2ks_without_xml_data.join(xml_info_for_non_intuitive_paths)
# set(all_xmls.columns) - set(j2ks_without_xml_data.columns)
set(j2ks_without_xml_data.columns) - set(all_xmls.columns)

j2ks_with_xml_data = j2ks_xml_join[~pd.isna(j2ks_xml_join['file_path_j2k_maybe'])]
j2ks_with_xml_data.drop(columns=['file_path_j2k_maybe'], inplace=True)
j2ks_without_xml_data.drop(columns=['file_path_j2k_maybe'], inplace=True)

# set(j2ks_with_xml_data.columns) - set(j2ks_without_xml_data.columns)
# set(j2ks_without_xml_data.columns) - set(j2ks_with_xml_data.columns)

### milestone variable to be merged with DICOM j2k scan situation
VisupacImages_j2ks_with_xml_metadata = pd.concat([j2ks_with_xml_data, j2ks_without_xml_data], axis=0)
VisupacImages_j2ks_with_xml_metadata.shape
### milestone variable to be merged with DICOM j2k scan situation
# .to_csv(os.path.join(AXISPACS_DIR, '.csv'), index=None)

# all_xmls[all_xmls['file_path'] == '/persist/PACS/VisupacImages/1000/489331/axis01_1000_489331_20220214140205254b0a97dbcee344da8.xml']
# all_xmls[all_xmls['basename'] == 'axis01_10022_253232_20181115142249518f07f6c118beb52df_001']
# all_xmls[all_xmls['file_path'].str.contains('_10022_253232_20181115142249518f07f6c118beb52')]
# Example of performing a "like" string match on a column
# Here, we filter rows where the 'basename' column contains the substring 'axis01'

# like_match = all_xmls[all_xmls['basename'].str.contains('axis01', case=False, na=False)]
# like_match.head()



## /persist/PACS/DICOM: dicoms with their likely j2k pairs
### DATA EXPLORATION
# j2ks_in_common = set(all_dicoms['basename']).intersection(set(DICOM_j2k_files['basename'])); len(j2ks_in_common) # 589,075 ! this is count of basenames not files!
# j2ks_in_common = set(DICOM_dicoms['basename']).intersection(set(DICOM_j2k_files['basename'])); len(j2ks_in_common) # 589,075 ! this is count of basenames not files!
# no_j2ks_in_common = set(DICOM_dicoms['basename']) - (set(DICOM_j2k_files['basename'])); len(no_j2ks_in_common) # 620,688 ! this is count of basenames not files!
# no_j2ks_in_common = set(DICOM_j2k_files['basename']) - (set(DICOM_dicoms['basename'])); len(no_j2ks_in_common) # 0

# pd.set_option('display.max_colwidth', None)  # Set column width to display full file paths
# dicoms_j2ks_in_common_preview = DICOM_dicoms[DICOM_dicoms['basename'].isin(j2ks_in_common)]
# dicoms_no_j2ks_in_common_preview = DICOM_dicoms[DICOM_dicoms['basename'].isin(no_j2ks_in_common)]
# len(dicoms_j2ks_in_common_preview['file_path'].unique()) # 590,549; Sample of 10 were all pdfs leading me to believe all j2k overlap is for pdfs based DICOMs
# len(dicoms_no_j2ks_in_common_preview['file_path'].unique()) # 624,262 ; I can open these and I see images. So I believe ~600,000 are fully contained dicoms

# j2ks_dicoms_in_common_preview = DICOM_j2k_files[DICOM_j2k_files['basename'].isin(j2ks_in_common)] # 884,945; all j2ks in /persist/PACS/DICOM have a corresponding dicom
# j2ks_no_dicoms_in_common_preview = DICOM_j2k_files[DICOM_j2k_files['basename'].isin(no_j2ks_in_common)] # 0
# len(j2ks_dicoms_in_common_preview['j2k_path'].unique()) # 884,945
# len(j2ks_no_dicoms_in_common_preview['j2k_path'].unique()) # 0


### get dicom metadata for j2k previews
DICOM_j2ks_join = pd.merge(DICOM_dicoms,DICOM_j2k_files, on='basename', how='outer')
DICOM_j2ks_join.rename(columns={'file_path_x':'file_path_dcm'}, inplace=True)
DICOM_j2ks_join.rename(columns={'file_path_y':'file_path_j2k'}, inplace=True)

DICOM_j2ks_join.shape # 1,513,931 ! over total for either so let's break it down

# DICOM_j2ks_join[pd.isna(DICOM_j2ks_join['j2k_path'])] # 624,262
# DICOM_j2ks_join[pd.isna(DICOM_j2ks_join['file_path'])] # 0 - no instance of j2k unique to itself with no dicom pair
# DICOM_j2ks_join[~pd.isna(DICOM_j2ks_join['file_path'])] # 1,513,931 - every dicom accounted for
# DICOM_j2ks_join[~pd.isna(DICOM_j2ks_join['j2k_path'])] # 889,669
# DICOM_j2ks_join.columns
# !!!!!!!!!!!delete DICOM_j2ks_join.rename(columns={'file_path':'dcm_path'}, inplace=True)
# specific_order = ['file_path_j2k', 'file_path_dcm', 'PatientID', 'StudyInstanceUID', 'SeriesInstanceUID', 
#                   'SOPInstanceUID', 'Modality', 'StudyDate', 'SeriesNumber', 'InstanceNumber', 'basename']
specific_order = ['file_path_j2k', 'file_path_dcm', 'PatientID', 'StudyInstanceUID', 'SeriesInstanceUID',
                  'SOPInstanceUID', 'Modality', 'StudyDate', 'SeriesNumber', 'InstanceNumber', 
                  'AcquisitionDateTime', 'SOPClassUID', 'SOPClassDescription', 'ImageType', 'MIMETypeOfEncapsulatedDocument', 'InstitutionName', 
                  'Manufacturer',  'ManufacturerModelName', 'Laterality', 'BitsAllocated', 'PhotometricInterpretation', 
                  'PixelSpacing', 'StationName', 'SeriesDescription', 'StudyTime', 'DocType', 'AverageRNFLThickness', 
                  'OpticCupVolume_mm_squared', 'OpticDiskArea_mm_squared', 'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR', 'basename']



# DICOM_j2ks_join['file_path'][0]
DICOM_j2ks_with_dicom_metadata = DICOM_j2ks_join[~pd.isna(DICOM_j2ks_join['file_path_j2k'])][specific_order]

# Summary:
# 1,214,811 total dicoms in /persist/PACS/DICOM
#   * 590,549 of 1,214,811 dicoms have j2ks and those amount to 884,945 total.
#   * 624,262 of 1,214,811 dicoms have no j2k preview and have pixel like data or other non-pdf data.
# * 590,549 + 624,262 = 1,214,811


### merge VisupacImages j2ks with DICOM j2ks
VisupacImages_j2ks_with_xml_metadata.columns
VisupacImages_j2ks_with_xml_metadata.rename(columns={'PID':'mrn'},inplace=True)
# DICOM_j2ks_with_dicom_metadata.columns
DICOM_j2ks_with_dicom_metadata.rename(columns={'PatientID':'mrn'},inplace=True)

header_vis = ['file_path_j2k', 'mrn', 'basename', 'file_path_xml', 'FirstName', 'LastName', 'DOB', 'Gender',
'ExamDate', 'Laterality', 'DeviceID', 'DataFile', 'ImageWidth', 'ImageType', 'ImageNumber', 'ImageHeight', 'ImageGroup', 'ImageFile',
'AttendingPhysician', 'ReportType', 'Pathology', 'Procedure', 'Layer_Name',
'Start_X', 'Start_Y', 'End_X', 'End_Y', 'SizeX', 'SizeZ', 'ScanPattern', 'Scale_X', 'Scale_Y', 'Scale_Z', 'XSlo', 'YSlo', 'TimeStamp_TotalSeconds'
]

# header_dicom = ['file_path_j2k', 'mrn', 'basename', 'file_path_dcm', 'StudyInstanceUID', 'SeriesInstanceUID', 'SOPInstanceUID', 'Modality', 'StudyDate', 'SeriesNumber', 'InstanceNumber']
header_dicom = ['file_path_j2k', 'mrn', 'basename', 'file_path_dcm', 'StudyInstanceUID', 'SeriesInstanceUID', 'SOPInstanceUID', 'Modality', 'StudyDate', 'SeriesNumber', 'InstanceNumber',  'AcquisitionDateTime', 'SOPClassUID', 'SOPClassDescription', 'ImageType', 'MIMETypeOfEncapsulatedDocument', 'InstitutionName',  'Manufacturer',  'ManufacturerModelName', 'Laterality', 'BitsAllocated', 'PhotometricInterpretation',  'PixelSpacing', 'StationName', 'SeriesDescription', 'StudyTime', 'DocType', 'AverageRNFLThickness',  'OpticCupVolume_mm_squared', 'OpticDiskArea_mm_squared', 'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR']

### superset for both table's columns
all_j2ks = pd.concat([VisupacImages_j2ks_with_xml_metadata[header_vis], DICOM_j2ks_with_dicom_metadata[header_dicom]], ignore_index=True, sort=False)
all_j2ks.rename(columns={'file_path_j2k':'file_path'}, inplace=True)
# all_j2ks.shape # 15,297,231
# all_j2ks.columns
all_j2ks_header = ['file_path', 'file_path_xml', 'mrn', 'FirstName', 'LastName', 'DOB', 'Gender', 'ExamDate', 'Laterality', 'DeviceID', 'DataFile', 'ImageWidth', 'ImageNumber', 'ImageHeight', 'ImageGroup', 'ImageFile', 'AttendingPhysician', 'ReportType', 'Pathology', 'Procedure', 'Layer_Name', 'Start_X', 'Start_Y', 'End_X', 'End_Y', 'SizeX', 'SizeZ', 'ScanPattern', 'Scale_X', 'Scale_Y', 'Scale_Z', 'XSlo', 'YSlo', 'TimeStamp_TotalSeconds', 'ImageType', 'file_path_dcm', 'StudyInstanceUID', 'SeriesInstanceUID', 'SOPInstanceUID', 'Modality', 'StudyDate', 'SeriesNumber', 'InstanceNumber', 'AcquisitionDateTime', 'SOPClassUID', 'SOPClassDescription', 'MIMETypeOfEncapsulatedDocument', 'InstitutionName', 'Manufacturer', 'ManufacturerModelName', 'BitsAllocated', 'PhotometricInterpretation', 'PixelSpacing', 'StationName', 'SeriesDescription', 'StudyTime', 'DocType', 'AverageRNFLThickness', 'OpticCupVolume_mm_squared', 'OpticDiskArea_mm_squared', 'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR', 'basename']
all_j2ks['StudyDate'] = pd.to_datetime(all_j2ks['StudyDate'].astype("Int64").astype(str), format="%Y%m%d", errors="coerce")


# all_j2ks[all_j2ks_header].to_csv(os.path.join(AXISPACS_DIR, 'all_j2ks.csv'), index=None)





# all_files

all_j2ks = pd.read_csv(os.path.join(AXISPACS_DIR, 'all_j2ks.csv'), index=None)
all_j2ks.columns
# ['file_path', 'mrn', 'basename', 'file_path_xml', 'FirstName',
#        'LastName', 'DOB', 'Gender', 'ExamDate', 'Laterality', 'DeviceID',
#        'DataFile', 'ImageWidth', 'ImageType', 'ImageNumber', 'ImageHeight',
#        'ImageGroup', 'ImageFile', 'AttendingPhysician', 'ReportType',
#        'Pathology', 'Procedure', 'Layer_Name', 'Start_X', 'Start_Y', 'End_X',
#        'End_Y', 'SizeX', 'SizeZ', 'ScanPattern', 'Scale_X', 'Scale_Y',
#        'Scale_Z', 'XSlo', 'YSlo', 'TimeStamp_TotalSeconds', 'file_path_dcm',
#        'StudyInstanceUID', 'SeriesInstanceUID', 'SOPInstanceUID', 'Modality',
#        'StudyDate', 'SeriesNumber', 'InstanceNumber', 'AcquisitionDateTime',
#        'SOPClassUID', 'MIMETypeOfEncapsulatedDocument', 'InstitutionName',
#        'Manufacturer', 'ManufacturerModelName', 'BitsAllocated',
#        'PhotometricInterpretation', 'PixelSpacing', 'StationName',
#        'SeriesDescription', 'StudyTime', 'DocType', 'AverageRNFLThickness',
#        'OpticCupVolume_mm_squared', 'OpticDiskArea_mm_squared',
#        'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR']
all_dicoms = pd.read_csv(os.path.join(AXISPACS_DIR, 'all_dicoms.csv'), index=None)
all_dicoms.columns
# ['file_path', 'mrn', 'StudyInstanceUID', 'SeriesInstanceUID',
#        'SOPInstanceUID', 'Modality', 'StudyDate', 'SeriesNumber',
#        'InstanceNumber', 'AcquisitionDateTime', 'SOPClassUID', 'SOPClassDescription', 'ImageType',
#        'MIMETypeOfEncapsulatedDocument', 'InstitutionName', 'Manufacturer',
#        'ManufacturerModelName', 'Laterality', 'BitsAllocated',
#        'PhotometricInterpretation', 'PixelSpacing', 'StationName',
#        'SeriesDescription', 'StudyTime', 'DocType', 'AverageRNFLThickness',
#        'OpticCupVolume_mm_squared', 'OpticDiskArea_mm_squared',
#        'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR', 'basename']
all_files = pd.concat([all_j2ks, all_dicoms], ignore_index=True, sort=False)

all_files.shape # 16517395
all_files.columns
all_files.head()
all_files_header = ['file_path', 'file_path_xml', 'mrn', 'FirstName',
       'LastName', 'DOB', 'Gender', 'ExamDate', 'Laterality', 'DeviceID',
       'DataFile', 'ImageWidth', 'ImageNumber', 'ImageHeight',
       'ImageGroup', 'ImageFile', 'AttendingPhysician', 'ReportType',
       'Pathology', 'Procedure', 'Layer_Name', 'Start_X', 'Start_Y', 'End_X',
       'End_Y', 'SizeX', 'SizeZ', 'ScanPattern', 'Scale_X', 'Scale_Y',
       'Scale_Z', 'XSlo', 'YSlo', 'TimeStamp_TotalSeconds', 'ImageType', 'file_path_dcm',
       'StudyInstanceUID', 'SeriesInstanceUID', 'SOPInstanceUID', 'Modality',
       'StudyDate', 'SeriesNumber', 'InstanceNumber', 'AcquisitionDateTime',
       'SOPClassUID', 'MIMETypeOfEncapsulatedDocument', 'InstitutionName',
       'Manufacturer', 'ManufacturerModelName', 'BitsAllocated',
       'PhotometricInterpretation', 'PixelSpacing', 'StationName',
       'SeriesDescription', 'StudyTime', 'DocType', 'AverageRNFLThickness',
       'OpticCupVolume_mm_squared', 'OpticDiskArea_mm_squared',
       'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR', 'basename']
len(all_files_header)
# Might be done already by all_dicoms and all_j2ks
# all_files['StudyDate'] = pd.to_datetime(all_files['StudyDate'].astype("Int64").astype(str), format="%Y%m%d", errors="coerce")

# all_files[:1000000].to_csv(os.path.join(AXISPACS_DIR, 'all_files_sample.csv'), index=None)
len(all_files_header)
all_files[all_files_header].to_csv(os.path.join(AXISPACS_DIR, 'all_files.csv'), index=None)