import pdb, os
import numpy as np
import pandas as pd

OPHTHALMOLOGY_SOP_CLASSES = {
    "1.2.840.10008.5.1.4.1.1.11.1": "Grayscale Softcopy Presentation State Storage",
    "1.2.840.10008.5.1.4.1.1.77.1.4": "VL Photographic Image Storage",
    "1.2.840.10008.5.1.4.1.1.77.1.4.1": "Video Photographic Image Storage",
    "1.2.840.10008.5.1.4.1.1.77.1.5.1": "Ophthalmic Photography 8 Bit Image Storage",
    "1.2.840.10008.5.1.4.1.1.77.1.5.2": "Ophthalmic Photography 16 Bit Image Storage",
    "1.2.840.10008.5.1.4.1.1.77.1.5.5": "Wide Field Ophthalmic Photography Stereographic Projection Image Storage",
    "1.2.840.10008.5.1.4.1.1.77.1.5.6": "Wide Field Ophthalmic Photography 3D Coordinates Image Storage",
    "1.2.840.10008.5.1.4.1.1.77.1.5.4": "Ophthalmic Tomography Image Storage",
    "1.2.840.10008.5.1.4.1.1.77.1.5.7": "Ophthalmic Optical Coherence Tomography En Face Image Storage",
    "1.2.840.10008.5.1.4.1.1.77.1.5.8": "Ophthalmic Optical Coherence Tomography B-scan Volume Analysis Storage",
    "1.2.840.10008.5.1.4.1.1.78.7": "Ophthalmic Axial Measurements Storage",
    "1.2.840.10008.5.1.4.1.1.78.8": "Intraocular Lens Calculations Storage",
    "1.2.840.10008.5.1.4.1.1.81.1": "Ophthalmic Thickness Map Storage",
    "1.2.840.10008.5.1.4.1.1.82.1": "Corneal Topography Map Storage",
    "1.2.840.10008.5.1.4.1.1.79.1": "Macular Grid Thickness and Volume Report Storage",
    "1.2.840.10008.5.1.4.1.1.80.1": "Ophthalmic Visual Field Static Perimetry Measurements Storage",
    "1.2.840.10008.5.1.4.1.1.78.1": "Lensometry Measurements Storage",
    "1.2.840.10008.5.1.4.1.1.78.2": "Autorefraction Measurements Storage",
    "1.2.840.10008.5.1.4.1.1.78.3": "Keratometry Measurements Storage",
    "1.2.840.10008.5.1.4.1.1.78.4": "Subjective Refraction Measurements Storage",
    "1.2.840.10008.5.1.4.1.1.78.5": "Visual Acuity Measurements Storage",
    "1.2.840.10008.5.1.4.1.1.78.6": "Spectacle Prescription Report Storage",
    "1.2.840.10008.5.1.4.1.1.4":"MR Image Storage",
    "1.2.840.10008.5.1.4.1.1.7": "Secondary Capture Image Storage",
    "1.2.840.10008.5.1.4.1.1.7.2": "Multi-frame Grayscale Byte Secondary Capture Image Storage",
    "1.2.840.10008.5.1.4.1.1.7.4": "Multi-frame True Color Secondary Capture Image Storage",
    "1.2.840.10008.5.1.4.1.1.104.1": "Encapsulated PDF Storage",
    "1.2.840.10008.5.1.4.1.1.66": "Spatial Registration Storage",
    "1.2.840.10008.5.1.4.1.1.12.77": "Ophthalmic Tomography Image Storage",
    "NULL": "Have not seen this SOP Class before"
}

axispacs_all = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/all_files.csv")
axispacs_dicoms = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/all_dicoms.csv")
axispacs_j2ks = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/all_j2ks.csv")
forum_dicoms = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/FORUM/parsed/forum_parse_dicom_for_postgres.csv")
forum_all_dicoms = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/FORUM_ALL/parsed/forum_all_parse_dicom_for_postgres.csv")
imagepools_all_dicoms = pd.read_csv("/scratch90/QTIM/Active/23-0284/EHR/IMAGEPOOLS/parsed/imagepools_parse_dicom_for_postgres.csv")

axispacs_all['SOPClassDescription'] = axispacs_all['SOPClassUID'].apply(lambda sopclass: np.nan if pd.isna(sopclass) else OPHTHALMOLOGY_SOP_CLASSES[sopclass])
axispacs_dicoms['SOPClassDescription'] = axispacs_dicoms['SOPClassUID'].apply(lambda sopclass: OPHTHALMOLOGY_SOP_CLASSES[sopclass])
axispacs_j2ks['SOPClassDescription'] = axispacs_j2ks['SOPClassUID'].apply(lambda sopclass: np.nan if pd.isna(sopclass) else OPHTHALMOLOGY_SOP_CLASSES[sopclass])
forum_dicoms['SOPClassDescription'] = forum_dicoms['SOPClassUID'].apply(lambda sopclass: OPHTHALMOLOGY_SOP_CLASSES[sopclass])
forum_all_dicoms['SOPClassDescription'] = forum_all_dicoms['SOPClassUID'].apply(lambda sopclass: OPHTHALMOLOGY_SOP_CLASSES[sopclass])
imagepools_all_dicoms['SOPClassDescription'] = imagepools_all_dicoms['SOPClassUID'].apply(lambda sopclass: OPHTHALMOLOGY_SOP_CLASSES[sopclass])

