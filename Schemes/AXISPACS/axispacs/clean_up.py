import os
import pandas as pd
import pdb
from tqdm import tqdm
tqdm.pandas()

pd.set_option('display.max_colwidth', None)


AXISPACS_DIR='/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/'

# all_dicoms

VisupacImages_dicoms = pd.read_csv(os.path.join(AXISPACS_DIR, 'parsed', 'VisupacImages_parse_dicom_for_postgres.csv'))
VisupacImages_dicoms['basename'] = VisupacImages_dicoms['file_path'].apply(lambda row: os.path.basename(row).lower().split('.dcm')[0])
VisupacImages_dicoms['folder'] = VisupacImages_dicoms['file_path'].apply(lambda row: os.path.dirname(row))
VisupacImages_dicoms.shape # 5,353
DICOM_dicoms = pd.read_csv(os.path.join(AXISPACS_DIR, 'parsed', 'DICOM_parse_dicom_for_postgres.csv'))
DICOM_dicoms['basename'] = DICOM_dicoms['file_path'].apply(lambda row: os.path.basename(row).lower().split('.dcm')[0])
DICOM_dicoms['folder'] = DICOM_dicoms['file_path'].apply(lambda row: os.path.dirname(row))
DICOM_dicoms.shape # 1,214,811

all_dicoms = pd.concat([VisupacImages_dicoms, DICOM_dicoms], axis=0)
# duplicates_dicom = all_dicoms[all_dicoms.duplicated(subset=['file_path'], keep=False)]


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
#        'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR', 'basename', 'folder']
all_dicoms.rename(columns={'PatientID':'mrn'},inplace=True)
# all_dicoms['StudyDate'] = pd.to_datetime(all_dicoms['StudyDate'].astype("Int64").astype(str), format="%Y%m%d", errors="coerce")


# all_xmls

# all_xmls = pd.read_csv(os.path.join(AXISPACS_DIR, 'parsed', 'VisupacImages_XMLs_int_pids.csv')) # 14,014,399 ! not same as total xml count as some pids were corrupt and we filtered out
all_xmls = pd.read_csv(os.path.join(AXISPACS_DIR, 'parsed', 'VisupacImages_XMLs.csv')) # 14,407,580! if using all
all_xmls.shape
all_xmls.columns
all_xmls.rename(columns={'PID':'mrn'}, inplace=True )
# duplicates_xmls = all_xmls[all_xmls.duplicated(subset=['file_path'], keep=False)]

# all_xmls[['file_path_j2k_maybe', 'file_path']]
header_xmls = ['file_path', 'mrn', 'FirstName', 'LastName', 'DOB', 'Gender',
'ExamDate', 'Laterality', 'DeviceID', 'DataFile', 'ImageWidth',
'ImageType', 'ImageNumber', 'ImageHeight', 'ImageGroup', 'ImageFile',
'AttendingPhysician', 'ReportType', 'Pathology', 'Procedure',
'Layer_Name', 'Start_X', 'Start_Y', 'End_X', 'End_Y', 'SizeX', 'SizeZ',
'ScanPattern', 'Scale_X', 'Scale_Y', 'Scale_Z', 'XSlo', 'YSlo',
'TimeStamp_TotalSeconds', 'basename']

all_xmls['basename'] = all_xmls['file_path'].apply(lambda row: os.path.basename(row).lower().split('.xml')[0])
all_xmls['folder'] = all_xmls['file_path'].apply(lambda row: os.path.dirname(row))
# all_xmls[header_xmls].to_csv(os.path.join(AXISPACS_DIR, 'all_xmls.csv'), index=None)


# all_j2ks

DICOM_j2k_files = pd.read_csv(os.path.join(AXISPACS_DIR, 'raw_files_lists', 'DICOM_j2k_files.csv'))
DICOM_j2k_files['basename'] = DICOM_j2k_files['file_path'].apply(lambda row: os.path.basename(row).lower().split('.j2k')[0].split('-')[0])
DICOM_j2k_files['folder'] = DICOM_j2k_files['file_path'].apply(lambda row: os.path.dirname(row))
DICOM_j2k_files.shape # 884,945
# duplicates_DICOM_j2k_files = DICOM_j2k_files[DICOM_j2k_files.duplicated(subset=['file_path'], keep=False)]
DICOM_j2k_files[DICOM_j2k_files['basename'] == 'axis01_7925_408544_20210226095615583ddc3aefae830b501']

