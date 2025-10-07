import os, re, pdb
from tqdm import tqdm
import pandas as pd
import numpy as np

# Enable tqdm for pandas
tqdm.pandas()

axispacs_all = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/all_files.csv")

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

# Parsed Image Group Col


def parse_image_group(image_group_str):
    """
    Extracts the descriptive part (e.g., 'OD Volume') from strings like:
    'OD Volume (243706)' or '(243706) OD Volume'
    """
    if not image_group_str or not isinstance(image_group_str, str):
        return None
    # pdb.set_trace()
    # Remove the number in parentheses and any extra whitespace
    # This pattern matches parentheses with numbers inside
    # image_group_str = 'OD Volume (3333333.000)'
    # image_group_str = '(3333333) OD Volume'
    # image_group_str = '0'
    # image_group_str = '1'
    cleaned = re.sub(r'\([0-9.]+\)', '', image_group_str).strip()
    return cleaned



axispacs_all['ParsedImageGroup'] = axispacs_all['ImageGroup'].apply(parse_image_group)
# axispacs_all[~pd.isna(axispacs_all['ParsedImageGroup'])]['ParsedImageGroup'].unique()

# axispacs_xmls = axispacs_all[~pd.isna(axispacs_all['file_path_xml'])].groupby(
#     ['ImageType', 'ParsedImageGroup', 'ReportType', 'Layer_Name', 'Procedure', 'ScanPattern'],
#     dropna=False
# )['file_path'].size().reset_index(name='count')

# axispacs_xmls.sort_values('count', ascending=False, inplace=True)

# axispacs_xmls.to_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/col_counts/axispacs_xmls_counts.csv", index=None)
# axispacs_all[~pd.isna(axispacs_all['file_path_xml'])].head()
# axispacs_xmls.head(20)
# axispacs_all.columns
# .to_dict()



### Generate sample
# AFTER ADDING QTIM_Modality Column to axispacs_dicom_counts.csv below
axispacs_xmls = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/col_counts/axispacs_image_types_j2k_manually_curated.csv")

# Helper: match a value or NA
def match_or_na(col, val):
    return (pd.isna(val) & pd.isna(col)) | (col.eq(val))


# Example of returning multiple rows in an apply function
def expand_rows(row, n=3):
        filtered_df = axispacs_all[
            axispacs_all['file_path'].str.contains('.j2k', na=False) &
            match_or_na(axispacs_all['ImageType'], row['ImageType']) &
            match_or_na(axispacs_all['ParsedImageGroup'], row['ParsedImageGroup']) &
            match_or_na(axispacs_all['ReportType'], row['ReportType']) &
            match_or_na(axispacs_all['Layer_Name'], row['Layer_Name']) &
            match_or_na(axispacs_all['Procedure'], row['Procedure']) &
            match_or_na(axispacs_all['ScanPattern'], row['ScanPattern'])
        ]
        # pdb.set_trace()
        filtered_df = filtered_df.sample(n=n, replace=False)
        return filtered_df


# Apply the function and concatenate the results
# do_these = axispacs_xmls[(axispacs_xmls['count'] > 545) & (axispacs_xmls['count'] <= 1052)]
# do_these = axispacs_xmls[(axispacs_xmls['count'] > 266) & (axispacs_xmls['count'] <= 545)]
# do_these = axispacs_xmls[(axispacs_xmls['count'] > 95) & (axispacs_xmls['count'] <= 266)]
# do_these = axispacs_xmls[(axispacs_xmls['count'] > 28) & (axispacs_xmls['count'] <= 95)]
# do_these = axispacs_xmls[(axispacs_xmls['count'] > 8) & (axispacs_xmls['count'] <= 28)]
# do_these = axispacs_xmls[(axispacs_xmls['count'] > 2) & (axispacs_xmls['count'] <= 8)]
# do_these = axispacs_xmls[(axispacs_xmls['count'] == 2)]
do_these = axispacs_xmls[(axispacs_xmls['count'] == 1)]


expanded_df = pd.concat(do_these.progress_apply(expand_rows, n=1, axis=1).tolist(), ignore_index=True)
expanded_df_w_qtim_modality = pd.merge(expanded_df, axispacs_xmls, how='inner', on=[
    'ImageType',
    'ParsedImageGroup',
    'ReportType',
    'Layer_Name',
    'Procedure',
    'ScanPattern'
])
expanded_df_w_qtim_modality.columns


# Save the expanded DataFrame to a new CSV
# expanded_df.columns
header = ['QTIM_Modality','ImageType','ParsedImageGroup','ReportType','Layer_Name','Procedure','ScanPattern','file_path','Misc','count']
expanded_df_w_qtim_modality[header].to_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/col_counts/xmls_preview.csv", index=None)