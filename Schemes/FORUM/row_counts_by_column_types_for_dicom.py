import os, pdb

import pandas as pd
import numpy as np
from tqdm import tqdm

# Enable tqdm for pandas
tqdm.pandas()

forum_all = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/FORUM/parsed/forum_parse_dicom_for_postgres_.csv")

# forum_all.head()
# forum_all.columns

# ['file_path', 'mrn', 'StudyInstanceUID', 'SeriesInstanceUID',
#    'SOPInstanceUID', 'Modality', 'StudyDate', 'SeriesNumber',
#    'InstanceNumber', 'AcquisitionDateTime', 'SOPClassUID',
#    'SOPClassDescription', 'ImageType', 'MIMETypeOfEncapsulatedDocument',
#    'InstitutionName', 'Manufacturer', 'ManufacturerModelName',
#    'Laterality', 'BitsAllocated', 'PhotometricInterpretation',
#    'PixelSpacing', 'StationName', 'SeriesDescription', 'StudyTime',
#    'DocType', 'AverageRNFLThickness', 'OpticCupVolume_mm_squared',
#    'OpticDiskArea_mm_squared', 'RimArea_mm_squared', 'AvgCDR',
#    'VerticalCDR']

forum_dicoms = forum_all[forum_all['file_path'].str.find('.dcm') != -1].groupby(
    ['SOPClassDescription',
     'Modality',
     'Manufacturer',
     'ManufacturerModelName',
     'PhotometricInterpretation',
     'SeriesDescription'],
    dropna=False
)['file_path'].size().reset_index(name='count')

forum_dicoms.sort_values('count', ascending=False, inplace=True)
forum_dicoms.to_csv("/scratch90/QTIM/Active/23-0284/EHR/FORUM/col_counts/forum_dicom_counts.csv", index=None)



### Generate sample
# AFTER ADDING QTIM_Modality Column to forum_dicom_counts.csv below
forum_dicoms = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/FORUM/col_counts/forum_image_types_dicom_manually_curated.csv")

# laser in 
# dicom_group = forum_dicoms[
#     ((forum_dicoms['SOPClassDescription'] == 'Ophthalmic Tomography Image Storage')) & \
#     # ((forum_dicoms['SOPClassDescription'] == '') | (pd.isna(forum_dicoms['SOPClassDescription']))) & \

#     # ((forum_dicoms['Manufacturer'] == 'NIL Screenshot')) & \
#     ((forum_dicoms['Manufacturer'] == 'OPTOS') | (pd.isna(forum_dicoms['Manufacturer']))) & \

#     # ((forum_dicoms['ManufacturerModelName'] == '')) & \
#     ((forum_dicoms['ManufacturerModelName'] == 'P200TxE') | (pd.isna(forum_dicoms['ManufacturerModelName']))) & \

#     ((forum_dicoms['PhotometricInterpretation'] == 'MONOCHROME2')) & \
#     # ((forum_dicoms['PhotometricInterpretation'] == '') | (pd.isna(forum_dicoms['PhotometricInterpretation']))) & \

#     # ((forum_dicoms['SeriesDescription'] == ''))
#     ((forum_dicoms['SeriesDescription'] == 'UWF Navigated OCT Line') | (pd.isna(forum_dicoms['SeriesDescription'])))
# ]


# Example of returning multiple rows in an apply function
def match_or_na(col, val):
    return (pd.isna(val) & pd.isna(col)) | (col.eq(val))


def expand_rows(row, n=3):
    filtered_df = forum_all[
        forum_all['file_path'].str.contains('.dcm', na=False) &
        match_or_na(forum_all['SOPClassDescription'], row['SOPClassDescription']) &
        match_or_na(forum_all['Modality'], row['Modality']) &
        match_or_na(forum_all['Manufacturer'], row['Manufacturer']) &
        match_or_na(forum_all['ManufacturerModelName'], row['ManufacturerModelName']) &
        match_or_na(forum_all['PhotometricInterpretation'], row['PhotometricInterpretation']) &
        match_or_na(forum_all['SeriesDescription'], row['SeriesDescription'])
    ]
    # pdb.set_trace()
    filtered_df = filtered_df.sample(n=n, random_state=42)
    return filtered_df