VisupacImages_j2k_files = pd.read_csv(os.path.join(AXISPACS_DIR, 'raw_files_lists', 'VisupacImages_j2k_files.csv'))
VisupacImages_j2k_files['basename'] = VisupacImages_j2k_files['file_path'].apply(lambda row: os.path.basename(row).lower().split('.j2k')[0])
VisupacImages_j2k_files['folder'] = VisupacImages_j2k_files['file_path'].apply(lambda row: os.path.dirname(row))
VisupacImages_j2k_files.shape # 14,474,611
VisupacImages_j2k_files.columns
# duplicates_VisupacImages_j2k_files = VisupacImages_j2k_files[VisupacImages_j2k_files.duplicated(subset=['file_path'], keep=False)]
DICOM_j2k_files[DICOM_j2k_files['basename'] == 'axis01_7925_408544_20210226095615583ddc3aefae830b501']

## Question: Are the j2ks related between the DICOM dir and VisupacImages dir?
##  - since no j2ks in common by basename of file we can separate parsing by DICOM and VisupacImages below...
j2ks_in_common = set(VisupacImages_j2k_files['basename']).intersection(set(DICOM_j2k_files['basename'])); len(j2ks_in_common) # 0




## /persist/PACS/VisupacImages: xmls with their likely j2k pairs
# def find_j2k_xml(rows):
#     pdb.set_trace()
#     rows['folder']
#     rows['file_path_j2k']
#     rows['file_path_xml']



# j2ks_xml_join.shape[0] # 14,474,611
j2ks_xml_join = pd.merge(VisupacImages_j2k_files, all_xmls, how='left', on=['folder', 'basename'])
# j2ks_xml_join.drop_duplicates(inplace=True)


j2ks_xml_join.shape[0] # 14,474,611
j2ks_xml_join.rename(columns={'file_path_x':'file_path_j2k'}, inplace=True)
j2ks_xml_join.rename(columns={'file_path_y':'file_path_xml'}, inplace=True)
# duplicates_j2ks_xml_join = j2ks_xml_join[j2ks_xml_join.duplicated(subset=['file_path_j2k'], keep=False)]


j2ks_without_xml_data = j2ks_xml_join[pd.isna(j2ks_xml_join['file_path_xml'])]
j2ks_without_xml_data.drop(columns=['file_path_j2k_maybe'], inplace=True)
# duplicates_j2ks_without_xml_data = j2ks_without_xml_data[j2ks_without_xml_data.duplicated(subset=['file_path_j2k'], keep=False)]

j2ks_with_xml_data = j2ks_xml_join[~pd.isna(j2ks_xml_join['file_path_xml'])]
j2ks_with_xml_data.drop(columns=['file_path_j2k_maybe'], inplace=True)
# duplicates_j2ks_with_xml_data = j2ks_with_xml_data[j2ks_with_xml_data.duplicated(subset=['file_path_j2k'], keep=False)]


### milestone variable to be merged with DICOM j2k scan situation
VisupacImages_j2ks_with_xml_metadata = pd.concat([j2ks_with_xml_data, j2ks_without_xml_data], axis=0)
VisupacImages_j2ks_with_xml_metadata.shape
# duplicates_VisupacImages_j2ks_with_xml_metadata = VisupacImages_j2ks_with_xml_metadata[VisupacImages_j2ks_with_xml_metadata.duplicated(subset=['file_path_j2k'], keep=False)]
# duplicates_VisupacImages_j2ks_with_xml_metadata.sort_values('file_path_j2k', inplace=True)
VisupacImages_j2ks_with_xml_metadata[VisupacImages_j2ks_with_xml_metadata['basename'] == 'axis01_7925_408544_20210226095615583ddc3aefae830b501'].to_csv(os.path.join('/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/uveitis_check_for_chris', 'VisupacImages_j2ks_with_xml_metadata_axis01_7925_408544_20210226095615583ddc3aefae830b501.csv'), index=None)


