import os, pandas as pd, pdb
from DICOMParser import DICOMParser

base_path = "/scratch90/QTIM/Active/23-0284/dashboard/Data/oct_op_investigation"
file="OP_octs.csv"
file="all_OP_octs.csv"

df = pd.read_csv(os.path.join(base_path,file))


cirrus_5000 = df[df['manufacturermodelname'] == 'CIRRUS HD-OCT 5000']
cirrus_6000 = df[df['manufacturermodelname'] == 'CIRRUS HD-OCT 6000']
IOLMaster_700 = df[df['manufacturermodelname'] == 'IOLMaster 700']
Humphrey_Field_Analyzer_3 = df[df['manufacturermodelname'] == 'Humphrey Field Analyzer 3']
CLARUS_700 = df[df['manufacturermodelname'] == 'CLARUS 700']



cirrus_5000_files = cirrus_5000['filenamepath']
for file in cirrus_5000_files:
    # pdb.set_trace()
    dicom_file = os.path.join(file)
    parser = DICOMParser.create_parser(dicom_file) # Factory method selects subclass
    parser.preview('/scratch90/QTIM/Active/23-0284/dashboard/Data/oct_op_investigation/object_dumps/cirrus_5000')



cirrus_6000_files = cirrus_6000['filenamepath']
for file in cirrus_6000_files:
    dicom_file = os.path.join(file)
    parser = DICOMParser.create_parser(dicom_file) # Factory method selects subclass
    parser.preview('/scratch90/QTIM/Active/23-0284/dashboard/Data/oct_op_investigation/object_dumps/cirrus_6000')



IOLMaster_700_files = IOLMaster_700['filenamepath']
for file in IOLMaster_700_files:
    dicom_file = os.path.join(file)
    parser = DICOMParser.create_parser(dicom_file) # Factory method selects subclass
    parser.preview('/scratch90/QTIM/Active/23-0284/dashboard/Data/oct_op_investigation/object_dumps/IOLMaster_700')



Humphrey_Field_Analyzer_3_files = Humphrey_Field_Analyzer_3['filenamepath']
for file in Humphrey_Field_Analyzer_3_files:
    dicom_file = os.path.join(file)
    parser = DICOMParser.create_parser(dicom_file) # Factory method selects subclass
    parser.preview('/scratch90/QTIM/Active/23-0284/dashboard/Data/oct_op_investigation/object_dumps/Humphrey_Field_Analyzer_3')



CLARUS_700_files = CLARUS_700['filenamepath']
for file in CLARUS_700_files:
    dicom_file = os.path.join(file)
    parser = DICOMParser.create_parser(dicom_file) # Factory method selects subclass
    parser.preview('/scratch90/QTIM/Active/23-0284/dashboard/Data/oct_op_investigation/object_dumps/CLARUS_700')


# parser = DICOMParser.create_parser(dicom_file) # Factory method selects subclass
# parser.preview('/scratch90/QTIM/Active/23-0284/dashboard/Data/oct_op_investigation/object_dumps/')
