import pydicom, pdb, shutil
import pandas as pd, os

path="/data/KALPATHY/forumTest/30"

# Helper function to get dicom values from tags
def get_dicom_tag_value(dicom_dataset, tag):
    tag_value = dicom_dataset.get(tag, None)
    return tag_value.value if tag_value is not None else None


dicom_file_path = os.path.join(path, "")

/data/KALPATHY/forumTest/30/

ds = pydicom.dcmread(dicom_file_path, defer_size=100, force=True)
ds.to_json
tag = (0x0020, 0x000d)
value = get_dicom_tag_value(ds, tag)