### milestone variable to be merged with DICOM j2k scan situation



## /persist/PACS/DICOM: dicoms with their likely j2k pairs

### get dicom metadata for j2k previews
DICOM_j2ks_join = pd.merge(DICOM_dicoms,DICOM_j2k_files, on=['folder', 'basename'], how='outer')
DICOM_j2ks_join.rename(columns={'file_path_x':'file_path_dcm'}, inplace=True)
DICOM_j2ks_join.rename(columns={'file_path_y':'file_path_j2k'}, inplace=True)
DICOM_j2ks_join[DICOM_j2ks_join['basename'] == 'axis01_7925_408544_20210226095615583ddc3aefae830b501']
duplicates_DICOM_j2ks_join = DICOM_j2ks_join[DICOM_j2ks_join.duplicated(subset=['file_path_dcm'], keep=False)]
# duplicates_DICOM_j2ks_join.sort_values('file_path_dcm', inplace=True)
duplicates_DICOM_j2ks_join = DICOM_j2ks_join[DICOM_j2ks_join.duplicated(subset=['file_path_j2k'], keep=False)]
# duplicates_DICOM_j2ks_join.sort_values('file_path_j2k', inplace=True)
duplicates_DICOM_j2ks_join.sort_values(['basename', 'file_path_j2k'], inplace=True)
duplicates_DICOM_j2ks_join.sort_values(['basename', 'file_path_dcm'], inplace=True)
duplicates_DICOM_j2ks_join[['file_path_dcm','file_path_j2k']].to_csv(os.path.join('/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/uveitis_check_for_chris', 'duplicates_DICOM_j2ks_join.csv'), index=None)

# QA
DICOM_j2ks_join[pd.isna(DICOM_j2ks_join['file_path_dcm'])]
DICOM_j2ks_join[pd.isna(DICOM_j2ks_join['file_path_j2k'])]

# DICOM_dicoms[DICOM_dicoms['basename']=='1.2.276.0.75.2.1.11.1.3.201207112950912.966169756395.1000114'][['file_path', 'basename']]
# DICOM_dicoms[DICOM_dicoms['basename']=='1.2.276.0.75.2.1.11.1.3.201207113304967.966169756395.1000117'][['file_path', 'basename']]
# DICOM_dicoms[DICOM_dicoms['basename']=='1.2.276.0.75.2.1.11.1.3.201207113809470.966169756395.1000118'][['file_path', 'basename']]
# DICOM_dicoms[DICOM_dicoms['basename']=='1.2.276.0.75.2.1.11.1.3.201207114459720.966169756395.1000119'][['file_path', 'basename']]
# DICOM_dicoms[DICOM_dicoms['basename']=='1.2.276.0.75.2.1.11.1.3.210924133430647.966169756395.1000018'][['file_path', 'basename']]

# DICOM_j2ks_join.loc[DICOM_j2ks_join['file_path_j2k'].str.contains('/persist/PACS/DICOM/35223/390753/1.2.276.0.75.2.1.11.1.3.201207112950912.966169756395.1000114', na=False),['file_path_dcm', 'basename','file_path_j2k']]
# DICOM_j2ks_join.loc[DICOM_j2ks_join['file_path_j2k'].str.contains('/persist/PACS/DICOM/35223/390753/1.2.276.0.75.2.1.11.1.3.201207113304967.966169756395.1000117', na=False),['file_path_dcm', 'basename','file_path_j2k']]
# DICOM_j2ks_join.loc[DICOM_j2ks_join['file_path_j2k'].str.contains('/persist/PACS/DICOM/35223/390753/1.2.276.0.75.2.1.11.1.3.201207113809470.966169756395.1000118', na=False),['file_path_dcm', 'basename','file_path_j2k']]
# DICOM_j2ks_join.loc[DICOM_j2ks_join['file_path_j2k'].str.contains('/persist/PACS/DICOM/35223/390753/1.2.276.0.75.2.1.11.1.3.201207114459720.966169756395.1000119', na=False),['file_path_dcm', 'basename','file_path_j2k']]
# DICOM_j2ks_join.loc[DICOM_j2ks_join['file_path_j2k'].str.contains('/persist/PACS/DICOM/49557/458020/1.2.276.0.75.2.1.11.1.3.210924133430647.966169756395.1000018', na=False),['file_path_dcm', 'basename','file_path_j2k']]


