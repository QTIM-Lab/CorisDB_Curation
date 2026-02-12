```bash
pyenv versions
pyenv deactivate
pyenv activate corisdb_curation

cd CorisDB_Curation/Schemes
python parse_dicom_for_postgres_parallel.py -s
```

```python
import json
import argparse
import os, pdb
import pydicom
dicom_path = '/persist/PACS/forum/2021/7/15/1.2.276.0.75.2.2.42.50122019542.20210715081507559.2676572530.2.dcm'
ds = pydicom.dcmread(dicom_path, stop_before_pixels=True)
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


SOP_CLASS_DESCRIPTION = OPHTHALMOLOGY_SOP_CLASSES[getattr(ds, 'SOPClassUID', 'NULL')]
if getattr(ds, 'Modality', 'NULL') == 'OPT' and \
    SOP_CLASS_DESCRIPTION != 'Multi-frame True Color Secondary Capture Image Storage' and \
    getattr(ds, 'PerFrameFunctionalGroupsSequence', 'NULL') is not 'NULL':
    dict_PerFrameFunctionalGroupsSequence = {}
    print(OPHTHALMOLOGY_SOP_CLASSES[getattr(ds, 'SOPClassUID', 'NULL')])
    print(getattr(ds, 'Modality', 'NULL'), "\n")
    print(getattr(ds, 'Manufacturer', 'NULL'), "\n")
    print(getattr(ds, 'ManufacturerModelName', 'NULL'), "\n")
    print(getattr(ds, 'PhotometricInterpretation', 'NULL'), "\n")
    print(getattr(ds, 'SeriesDescription', 'NULL'), "\n")
    PerFrameFunctionalGroupsSequence = getattr(ds, 'PerFrameFunctionalGroupsSequence', 'NULL')
    # len(PerFrameFunctionalGroupsSequence)
    for frame in PerFrameFunctionalGroupsSequence:
        # frame = PerFrameFunctionalGroupsSequence[0]
        InStackPositionNumber = frame['FrameContentSequence'][0]['InStackPositionNumber'].value
        ReferencedSOPInstanceUID = str(frame['OphthalmicFrameLocationSequence'][0]['ReferencedSOPInstanceUID'].value)
        ReferenceCoordinates = frame['OphthalmicFrameLocationSequence'][0]['ReferenceCoordinates'].value
        # pdb.set_trace()
        dict_PerFrameFunctionalGroupsSequence[InStackPositionNumber] = {
            "ReferencedSOPInstanceUID": ReferencedSOPInstanceUID,
            "ReferenceCoordinates": ReferenceCoordinates
        }
    
    json_PerFrameFunctionalGroupsSequence = json.dumps(dict_PerFrameFunctionalGroupsSequence)
    # pdb.set_trace()


print(json_PerFrameFunctionalGroupsSequence)

```