axispacs_all.columns[2]
axispacs_dicoms.columns[1]
axispacs_j2ks.columns[1]
forum_dicoms.columns[1]
forum_all_dicoms.columns[1]
imagepools_all_dicoms.columns[1]

axispacs_dicoms.rename(columns={'PatientID':'mrn'}, inplace=True)
imagepools_all_dicoms.rename(columns={'PatientID':'mrn'}, inplace=True)

header_j2k =  ['file_path', 'file_path_xml', 'mrn', 'FirstName', 'LastName', 'DOB',
       'Gender', 'ExamDate', 'Laterality', 'DeviceID', 'DataFile',
       'ImageWidth', 'ImageNumber', 'ImageHeight', 'ImageGroup', 'ImageFile',
       'AttendingPhysician', 'ReportType', 'Pathology', 'Procedure',
       'Layer_Name', 'Start_X', 'Start_Y', 'End_X', 'End_Y', 'SizeX', 'SizeZ',
       'ScanPattern', 'Scale_X', 'Scale_Y', 'Scale_Z', 'XSlo', 'YSlo',
       'TimeStamp_TotalSeconds', 'ImageType', 'file_path_dcm',
       'StudyInstanceUID', 'SeriesInstanceUID', 'SOPInstanceUID', 'Modality',
       'StudyDate', 'SeriesNumber', 'InstanceNumber', 'AcquisitionDateTime',
       'SOPClassUID', 'SOPClassDescription', 'MIMETypeOfEncapsulatedDocument', 'InstitutionName',
       'Manufacturer', 'ManufacturerModelName', 'BitsAllocated',
       'PhotometricInterpretation', 'PixelSpacing', 'StationName',
       'SeriesDescription', 'StudyTime', 'DocType', 'AverageRNFLThickness',
       'OpticCupVolume_mm_squared', 'OpticDiskArea_mm_squared',
       'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR', 'basename']

header = ['file_path', 'mrn', 'StudyInstanceUID', 'SeriesInstanceUID',
       'SOPInstanceUID', 'Modality', 'StudyDate', 'SeriesNumber',
       'InstanceNumber', 'AcquisitionDateTime', 'SOPClassUID', 'SOPClassDescription', 
       'ImageType', 'MIMETypeOfEncapsulatedDocument', 'InstitutionName', 'Manufacturer',
       'ManufacturerModelName', 'Laterality', 'BitsAllocated',
       'PhotometricInterpretation', 'PixelSpacing', 'StationName',
       'SeriesDescription', 'StudyTime', 'DocType', 'AverageRNFLThickness',
       'OpticCupVolume_mm_squared', 'OpticDiskArea_mm_squared',
       'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR', 'basename']

axispacs_all_files_header = ['file_path', 'file_path_xml', 'mrn', 'FirstName', 'LastName', 'DOB',
       'Gender', 'ExamDate', 'Laterality', 'DeviceID', 'DataFile',
       'ImageWidth', 'ImageNumber', 'ImageHeight', 'ImageGroup', 'ImageFile',
       'AttendingPhysician', 'ReportType', 'Pathology', 'Procedure',
       'Layer_Name', 'Start_X', 'Start_Y', 'End_X', 'End_Y', 'SizeX', 'SizeZ',
       'ScanPattern', 'Scale_X', 'Scale_Y', 'Scale_Z', 'XSlo', 'YSlo',
       'TimeStamp_TotalSeconds', 'ImageType', 'file_path_dcm',
       'StudyInstanceUID', 'SeriesInstanceUID', 'SOPInstanceUID', 'Modality',
       'StudyDate', 'SeriesNumber', 'InstanceNumber', 'AcquisitionDateTime',
       'SOPClassUID', 'SOPClassDescription', 'MIMETypeOfEncapsulatedDocument', 'InstitutionName',
       'Manufacturer', 'ManufacturerModelName', 'BitsAllocated',
       'PhotometricInterpretation', 'PixelSpacing', 'StationName',
       'SeriesDescription', 'StudyTime', 'DocType', 'AverageRNFLThickness',
       'OpticCupVolume_mm_squared', 'OpticDiskArea_mm_squared',
       'RimArea_mm_squared', 'AvgCDR', 'VerticalCDR', 'basename']

axispacs_all[axispacs_all_files_header].to_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/all_files_w_sop_desc.csv", index=False)
axispacs_j2ks[header_j2k].to_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/all_j2ks_w_sop_desc.csv", index=False)
axispacs_dicoms[header].to_csv("/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/all_dicoms_w_sop_desc.csv", index=False)
forum_dicoms[header[:-1]].to_csv("/scratch90/QTIM/Active/23-0284/EHR/FORUM/parsed/forum_parse_dicom_for_postgres_.csv", index=False)
forum_all_dicoms[header[:-1]].to_csv("/scratch90/QTIM/Active/23-0284/EHR/FORUM_ALL/parsed/forum_all_parse_dicom_for_postgres_.csv", index=False)
imagepools_all_dicoms[header[:-1]].to_csv("/scratch90/QTIM/Active/23-0284/EHR/IMAGEPOOLS/parsed/imagepools_parse_dicom_for_postgres_.csv", index=False)