# MANUAL OVERRIDES for missing metadata in DICOM_j2ks_join from DICOM_dicoms | The folder was different so the merge didn't pick it up
dicom_metadata_header = ['PatientID', 'StudyInstanceUID', 'SeriesInstanceUID',
'SOPInstanceUID', 'Modality', 'StudyDate', 'SeriesNumber',
'InstanceNumber', 'AcquisitionDateTime', 'SOPClassUID', 'ImageType',
'MIMETypeOfEncapsulatedDocument', 'InstitutionName', 'Manufacturer',
'ManufacturerModelName', 'Laterality', 'BitsAllocated',
'PhotometricInterpretation', 'PixelSpacing', 'StationName',
'SeriesDescription', 'StudyTime', 'DocType', 'AverageRNFLThickness',
'OpticCupVolume_mm_squared', 'OpticDiskArea_mm_squared',
'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR']

DICOM_j2ks_join.loc[DICOM_j2ks_join['file_path_j2k'].str.contains('/persist/PACS/DICOM/35223/390753/1.2.276.0.75.2.1.11.1.3.201207112950912.966169756395.1000114', na=False),dicom_metadata_header] = DICOM_dicoms[DICOM_dicoms['basename']=='1.2.276.0.75.2.1.11.1.3.201207112950912.966169756395.1000114'][dicom_metadata_header]
DICOM_j2ks_join.loc[DICOM_j2ks_join['file_path_j2k'].str.contains('/persist/PACS/DICOM/35223/390753/1.2.276.0.75.2.1.11.1.3.201207113304967.966169756395.1000117', na=False),dicom_metadata_header] = DICOM_dicoms[DICOM_dicoms['basename']=='1.2.276.0.75.2.1.11.1.3.201207113304967.966169756395.1000117'][dicom_metadata_header]
DICOM_j2ks_join.loc[DICOM_j2ks_join['file_path_j2k'].str.contains('/persist/PACS/DICOM/35223/390753/1.2.276.0.75.2.1.11.1.3.201207113809470.966169756395.1000118', na=False),dicom_metadata_header] = DICOM_dicoms[DICOM_dicoms['basename']=='1.2.276.0.75.2.1.11.1.3.201207113809470.966169756395.1000118'][dicom_metadata_header]
DICOM_j2ks_join.loc[DICOM_j2ks_join['file_path_j2k'].str.contains('/persist/PACS/DICOM/35223/390753/1.2.276.0.75.2.1.11.1.3.201207114459720.966169756395.1000119', na=False),dicom_metadata_header] = DICOM_dicoms[DICOM_dicoms['basename']=='1.2.276.0.75.2.1.11.1.3.201207114459720.966169756395.1000119'][dicom_metadata_header]
DICOM_j2ks_join.loc[DICOM_j2ks_join['file_path_j2k'].str.contains('/persist/PACS/DICOM/49557/458020/1.2.276.0.75.2.1.11.1.3.210924133430647.966169756395.1000018', na=False),dicom_metadata_header] = DICOM_dicoms[DICOM_dicoms['basename']=='1.2.276.0.75.2.1.11.1.3.210924133430647.966169756395.1000018'][dicom_metadata_header]

