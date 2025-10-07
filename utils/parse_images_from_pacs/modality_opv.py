import os, pandas as pd, pdb
from DICOMParser import DICOMParser
from pydicom import dcmread

base_path = "/scratch90/QTIM/Active/23-0284/dashboard/Data/hvf_opv_investigation"
file="OPV_hvfs.csv"

df = pd.read_csv(os.path.join(base_path,file))

pdfs = df[(df['manufacturermodelname'] == 'FORUM Glaucoma Workplace') & \
          (df['sopclassuiddescription'] == 'Encapsulated PDF Storage')]

perimetry_measurements = df[(df['manufacturermodelname'] == 'FORUM Glaucoma Workplace') & \
                                   (df['sopclassuiddescription'] == 'Ophthalmic Visual Field Static Perimetry Measurements Storage')]

spatial_registrations = df[(df['manufacturermodelname'] == 'HFA 3') & \
                       (df['sopclassuiddescription'] == 'Spatial Registration Storage')]



patients_pdfs = set() # 988
visits_pdfs = set() # 995
for file in pdfs['filenamepath']:
    dicom_file = os.path.join(file)
    pdb.set_trace()
    parser = DICOMParser.create_parser(dicom_file) # Factory method selects subclass
    # track patients
    patients_pdfs.update([str(parser.patient_id)])
    # track visits
    visits_pdfs.update([f"mrn:{parser.patient_id} study_date:{parser.study_date}"])
    parser.preview('/scratch90/QTIM/Active/23-0284/dashboard/Data/hvf_opv_investigation/object_dumps/pdfs/')


count_failed = 0
patients_perimetry_measurements = set()
len(patients_perimetry_measurements) # 959
visits_perimetry_measurements = set() 
len(visits_perimetry_measurements) # 965
SOPInstanceUIDs = set() 
perimetry_measurements['manufacturermodelname']
for file in perimetry_measurements['filenamepath']:
    try:
        dicom_file = os.path.join(file)
        parser = DICOMParser.create_parser(dicom_file) # Factory method selects subclass
        parser.preview('/scratch90/QTIM/Active/23-0284/dashboard/Data/hvf_opv_investigation/object_dumps/perimetry_measurements')
        # track patients
        patients_perimetry_measurements.update([str(parser.patient_id)])
        # track visits
        visits_perimetry_measurements.update([f"mrn:{parser.patient_id} study_date:{parser.study_date}"])
    except:
        # track SOPs
        SOPInstanceUIDs.update([f"{parser.sop_instance}"])
        # pdb.set_trace()
        count_failed += 1

print(count_failed)


len(SOPInstanceUIDs) # 85
pd.DataFrame({"sops":list(SOPInstanceUIDs)}).to_csv(os.path.join(base_path, "problem_sops_perimetry_measurements.csv"))
mrns = set()
visits_perimetry_errors = set()
for sop_instance_uid in SOPInstanceUIDs:
    dicom_file = os.path.join("/persist/PACS/forum_all/2025/01/", sop_instance_uid + ".dcm")
    ds = dcmread(dicom_file)
    mrns.update([ds.PatientID])
    visits_perimetry_errors.update([f"mrn:{ds.PatientID} study_date:{ds.StudyDate}"])
        

# Works Example
# dicom_file = "/scratch90/QTIM/Active/23-0284/dashboard/Data/hvf_opv_investigation/object_dumps/1.2.276.0.75.2.5.80.25.3.250102074432901.345051330900.1630368589.dcm"
# parser = DICOMParser.create_parser(dicom_file) # Factory method selects subclass
# parser.preview('/scratch90/QTIM/Active/23-0284/dashboard/Data/hvf_opv_investigation/object_dumps/perimetry_measurements')

# Error Example
# dicom_file = "/scratch90/QTIM/Active/23-0284/dashboard/Data/hvf_opv_investigation/object_dumps/1.2.276.0.75.2.5.80.25.3.250102102911741.345051330900.1630405235.dcm"
# parser = DICOMParser.create_parser(dicom_file) # Factory method selects subclass
# parser.preview('/scratch90/QTIM/Active/23-0284/dashboard/Data/hvf_opv_investigation/object_dumps/perimetry_measurements')



patients_spatial_registrations = set();
len(patients_spatial_registrations) # 988 same a pdfs...curious
visits_spatial_registrations = set()
len(visits_spatial_registrations) # 995 same a pdfs...curious
for file in spatial_registrations['filenamepath']:
    dicom_file = os.path.join(file)
    parser = DICOMParser.create_parser(dicom_file) # Factory method selects subclass
    parser.preview('/scratch90/QTIM/Active/23-0284/dashboard/Data/hvf_opv_investigation/object_dumps/spatial_registrations')
    # track patients
    patients_spatial_registrations.update([str(parser.patient_id)])
    # track visits
    visits_spatial_registrations.update([f"mrn:{parser.patient_id} study_date:{parser.study_date}"])




total_patients = patients_pdfs.union(patients_perimetry_measurements).union(patients_spatial_registrations)
len(total_patients)

total_visits = visits_pdfs.union(visits_perimetry_measurements).union(visits_spatial_registrations)
len(total_visits)




pd.DataFrame({"mrns":list(total_patients)}).to_csv(os.path.join(base_path, "processed_patients.csv"))
pd.DataFrame({"mrns":list(total_visits)}).to_csv(os.path.join(base_path, "processed_visits.csv"))

tp = pd.DataFrame({"mrns":list(total_patients)})
tp[tp['mrns'] == list(mrns)[26]]
len(total_patients.union(mrns))

tv = pd.DataFrame({"mrns":list(total_visits)})
tv[tv['mrns'] == list(visits_perimetry_errors)[26]]
len(total_visits.union(visits_perimetry_errors))
visits_perimetry_errors

# dicom_file = 

# parser = DICOMParser.create_parser(dicom_file) # Factory method selects subclass
# print(parsed_metadata.keys())
# parser.write_parsed('/scratch90/QTIM/Active/23-0284/dashboard/hvf_extraction_script/hvf_investigation/object_dumps/')
