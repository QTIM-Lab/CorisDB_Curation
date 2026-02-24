import os, pdb
import pandas as pd
import numpy as np
from tqdm import tqdm

# Enable tqdm for pandas
tqdm.pandas()

if __name__ == "__main__":
    topcon_dicom_counts = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/TOPCON_OCULOMICS/col_counts/topcon_dicom_counts.csv")
    # topcon_dicom_counts.columns
    topcon_dicom_counts['QTIM_Modality'] = np.nan
    topcon_dicom_counts['Raw_Type'] = np.nan
    topcon_dicom_counts['Misc'] = np.nan
    topcon_dicom_counts.to_csv("/scratch90/QTIM/Active/23-0284/EHR/TOPCON_OCULOMICS/col_counts/topcon_image_types_dicom.csv")
    # pdb.set_trace()

