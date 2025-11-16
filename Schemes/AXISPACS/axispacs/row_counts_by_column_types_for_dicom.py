import os, pdb

import pandas as pd
import numpy as np
from tqdm import tqdm

# Enable tqdm for pandas
tqdm.pandas()

axispacs_all = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/all_files_classified.csv")

# axispacs_all.head()
# axispacs_all.columns

# ['file_path', 'file_path_xml', 'mrn', 'FirstName', 'LastName', 'DOB',                                                                                   
#        'Gender', 'ExamDate', 'Laterality', 'DeviceID', 'DataFile',                                                                                            
#        'ImageWidth', 'ImageNumber', 'ImageHeight', 'ImageGroup', 'ImageFile',                                                                                 
#        'AttendingPhysician', 'ReportType', 'Pathology', 'Procedure',                                                                                          
#        'Layer_Name', 'Start_X', 'Start_Y', 'End_X', 'End_Y', 'SizeX', 'SizeZ',                                                                                
#        'ScanPattern', 'Scale_X', 'Scale_Y', 'Scale_Z', 'XSlo', 'YSlo',                                                                                        
#        'TimeStamp_TotalSeconds', 'ImageType', 'file_path_dcm',        
#        'StudyInstanceUID', 'SeriesInstanceUID', 'SOPInstanceUID', 'Modality',
#        'StudyDate', 'SeriesNumber', 'InstanceNumber', 'AcquisitionDateTime', 
#        'SOPClassUID', 'SOPClassDescription', 'MIMETypeOfEncapsulatedDocument',
#        'InstitutionName', 'Manufacturer', 'ManufacturerModelName',            
#        'BitsAllocated', 'PhotometricInterpretation', 'PixelSpacing',
#        'StationName', 'SeriesDescription', 'StudyTime', 'DocType',  
#        'AverageRNFLThickness', 'OpticCupVolume_mm_squared',       
#        'OpticDiskArea_mm_squared', 'RimArea_mm_squared', 'AvgCDR',
#        'VerticalCDR', 'basename']

# axispacs_dicoms = axispacs_all[axispacs_all['file_path'].str.find('.dcm') != -1].groupby(
#     ['SOPClassDescription',
#      'Modality',
#      'Manufacturer',
#      'ManufacturerModelName',
#      'PhotometricInterpretation',
#      'SeriesDescription'],
#     dropna=False
# )['file_path'].size().reset_index(name='count')

# axispacs_dicoms.sort_values('count', ascending=False, inplace=True)
# axispacs_dicoms.to_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/col_counts/axispacs_dicoms_counts.csv", index=None)



### Generate sample
# AFTER ADDING QTIM_Modality Column to axispacs_dicom_counts.csv below
axispacs_dicoms = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/axispacs_image_types_dicom_manually_curated.csv")
axispacs_dicoms_copy = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/axispacs_image_types_dicom_manually_curated copy.csv")

# laser in 
# dicom_group = axispacs_dicoms[
#     ((axispacs_dicoms['SOPClassDescription'] == 'Ophthalmic Tomography Image Storage')) & \
#     # ((axispacs_dicoms['SOPClassDescription'] == '') | (pd.isna(axispacs_dicoms['SOPClassDescription']))) & \

#     # ((axispacs_dicoms['Manufacturer'] == 'NIL Screenshot')) & \
#     ((axispacs_dicoms['Manufacturer'] == 'OPTOS') | (pd.isna(axispacs_dicoms['Manufacturer']))) & \

#     # ((axispacs_dicoms['ManufacturerModelName'] == '')) & \
#     ((axispacs_dicoms['ManufacturerModelName'] == 'P200TxE') | (pd.isna(axispacs_dicoms['ManufacturerModelName']))) & \

#     ((axispacs_dicoms['PhotometricInterpretation'] == 'MONOCHROME2')) & \
#     # ((axispacs_dicoms['PhotometricInterpretation'] == '') | (pd.isna(axispacs_dicoms['PhotometricInterpretation']))) & \

#     # ((axispacs_dicoms['SeriesDescription'] == ''))
#     ((axispacs_dicoms['SeriesDescription'] == 'UWF Navigated OCT Line') | (pd.isna(axispacs_dicoms['SeriesDescription'])))
# ]


# Example of returning multiple rows in an apply function
def match_or_na(col, val):
    return (pd.isna(val) & pd.isna(col)) | (col.eq(val))


def expand_rows(row, n=3):
    filtered_df = axispacs_all[
        axispacs_all['file_path'].str.contains('.dcm', na=False) &
        match_or_na(axispacs_all['SOPClassDescription'], row['SOPClassDescription']) &
        match_or_na(axispacs_all['Modality'], row['Modality']) &
        match_or_na(axispacs_all['Manufacturer'], row['Manufacturer']) &
        match_or_na(axispacs_all['ManufacturerModelName'], row['ManufacturerModelName']) &
        match_or_na(axispacs_all['PhotometricInterpretation'], row['PhotometricInterpretation']) &
        match_or_na(axispacs_all['SeriesDescription'], row['SeriesDescription'])
    ]
    # pdb.set_trace()
    filtered_df = filtered_df.sample(n=n, random_state=42)
    return filtered_df

# do_these = axispacs_dicoms[(axispacs_dicoms['count'] > 10) & (axispacs_dicoms['count'] <= 107)]
# do_these = axispacs_dicoms[(axispacs_dicoms['count'] > 2) & (axispacs_dicoms['count'] <= 10)]
# do_these = axispacs_dicoms[(axispacs_dicoms['count'] <= 10)]
do_these = axispacs_dicoms[(axispacs_dicoms['count'] == 2)]
do_these = axispacs_dicoms[(axispacs_dicoms['count'] == 1)]

do_these = do_these[do_these['SOPClassDescription'] == 'Ophthalmic Tomography Image Storage']

# Apply the function and concatenate the results
# expanded_df = pd.concat(do_these.postgres_apply(expand_rows, n=2, axis=1).tolist(), ignore_index=True)
# expanded_df = pd.concat(do_these.apply(expand_rows, n=1, axis=1).tolist(), ignore_index=True)
expanded_df = pd.concat(axispacs_dicoms_copy.apply(expand_rows, n=3, axis=1).tolist(), ignore_index=True)

expanded_df_w_qtim_modality = pd.merge(expanded_df, axispacs_dicoms, how='inner', on=[
    'SOPClassDescription',
    'Modality',
    'Manufacturer',
    'ManufacturerModelName',
    'PhotometricInterpretation',
    'SeriesDescription'
])
expanded_df_w_qtim_modality.columns


# Save the expanded DataFrame to a new CSV
# expanded_df.columns
# header = ['basename','SOPClassDescription','Modality','Manufacturer','ManufacturerModelName','PhotometricInterpretation','SeriesDescription']
header = ['QTIM_Modality','SOPClassDescription','Modality','Manufacturer','ManufacturerModelName','PhotometricInterpretation','SeriesDescription','file_path','Misc','count']
expanded_df_w_qtim_modality[header].to_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/col_counts/dicoms_preview.csv", index=None)