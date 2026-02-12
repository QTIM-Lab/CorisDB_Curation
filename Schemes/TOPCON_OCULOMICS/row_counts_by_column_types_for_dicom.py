import os, pdb

import pandas as pd
import numpy as np
from tqdm import tqdm

# Enable tqdm for pandas
tqdm.pandas()

topcon_all = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/TOPCON_OCULOMICS/parsed/topcon_oculomics_parse_dicom_for_postgres.csv")

# topcon_all.head()
# topcon_all.columns

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

topcon_dicoms = topcon_all[topcon_all['file_path'].str.find('.dcm') != -1].groupby(
    ['SOPClassDescription',
     'Modality',
     'Manufacturer',
     'ManufacturerModelName',
     'PhotometricInterpretation',
     'SeriesDescription'],
    dropna=False
)['file_path'].size().reset_index(name='count')

topcon_dicoms.sort_values('count', ascending=False, inplace=True)
topcon_dicoms.to_csv("/scratch90/QTIM/Active/23-0284/EHR/TOPCON_OCULOMICS/col_counts/topcon_dicom_counts.csv", index=None)



### Generate sample
# AFTER ADDING QTIM_Modality Column to topcon_dicom_counts.csv below
topcon_dicoms = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/TOPCON_OCULOMICS/col_counts/topcon_image_types_dicom_manually_curated.csv")

# laser in (exploratory)
# dicom_group = topcon_dicoms[
#     ((topcon_dicoms['SOPClassDescription'] == 'Ophthalmic Tomography Image Storage')) & \
#     # ((topcon_dicoms['SOPClassDescription'] == '') | (pd.isna(topcon_dicoms['SOPClassDescription']))) & \

#     # ((topcon_dicoms['Manufacturer'] == 'NIL Screenshot')) & \
#     ((topcon_dicoms['Manufacturer'] == 'OPTOS') | (pd.isna(topcon_dicoms['Manufacturer']))) & \

#     # ((topcon_dicoms['ManufacturerModelName'] == '')) & \
#     ((topcon_dicoms['ManufacturerModelName'] == 'P200TxE') | (pd.isna(topcon_dicoms['ManufacturerModelName']))) & \

#     ((topcon_dicoms['PhotometricInterpretation'] == 'MONOCHROME2')) & \
#     # ((topcon_dicoms['PhotometricInterpretation'] == '') | (pd.isna(topcon_dicoms['PhotometricInterpretation']))) & \

#     # ((topcon_dicoms['SeriesDescription'] == ''))
#     ((topcon_dicoms['SeriesDescription'] == 'UWF Navigated OCT Line') | (pd.isna(topcon_dicoms['SeriesDescription'])))
# ]


# Example of returning multiple rows in an apply function
def match_or_na(col, val):
    return (pd.isna(val) & pd.isna(col)) | (col.eq(val))


def expand_rows(row, n=3):
    filtered_df = topcon_all[
        topcon_all['file_path'].str.contains('.dcm', na=False) &
        match_or_na(topcon_all['SOPClassDescription'], row['SOPClassDescription']) &
        match_or_na(topcon_all['Modality'], row['Modality']) &
        match_or_na(topcon_all['Manufacturer'], row['Manufacturer']) &
        match_or_na(topcon_all['ManufacturerModelName'], row['ManufacturerModelName']) &
        match_or_na(topcon_all['PhotometricInterpretation'], row['PhotometricInterpretation']) &
        match_or_na(topcon_all['SeriesDescription'], row['SeriesDescription'])
    ]
    # pdb.set_trace()
    filtered_df = filtered_df.sample(n=n, random_state=42)
    return filtered_df




