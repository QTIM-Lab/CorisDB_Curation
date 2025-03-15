import os, pandas as pd
from DICOMParser import DICOMParser

base_path = "/scratch90/QTIM/Active/23-0284/dashboard/hvf_extraction_script/hvf_investigation/"
file="OPV_hvfs.csv"

df = pd.read_csv(os.path.join(base_path,file))

# dicom_file = df['filenamepath'][0]

parser = DICOMParser.create_parser(dicom_file) # Factory method selects subclass
# parsed_metadata = parser.parse()
# print(parsed_metadata.keys())
parser.write_parsed('/scratch90/QTIM/Active/23-0284/dashboard/hvf_extraction_script/hvf_investigation/object_dumps/')
