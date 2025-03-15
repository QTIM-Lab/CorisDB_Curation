import os, pandas as pd
from DICOMParser import DICOMParser

base_path = "/scratch90/QTIM/Active/23-0284/dashboard/Data/oct_opt_investigation"
file="OPT_octs.csv"

df = pd.read_csv(os.path.join(base_path,file))

# dicom_files = df['filenamepath']

# for file in dicom_files:
#     dicom_file = os.path.join(base_path,file)
#     parser = DICOMParser.create_parser(dicom_file) # Factory method selects subclass
#     parser.preview('/scratch90/QTIM/Active/23-0284/dashboard/Data/oct_investigation/object_dumps/')

parser = DICOMParser.create_parser(dicom_file) # Factory method selects subclass
parser.preview('/scratch90/QTIM/Active/23-0284/dashboard/Data/oct_opt_investigation/object_dumps/')
