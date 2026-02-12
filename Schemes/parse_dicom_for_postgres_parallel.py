import json
import argparse
import os, sys, pdb
import pandas as pd
import numpy as np
from tqdm import tqdm
import pydicom
# import subprocess
import multiprocessing
import time
from pathlib import Path
import warnings
from functools import partial



warnings.filterwarnings("ignore", category=UserWarning, module="pydicom")
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

def parse_dicom_for_postgres(dicom_path):
    """Parse a single DICOM file - this can be parallelized"""
    try:
        ds = pydicom.dcmread(dicom_path, stop_before_pixels=True)
        # pdb.set_trace()
        
        # dicom_path
        # getattr(ds, 'PatientID', 'NULL'); # ds[(0x0010, 0x0020)]
        # getattr(ds, 'StudyInstanceUID', 'NULL'); # ds[(0x0008, 0x000D)]
        # getattr(ds, 'SeriesInstanceUID', 'NULL'); # ds[(0x0020, 0x000E)]
        # getattr(ds, 'SOPInstanceUID', 'NULL'); # ds[(0x0020, 0x0018)]
        # getattr(ds, 'Modality', 'NULL'); # ds[(0x0008, 0x0060)]
        # getattr(ds, 'StudyDate', 'NULL'); # ds[(0x0008, 0x0020)]
        # getattr(ds, 'SeriesNumber', 'NULL'); # ds[(0x0020, 0x0011)]
        # getattr(ds, 'InstanceNumber', 'NULL'); # ds[(0x0020, 0x0013)]
        # getattr(ds, 'AcquisitionDateTime', 'NULL'); # ds[(0x, 0x)]
        # getattr(ds, 'SOPClassUID', 'NULL'); # ds[(0x, 0x)]
        # getattr(ds, 'Modality', 'NULL'); # ds[(0x, 0x)]
        # ## getattr(ds, 'ModalityLUTSequence', 'NULL'); ds[(0x0028, 0x3000)]; ds.get((0x0028, 0x3000), 'NULL') 
        # getattr(ds, 'ImageType', 'NULL'); # ds[(0x0008, 0x0008)]
        # getattr(ds, 'MIMETypeOfEncapsulatedDocument', 'NULL'); # ds[(0x0042, 0x0012)]
        # getattr(ds, 'InstitutionName', 'NULL'); # ds[(0x0008, 0x0080)]
        # getattr(ds, 'Manufacturer', 'NULL'); # ds[(0x0008, 0x0070)]
        # getattr(ds, 'ManufacturerModelName', 'NULL'); # ds[(0x0008, 0x1090)]
        # getattr(ds, 'Laterality', 'NULL'); #ds[(0x0020, 0x0060)]
        # getattr(ds, 'BitsAllocated', 'NULL'); # ds[(0x0028, 0x0100)]
        # getattr(ds, 'PhotometricInterpretation', 'NULL'); # ds[(0x0028, 0x0004)]
        # getattr(ds, 'PixelSpacing', 'NULL'); # ds[(0x0028, 0x0030)]
        # getattr(ds, 'StationName', 'NULL'); # ds[(0x0008, 0x1010)]
        # getattr(ds, 'SeriesDescription', 'NULL'); # ds[(0x0008, 0x103E)]
        # getattr(ds, 'StudyDate', 'NULL'); # ds[(0x0008, 0x103E)]
        # getattr(ds, 'StudyTime', 'NULL'); # ds[(0x0008, 0x0033)]
        # ds.get((0x2201, 0x0010), 'NULL').value if ds.get((0x2201, 0x0010), 'NULL') != 'NULL' else 'NULL' # DocType
        # ds.get((0x0409, 0x10E4), 'NULL').value if ds.get((0x0409, 0x10E4), 'NULL') != 'NULL' else 'NULL' # AverageRNFLThickness
        # ds.get((0x0409, 0x10E5), 'NULL').value if ds.get((0x0409, 0x10E5), 'NULL') != 'NULL' else 'NULL' # OpticCupVolume_mm_squared
        # ds.get((0x0409, 0x10E6), 'NULL').value if ds.get((0x0409, 0x10E6), 'NULL') != 'NULL' else 'NULL' # OpticDiskArea_mm_squared
        # ds.get((0x0409, 0x10E7), 'NULL').value if ds.get((0x0409, 0x10E7), 'NULL') != 'NULL' else 'NULL' # RimArea_mm_squared
        # ds.get((0x0409, 0x10E8), 'NULL').value if ds.get((0x0409, 0x10E8), 'NULL') != 'NULL' else 'NULL' # AvgCDR
        # ds.get((0x0409, 0x10E9), 'NULL').value if ds.get((0x0409, 0x10E9), 'NULL') != 'NULL' else 'NULL' # VerticalCDR

        SOP_CLASS_DESCRIPTION = OPHTHALMOLOGY_SOP_CLASSES[getattr(ds, 'SOPClassUID', 'NULL')]
        json_PerFrameFunctionalGroupsSequence = 'NULL'
        PixelSpacing = getattr(ds, 'PixelSpacing', 'NULL')
        # pdb.set_trace()
        if getattr(ds, 'Modality', 'NULL') == 'OPT' and  \
            SOP_CLASS_DESCRIPTION != 'Multi-frame True Color Secondary Capture Image Storage' and \
            getattr(ds, 'PerFrameFunctionalGroupsSequence', 'NULL') != 'NULL':
            # Begin Block
            if PixelSpacing == 'NULL':
                PixelSpacing = getattr(ds, 'SharedFunctionalGroupsSequence', 'NULL')[0]['PixelMeasuresSequence'][0]['PixelSpacing'].value
            
            ReferencedSOPInstanceUID = getattr(ds, 'SharedFunctionalGroupsSequence', 'NULL')[0]['ReferencedImageSequence'][0]['ReferencedSOPInstanceUID'].value
            dict_PerFrameFunctionalGroupsSequence = {"ReferencedSOPInstanceUID": ReferencedSOPInstanceUID, "ReferenceCoordinates": {}}
            PerFrameFunctionalGroupsSequence = getattr(ds, 'PerFrameFunctionalGroupsSequence', 'NULL')
            # pdb.set_trace()
            for frame in PerFrameFunctionalGroupsSequence:
                # frame = PerFrameFunctionalGroupsSequence[0]
                InStackPositionNumber = frame['FrameContentSequence'][0]['InStackPositionNumber'].value
                # ReferencedSOPInstanceUID = str(frame['OphthalmicFrameLocationSequence'][0]['ReferencedSOPInstanceUID'].value)
                ReferenceCoordinates = frame['OphthalmicFrameLocationSequence'][0]['ReferenceCoordinates'].value
                # pdb.set_trace()
                dict_PerFrameFunctionalGroupsSequence["ReferenceCoordinates"][InStackPositionNumber] = ReferenceCoordinates
            json_PerFrameFunctionalGroupsSequence = json.dumps(dict_PerFrameFunctionalGroupsSequence)


        metadata = {
            'file_path': dicom_path,
            'mrn': getattr(ds, 'PatientID', 'NULL'),
            'StudyInstanceUID': getattr(ds, 'StudyInstanceUID', 'NULL'),
            'SeriesInstanceUID': getattr(ds, 'SeriesInstanceUID', 'NULL'),
            'SOPInstanceUID': getattr(ds, 'SOPInstanceUID', 'NULL'),
            'Modality': getattr(ds, 'Modality', 'NULL'),
            'StudyDate': getattr(ds, 'StudyDate', 'NULL'),
            'SeriesNumber': getattr(ds, 'SeriesNumber', 'NULL'),
            'InstanceNumber': getattr(ds, 'InstanceNumber', 'NULL'),
            'AcquisitionDateTime': getattr(ds, 'AcquisitionDateTime', 'NULL'),
            'SOPClassUID': getattr(ds, 'SOPClassUID', 'NULL'),
            'SOPClassDescription':OPHTHALMOLOGY_SOP_CLASSES[getattr(ds, 'SOPClassUID', 'NULL')],
            'ImageType': getattr(ds, 'ImageType', 'NULL'),
            'MIMETypeOfEncapsulatedDocument': getattr(ds, 'MIMETypeOfEncapsulatedDocument', 'NULL'),
            'InstitutionName': getattr(ds, 'InstitutionName', 'NULL'),
            'Manufacturer': getattr(ds, 'Manufacturer', 'NULL'),
            'ManufacturerModelName': getattr(ds, 'ManufacturerModelName', 'NULL'),
            'Laterality': getattr(ds, 'Laterality', 'NULL'),
            'PerFrameFunctionalGroupsSequence': json_PerFrameFunctionalGroupsSequence, # JSON
            'BitsAllocated': getattr(ds, 'BitsAllocated', 'NULL'),
            'PhotometricInterpretation': getattr(ds, 'PhotometricInterpretation', 'NULL'),
            'PixelSpacing': PixelSpacing,
            'StationName': getattr(ds, 'StationName', 'NULL'),
            'SeriesDescription': getattr(ds, 'SeriesDescription', 'NULL'),
            'StudyTime': getattr(ds, 'StudyTime', 'NULL'),
            'DocType': ds.get((0x2201, 0x0010), 'NULL').value if ds.get((0x2201, 0x0010), 'NULL') != 'NULL' else 'NULL',
            'AverageRNFLThickness': ds.get((0x0409, 0x10E4), 'NULL').value if ds.get((0x0409, 0x10E4), 'NULL') != 'NULL' else 'NULL',
            'OpticCupVolume_mm_squared': ds.get((0x0409, 0x10E5), 'NULL').value if ds.get((0x0409, 0x10E5), 'NULL') != 'NULL' else 'NULL',
            'OpticDiskArea_mm_squared': ds.get((0x0409, 0x10E6), 'NULL').value if ds.get((0x0409, 0x10E6), 'NULL') != 'NULL' else 'NULL',
            'RimArea_mm_squared': ds.get((0x0409, 0x10E7), 'NULL').value if ds.get((0x0409, 0x10E7), 'NULL') != 'NULL' else 'NULL',
            'AvgCDR': ds.get((0x0409, 0x10E8), 'NULL').value if ds.get((0x0409, 0x10E8), 'NULL') != 'NULL' else 'NULL',
            'VerticalCDR': ds.get((0x0409, 0x10E9), 'NULL').value if ds.get((0x0409, 0x10E9), 'NULL') != 'NULL' else 'NULL'
        }
        return metadata
    except Exception as e:
        print(f"Error reading {dicom_path}: {e}")
        return None

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='List root directories and process DCMs in parallel.')
    # Optional arguments
    # parser.add_argument('-d', '--dicom_in', help="Dicom file list input csv", default="/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/raw_files_lists/DICOM_dcm_files.csv")
    # parser.add_argument('-o', '--out', help="Out csv", default=os.path.join('/scratch90/QTIM/Active/23-0284/EHR/AXISPACS', 'parse_dicom_for_postgres.csv'))
    parser.add_argument('-d', '--dicom_in', help="Dicom file list input csv", default="/scratch90/QTIM/Active/23-0284/EHR/FORUM/raw_files_lists/forum_preview_dcm_files.csv")
    parser.add_argument('-o', '--out', help="Out csv", default=os.path.join('/scratch90/QTIM/Active/23-0284/EHR/FORUM/parsed', 'forum_parse_dicom_for_postgres.csv'))
    # parser.add_argument('-d', '--dicom_in', help="Dicom file list input csv", default="/scratch90/QTIM/Active/23-0284/EHR/FORUM/raw_files_lists/cirrus_forum_preview_dcm_files.csv")
    # parser.add_argument('-o', '--out', help="Out csv", default=os.path.join('/scratch90/QTIM/Active/23-0284/EHR/FORUM', 'cirrus_parse_dicom_for_postgres.csv'))
    parser.add_argument('-s', '--series', action='store_true', help="Don't process in parallel (default true)")
    parser.add_argument('--range', help="Number of XML files to parse", type=int, default=-1)

    args = parser.parse_args()
    
    # Use the arguments
    print(f"DICOM file list csv: {args.dicom_in}")
    # print(f"Root Dir: {args.root_dir}")
    print(f"CSV Out Directory: {args.out}")
    print(f"In Series: {args.series}")
    print(f"Range: {'all' if args.range == -1 else args.range}")

    if os.path.exists(args.out):
        os.remove(args.out)

    # Set nrows to None to read the entire file
    nrows = args.range if args.range > 0 else None
    dcms = pd.read_csv(args.dicom_in, nrows=nrows) # .iloc[:2]
    # dcms
    # pdb.set_trace()
    # Standard For Loop
    if args.series:
        # Parse dcms #
        start_time = time.perf_counter()
        values_array = []
        for dicom_path in tqdm(dcms['file_path']):
            values_array.append(parse_dicom_for_postgres(dicom_path))
        finish_time = time.perf_counter()
        # pdb.set_trace()
        values_df = pd.DataFrame(values_array)
        # Replace 'NULL' strings and empty strings with NaN
        values_df = values_df.replace(['NULL', ''], np.nan)
        # Or using regex to catch variations
        values_df = values_df.replace(r'^(NULL|null|Null|\s*)$', np.nan, regex=True)
        values_df['StudyDate'] = pd.to_datetime(values_df['StudyDate'].astype("Int64").astype(str), format="%Y%m%d", errors="coerce")
        values_df.to_csv(args.out, header=True, index=False)
        print(f"Series DCMs Processed in {finish_time - start_time}")

    # Multiprocessing
    else:
        # use partial to fix other args #
        start_time = time.perf_counter()
        # pdb.set_trace()
        with multiprocessing.Pool(int(multiprocessing.cpu_count() * 0.85)) as pool:
            values_array = pool.map(parse_dicom_for_postgres, dcms['file_path'])
        finish_time = time.perf_counter()
        values_df = pd.DataFrame(values_array)
        # pdb.set_trace()
        # Replace 'NULL' strings and empty strings with NaN
        values_df = values_df.replace(['NULL', ''], np.nan)
        # Or using regex to catch variations
        values_df = values_df.replace(r'^(NULL|null|Null|\s*)$', np.nan, regex=True)
        values_df['StudyDate'] = pd.to_datetime(values_df['StudyDate'].astype("Int64").astype(str), format="%Y%m%d", errors="coerce")
        values_df.to_csv(args.out, header=True, index=False)
        print(f"Multiprocessed DCMs in {finish_time - start_time}")



