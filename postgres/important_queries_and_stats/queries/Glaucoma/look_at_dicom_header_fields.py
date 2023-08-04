import pydicom, os, pdb, shutil

"""
Fundus photography is taking the image of the retina of the eye with a fundus camera.
Fundus photography is important for diagnosing and treating various posterior segments and other ocular diseases.
The illumination and reflectance of the retina occur through the common optical path, i.e., the pupil.
"""

VisupacImagesGlaucoma="/data/PACS-Glaucoma/DICOM/38749/270667"

sample_dicoms = os.listdir(VisupacImagesGlaucoma)

DICOM_TAGS_OF_INTEREST={
    # Helpful
    'Media Storage SOP Class UID':'00020002',
    'Modality':'00080060',
    'Manufacturer':'00080070',
    'Instituion Name':'00080080',
    'Code Meaning':'00180012', # Underneath look for Code meaning...
    'Laterality':'00200060',
    'ImageLaterality':'00200062',
    'PixelSpacing':'00283000',
    'BitsAllocated':'00280100',
    # Maybe
    'ModalityLUTSequence':'00283000',
    'PhotometricInterpretation': '00280004',
    'WideFieldOphthalmicPhotographyQualityRatingSequence':'00221525',
    'WideFieldOphthalmicPhotographyQualityThresholdSequence':'00221526',
    'WideFieldOphthalmicPhotographyQualityThresholdQualityRating':'00221527',
    }

for sd in sample_dicoms:
    dicom = pydicom.dcmread(os.path.join(VisupacImagesGlaucoma, sd))
    # pdb.set_trace()
    dicom['00080060']
    dicom['00280004']
    dicom['00221525']
    dicom['00221526']
    dicom['00221527']
    # dicom
