import os, pdb

import pandas as pd
import numpy as np
from tqdm import tqdm

# Enable tqdm for pandas
tqdm.pandas()


if __name__ == "__main__":
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
        'SeriesDescription',
        "DocumentTitle"],
        dropna=False
    )['file_path'].size().reset_index(name='count')

    topcon_dicoms.sort_values('count', ascending=False, inplace=True)
    topcon_dicoms.to_csv("/scratch90/QTIM/Active/23-0284/EHR/TOPCON_OCULOMICS/col_counts/topcon_dicom_counts.csv", index=None)