do_these = forum_dicoms[
             (forum_dicoms['count'] == 71685) | # 1
             (forum_dicoms['count'] == 71676) |  # 2
             (forum_dicoms['count'] == 25705) | # 3
             (forum_dicoms['count'] == 25120) | # 4
             ((forum_dicoms['count'] == 18832) & (forum_dicoms['QTIM_Modality'] == 'OCT Bscan Vol 128')) | # 5
             ((forum_dicoms['count'] == 18832) & (forum_dicoms['QTIM_Modality'] == 'OCT IR En Face')) | # 6
             ((forum_dicoms['count'] == 16004) & (forum_dicoms['QTIM_Modality'] == 'OCT Bscan Vol 21')) | # 7
             ((forum_dicoms['count'] == 16004) & (forum_dicoms['QTIM_Modality'] == 'OCT IR En Face')) | # 8
             ((forum_dicoms['count'] == 9560) & (forum_dicoms['QTIM_Modality'] == 'OCT Bscan Vol 5')) | # 9
             ((forum_dicoms['count'] == 9560) & (forum_dicoms['QTIM_Modality'] == 'OCT IR En Face')) | # 10
             ((forum_dicoms['count'] == 3698) & (forum_dicoms['QTIM_Modality'] == 'OCT Bscan Vol 5')) | # 11
             ((forum_dicoms['count'] == 3698) & (forum_dicoms['QTIM_Modality'] == 'OCT IR En Face')) | # 12
             (forum_dicoms['count'] == 3377) | # 13
             (forum_dicoms['count'] == 3376) | # 14
             ((forum_dicoms['count'] == 2962) & (forum_dicoms['QTIM_Modality'] == 'OCT Bscan Vol 5')) | # 15
             ((forum_dicoms['count'] == 2962) & (forum_dicoms['QTIM_Modality'] == 'OCT IR En Face')) | # 16
             ((forum_dicoms['count'] == 391) & (forum_dicoms['QTIM_Modality'] == 'OCT IR En Face')) | # 17
             ((forum_dicoms['count'] == 390) & (forum_dicoms['QTIM_Modality'] == 'OCT Bscan Vol 128')) | # 18
             ((forum_dicoms['count'] == 337) & (forum_dicoms['QTIM_Modality'] == 'OCT IR En Face')) | # 19
             ((forum_dicoms['count'] == 337) & (forum_dicoms['QTIM_Modality'] == 'OCT Bscan Vol 5')) | # 20
             ((forum_dicoms['count'] == 118) & (forum_dicoms['QTIM_Modality'] == 'OCT Bscan Vol 21')) | # 21
             ((forum_dicoms['count'] == 118) & (forum_dicoms['QTIM_Modality'] == 'OCT IR En Face')) | # 22
             ((forum_dicoms['count'] == 47) & (forum_dicoms['QTIM_Modality'] == 'OCT Bscan Vol')) | # 23
             ((forum_dicoms['count'] == 47) & (forum_dicoms['QTIM_Modality'] == 'OCT IR En Face')) | # 24
             ((forum_dicoms['count'] == 34) & (forum_dicoms['QTIM_Modality'] == 'OCT IR En Face')) | # 25
             ((forum_dicoms['count'] == 34) & (forum_dicoms['QTIM_Modality'] == 'OCT')) | # 26
             ((forum_dicoms['count'] == 29) & (forum_dicoms['QTIM_Modality'] == 'OCT Bscan Single')) | # 27 
             ((forum_dicoms['count'] == 29) & (forum_dicoms['QTIM_Modality'] == 'OCT IR En Face')) | # 28
             ((forum_dicoms['count'] == 24) & (forum_dicoms['QTIM_Modality'] == 'IR En Face')) | # 29
             ((forum_dicoms['count'] == 24) & (forum_dicoms['QTIM_Modality'] == 'OCT')) | # 30
             ((forum_dicoms['count'] == 12) & (forum_dicoms['QTIM_Modality'] == 'OCT Vol')) | # 31
             ((forum_dicoms['count'] == 12) & (forum_dicoms['QTIM_Modality'] == 'En Face')) | # 32
             ((forum_dicoms['count'] == 9) & (forum_dicoms['QTIM_Modality'] == 'OCT Bscan Vol')) | # 33
             ((forum_dicoms['count'] == 9) & (forum_dicoms['QTIM_Modality'] == 'En Face')) | # 34
             ((forum_dicoms['count'] == 7) & (forum_dicoms['QTIM_Modality'] == 'En Face')) | # 
             ((forum_dicoms['count'] == 7) & (forum_dicoms['QTIM_Modality'] == 'OCT')) | # 
             ((forum_dicoms['count'] == 3) & (forum_dicoms['QTIM_Modality'] == 'OCT')) | # 
             ((forum_dicoms['count'] == 3) & (forum_dicoms['QTIM_Modality'] == 'En Face')) # 38
            #  ((forum_dicoms['count'] == 1) & (forum_dicoms['QTIM_Modality'] == 'En Face')) | # 
            #  ((forum_dicoms['count'] == 1) & (forum_dicoms['QTIM_Modality'] == 'OCT')) # 40
] # [['Misc', 'count']]
do_these.shape


# do_these = forum_dicoms[(forum_dicoms['count'] >= 71685)]
# do_these = forum_dicoms[(forum_dicoms['count'] >= 28850) & (forum_dicoms['count'] < 71685)]
# do_these = forum_dicoms[(forum_dicoms['count'] >= 9866) & (forum_dicoms['count'] < 28850)]
# do_these = forum_dicoms[(forum_dicoms['count'] >= 1807) & (forum_dicoms['count'] < 9866)]
# do_these = forum_dicoms[(forum_dicoms['count'] >= 94) & (forum_dicoms['count'] < 1807)]
# do_these = forum_dicoms[(forum_dicoms['count'] >= 25) & (forum_dicoms['count'] < 94)]
# do_these = forum_dicoms[(forum_dicoms['count'] >= 3) & (forum_dicoms['count'] < 25)]
# do_these = forum_dicoms[(forum_dicoms['count'] == 2)]
# do_these = forum_dicoms[(forum_dicoms['count'] == 1)]


# Apply the function and concatenate the results
expanded_df = pd.concat(do_these.apply(expand_rows, n=3, axis=1).tolist(), ignore_index=True)
expanded_df = pd.concat(do_these.apply(expand_rows, n=2, axis=1).tolist(), ignore_index=True)
expanded_df = pd.concat(do_these.apply(expand_rows, n=1, axis=1).tolist(), ignore_index=True)

expanded_df_w_qtim_modality = pd.merge(expanded_df, forum_dicoms, how='inner', on=[
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
expanded_df_w_qtim_modality[header].to_csv("/scratch90/QTIM/Active/23-0284/EHR/FORUM/col_counts/dicoms_preview.csv", index=None)