DICOM_j2ks_join.loc[DICOM_j2ks_join['file_path_j2k'].str.contains('/persist/PACS/DICOM/35223/390753/1.2.276.0.75.2.1.11.1.3.201207112950912.966169756395.1000114', na=False),'file_path_dcm'] = DICOM_dicoms[DICOM_dicoms['basename']=='1.2.276.0.75.2.1.11.1.3.201207112950912.966169756395.1000114']['file_path'].iloc[0]
DICOM_j2ks_join.loc[DICOM_j2ks_join['file_path_j2k'].str.contains('/persist/PACS/DICOM/35223/390753/1.2.276.0.75.2.1.11.1.3.201207113304967.966169756395.1000117', na=False),'file_path_dcm'] = DICOM_dicoms[DICOM_dicoms['basename']=='1.2.276.0.75.2.1.11.1.3.201207113304967.966169756395.1000117']['file_path'].iloc[0]
DICOM_j2ks_join.loc[DICOM_j2ks_join['file_path_j2k'].str.contains('/persist/PACS/DICOM/35223/390753/1.2.276.0.75.2.1.11.1.3.201207113809470.966169756395.1000118', na=False),'file_path_dcm'] = DICOM_dicoms[DICOM_dicoms['basename']=='1.2.276.0.75.2.1.11.1.3.201207113809470.966169756395.1000118']['file_path'].iloc[0]
DICOM_j2ks_join.loc[DICOM_j2ks_join['file_path_j2k'].str.contains('/persist/PACS/DICOM/35223/390753/1.2.276.0.75.2.1.11.1.3.201207114459720.966169756395.1000119', na=False),'file_path_dcm'] = DICOM_dicoms[DICOM_dicoms['basename']=='1.2.276.0.75.2.1.11.1.3.201207114459720.966169756395.1000119']['file_path'].iloc[0]
DICOM_j2ks_join.loc[DICOM_j2ks_join['file_path_j2k'].str.contains('/persist/PACS/DICOM/49557/458020/1.2.276.0.75.2.1.11.1.3.210924133430647.966169756395.1000018', na=False),'file_path_dcm'] = DICOM_dicoms[DICOM_dicoms['basename']=='1.2.276.0.75.2.1.11.1.3.210924133430647.966169756395.1000018']['file_path'].iloc[0]



DICOM_j2ks_join.shape # 1,509,212 ! over total for either so let's break it down

