import os
import pydicom
import sys
from pydicom import config

# Root folder containing subfolders with DICOM files
#root_folder = "/persist/PACS/DICOM/100092"
root_folder = "/persist/PACS/DICOM/100052"  #dicom files only


# Recursively find all .dcm files
dicom_files = []
for dirpath, _, filenames in os.walk(root_folder):
    for filename in filenames:
        if filename.endswith(".dcm"):
            dicom_files.append(os.path.join(dirpath, filename))

if not dicom_files:
    print("No DICOM files found in the directory tree.")
    sys.exit(1)

# Print available pixel data handlers
print("Available pixel data handlers:")
for handler in config.pixel_data_handlers:
    print(" -", handler.__name__)

# Process each DICOM file
for dicom_path in dicom_files:
    print(f"\nProcessing file: {dicom_path}")
    try:
        ds = pydicom.dcmread(dicom_path)
    except Exception as e:
        print(f"Failed to read DICOM file: {e}")
        continue

    if 'PixelData' not in ds:
        print("No Pixel Data found in this DICOM file.")
        continue

    print("Transfer Syntax UID:", ds.file_meta.TransferSyntaxUID)

    try:
        pixel_array = ds.pixel_array
        print("Pixel Array Shape:", pixel_array.shape)
        print("Pixel Data Type:", pixel_array.dtype)
    except Exception as e:
        print("Error reading pixel array:", e)