do_these = topcon_dicoms[
             (topcon_dicoms['count'] == 141) |
             (topcon_dicoms['count'] == 57) |
             (topcon_dicoms['count'] == 51) |
             (topcon_dicoms['count'] == 43) |
             (topcon_dicoms['count'] == 40) |
             (topcon_dicoms['count'] == 25) |
             (topcon_dicoms['count'] == 22) |
             (topcon_dicoms['count'] == 21) |
             (topcon_dicoms['count'] == 16) |
             (topcon_dicoms['count'] == 14) |
             (topcon_dicoms['count'] == 12) |
             (topcon_dicoms['count'] == 11) |
             (topcon_dicoms['count'] == 10) |
             (topcon_dicoms['count'] == 9) |
             ((topcon_dicoms['count'] == 8) & (topcon_dicoms['SeriesDescription'] == 'OCT 3D H Disc')) |
             ((topcon_dicoms['count'] == 8) & (topcon_dicoms['SeriesDescription'] == 'FundusPhoto')) |
             ((topcon_dicoms['count'] == 7) & (topcon_dicoms['SeriesDescription'] == 'OCT Line Macula')) |
             ((topcon_dicoms['count'] == 7) & (topcon_dicoms['SeriesDescription'] == 'OCT 5LineCross Macula')) |
             ((topcon_dicoms['count'] == 7) & (topcon_dicoms['SeriesDescription'] == 'OCT 3D H Macula')) |
             ((topcon_dicoms['count'] == 6) & (topcon_dicoms['ManufacturerModelName'] == 'Maestro2') & (topcon_dicoms['SeriesDescription'] == 'FundusPhoto')) |
             ((topcon_dicoms['count'] == 6) & (topcon_dicoms['ManufacturerModelName'] == 'Maestro2') & (topcon_dicoms['SeriesDescription'] == 'OCT')) |
             ((topcon_dicoms['count'] == 6) & (topcon_dicoms['ManufacturerModelName'] == 'Triton plus') & (topcon_dicoms['SeriesDescription'] == 'FundusPhoto')) |
             ((topcon_dicoms['count'] == 6) & (topcon_dicoms['PhotometricInterpretation'] == 'MONOCHROME2') & (topcon_dicoms['SeriesDescription'] == 'OCT')) |
             ((topcon_dicoms['count'] == 6) & (topcon_dicoms['SeriesDescription'] == 'OCT 5LineCross Macula')) |
             (topcon_dicoms['count'] == 5) |
             ((topcon_dicoms['count'] == 4) & (topcon_dicoms['ManufacturerModelName'] == '3D OCT-1') & (topcon_dicoms['SeriesDescription'] == 'OCT Line External')) |
             ((topcon_dicoms['count'] == 4) & (topcon_dicoms['SeriesDescription'] == 'FundusPhoto')) |
             ((topcon_dicoms['count'] == 4) & (topcon_dicoms['SeriesDescription'] == 'OCT Radial External')) |
             ((topcon_dicoms['count'] == 4) & (topcon_dicoms['ManufacturerModelName'] == 'Triton plus') & (topcon_dicoms['SeriesDescription'] == 'OCT Line External')) |
             ((topcon_dicoms['count'] == 2) & (topcon_dicoms['PhotometricInterpretation'] == 'YBR_FULL_422') & (topcon_dicoms['SeriesDescription'] == 'OCT')) |
             ((topcon_dicoms['count'] == 2) & (topcon_dicoms['SeriesDescription'] == 'OCT 5LineCross Macula')) |
             ((topcon_dicoms['count'] == 2) & (topcon_dicoms['SeriesDescription'] == 'OCT')) |
             ((topcon_dicoms['count'] == 2) & (topcon_dicoms['SeriesDescription'] == 'OCT 3D H Disc')) |
             ((topcon_dicoms['count'] == 2) & (topcon_dicoms['PhotometricInterpretation'] == 'MONOCHROME2') & (topcon_dicoms['SeriesDescription'] == 'OCT Radial External')) |
             ((topcon_dicoms['count'] == 1) & (topcon_dicoms['PhotometricInterpretation'] == 'MONOCHROME2') & (topcon_dicoms['SeriesDescription'] == 'OCT')) |
             ((topcon_dicoms['count'] == 1) & (topcon_dicoms['PhotometricInterpretation'] == 'RGB') & (topcon_dicoms['SeriesDescription'] == 'OCT'))
] # [['Misc', 'count']]
do_these.shape


# do_these = topcon_dicoms[(topcon_dicoms['count'] >= 71685)]
# do_these = topcon_dicoms[(topcon_dicoms['count'] >= 28850) & (topcon_dicoms['count'] < 71685)]
# do_these = topcon_dicoms[(topcon_dicoms['count'] >= 9866) & (topcon_dicoms['count'] < 28850)]
# do_these = topcon_dicoms[(topcon_dicoms['count'] >= 1807) & (topcon_dicoms['count'] < 9866)]
# do_these = topcon_dicoms[(topcon_dicoms['count'] >= 94) & (topcon_dicoms['count'] < 1807)]
# do_these = topcon_dicoms[(topcon_dicoms['count'] >= 25) & (topcon_dicoms['count'] < 94)]
# do_these = topcon_dicoms[(topcon_dicoms['count'] >= 3) & (topcon_dicoms['count'] < 25)]
# do_these = topcon_dicoms[(topcon_dicoms['count'] == 2)]
# do_these = topcon_dicoms[(topcon_dicoms['count'] == 1)]


# Apply the function and concatenate the results
expanded_df = pd.concat(do_these.apply(expand_rows, n=3, axis=1).tolist(), ignore_index=True)
expanded_df = pd.concat(do_these.apply(expand_rows, n=2, axis=1).tolist(), ignore_index=True)
expanded_df = pd.concat(do_these.apply(expand_rows, n=1, axis=1).tolist(), ignore_index=True)

expanded_df_w_qtim_modality = pd.merge(expanded_df, topcon_dicoms, how='inner', on=[
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
expanded_df_w_qtim_modality[header].to_csv("/scratch90/QTIM/Active/23-0284/EHR/TOPCON_OCULOMICS/col_counts/dicoms_preview.csv", index=None)