specific_order = ['file_path_j2k', 'file_path_dcm', 'PatientID', 'StudyInstanceUID', 'SeriesInstanceUID',
                  'SOPInstanceUID', 'Modality', 'StudyDate', 'SeriesNumber', 'InstanceNumber', 
                  'AcquisitionDateTime', 'SOPClassUID', 'ImageType', 'MIMETypeOfEncapsulatedDocument', 'InstitutionName', 
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
# header_dicom = ['file_path_j2k', 'mrn', 'basename', 'file_path_dcm', 'StudyInstanceUID', 'SeriesInstanceUID', 'SOPInstanceUID', 'Modality', 'StudyDate', 'SeriesNumber', 'InstanceNumber',  'AcquisitionDateTime', 'SOPClassUID', 'SOPClassDescription', 'ImageType', 'MIMETypeOfEncapsulatedDocument', 'InstitutionName',  'Manufacturer',  'ManufacturerModelName', 'Laterality', 'BitsAllocated', 'PhotometricInterpretation',  'PixelSpacing', 'StationName', 'SeriesDescription', 'StudyTime', 'DocType', 'AverageRNFLThickness',  'OpticCupVolume_mm_squared', 'OpticDiskArea_mm_squared', 'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR']
header_dicom = ['file_path_j2k', 'mrn', 'basename', 'file_path_dcm', 'StudyInstanceUID', 'SeriesInstanceUID', 'SOPInstanceUID', 'Modality', 'StudyDate', 'SeriesNumber', 'InstanceNumber',  'AcquisitionDateTime', 'SOPClassUID', 'ImageType', 'MIMETypeOfEncapsulatedDocument', 'InstitutionName',  'Manufacturer',  'ManufacturerModelName', 'Laterality', 'BitsAllocated', 'PhotometricInterpretation',  'PixelSpacing', 'StationName', 'SeriesDescription', 'StudyTime', 'DocType', 'AverageRNFLThickness',  'OpticCupVolume_mm_squared', 'OpticDiskArea_mm_squared', 'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR']

### superset for both table's columns
all_j2ks = pd.concat([VisupacImages_j2ks_with_xml_metadata[header_vis], DICOM_j2ks_with_dicom_metadata[header_dicom]], ignore_index=True, sort=False)
# duplicates_all_j2ks = all_j2ks[all_j2ks.duplicated(subset=['file_path_dcm'], keep=False)] # you get a lot of rows but it's because it is treating file_path_dcm NA's as duplicates
# duplicates_all_j2ks[~pd.isna(duplicates_all_j2ks['file_path_dcm'])]
# duplicates_all_j2ks[~pd.isna(duplicates_all_j2ks['file_path_dcm'])][['file_path_j2k','file_path_dcm']].to_csv(os.path.join('/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/uveitis_check_for_chris', 'duplicates_all_j2ks.csv'), index=None)
# duplicates_all_j2ks = all_j2ks[all_j2ks.duplicated(subset=['file_path_j2k'], keep=False)] # 0, which is to be expected

all_j2ks.rename(columns={'file_path_j2k':'file_path'}, inplace=True)
# all_j2ks.shape # 15,297,231
# all_j2ks.columns
# all_j2ks_header = ['file_path', 'file_path_xml', 'mrn', 'FirstName', 'LastName', 'DOB', 'Gender', 'ExamDate', 'Laterality', 'DeviceID', 'DataFile', 'ImageWidth', 'ImageNumber', 'ImageHeight', 'ImageGroup', 'ImageFile', 'AttendingPhysician', 'ReportType', 'Pathology', 'Procedure', 'Layer_Name', 'Start_X', 'Start_Y', 'End_X', 'End_Y', 'SizeX', 'SizeZ', 'ScanPattern', 'Scale_X', 'Scale_Y', 'Scale_Z', 'XSlo', 'YSlo', 'TimeStamp_TotalSeconds', 'ImageType', 'file_path_dcm', 'StudyInstanceUID', 'SeriesInstanceUID', 'SOPInstanceUID', 'Modality', 'StudyDate', 'SeriesNumber', 'InstanceNumber', 'AcquisitionDateTime', 'SOPClassUID', 'SOPClassDescription', 'MIMETypeOfEncapsulatedDocument', 'InstitutionName', 'Manufacturer', 'ManufacturerModelName', 'BitsAllocated', 'PhotometricInterpretation', 'PixelSpacing', 'StationName', 'SeriesDescription', 'StudyTime', 'DocType', 'AverageRNFLThickness', 'OpticCupVolume_mm_squared', 'OpticDiskArea_mm_squared', 'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR', 'basename']
all_j2ks_header = ['file_path', 'file_path_xml', 'mrn', 'FirstName', 'LastName', 'DOB', 'Gender', 'ExamDate', 'Laterality', 'DeviceID', 'DataFile', 'ImageWidth', 'ImageNumber', 'ImageHeight', 'ImageGroup', 'ImageFile', 'AttendingPhysician', 'ReportType', 'Pathology', 'Procedure', 'Layer_Name', 'Start_X', 'Start_Y', 'End_X', 'End_Y', 'SizeX', 'SizeZ', 'ScanPattern', 'Scale_X', 'Scale_Y', 'Scale_Z', 'XSlo', 'YSlo', 'TimeStamp_TotalSeconds', 'ImageType', 'file_path_dcm', 'StudyInstanceUID', 'SeriesInstanceUID', 'SOPInstanceUID', 'Modality', 'StudyDate', 'SeriesNumber', 'InstanceNumber', 'AcquisitionDateTime', 'SOPClassUID', 'MIMETypeOfEncapsulatedDocument', 'InstitutionName', 'Manufacturer', 'ManufacturerModelName', 'BitsAllocated', 'PhotometricInterpretation', 'PixelSpacing', 'StationName', 'SeriesDescription', 'StudyTime', 'DocType', 'AverageRNFLThickness', 'OpticCupVolume_mm_squared', 'OpticDiskArea_mm_squared', 'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR', 'basename']
# all_j2ks['StudyDate'] = pd.to_datetime(all_j2ks['StudyDate'].astype("Int64").astype(str), format="%Y%m%d", errors="coerce")


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
duplicates_all_files = all_files[all_files.duplicated(subset=['file_path'], keep=False)]
duplicates_all_files

all_files.shape # 16579720
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