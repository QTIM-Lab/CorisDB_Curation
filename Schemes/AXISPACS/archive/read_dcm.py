import os
import csv
import time
import pydicom
from concurrent.futures import ThreadPoolExecutor, as_completed
from collections import defaultdict
from threading import Lock

BASE_DIR = '/persist/PACS/DICOM'
OUTPUT_CSV = '/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/read_dcm_validpixel.csv'
lock = Lock()

def scan_folders(base_dir):
    folder_files = defaultdict(lambda: {'dcm': [], 'j2k': []})
    for root, _, files in os.walk(base_dir):
        for f in files:
            if f.endswith('.dcm') or f.endswith('.j2k'):
                key = 'dcm' if f.endswith('.dcm') else 'j2k'
                folder_files[root][key].append(os.path.join(root, f))
    return {folder: data['dcm'] for folder, data in folder_files.items() if data['dcm'] and data['j2k']}

def check_pixel_array(dcm_path):
    try:
        if os.path.getsize(dcm_path) == 0:
            return None  # Skip empty files
        ds = pydicom.dcmread(dcm_path, stop_before_pixels=False, force=True)
        _ = ds.pixel_array  # Will raise if no pixel data
        return os.path.relpath(dcm_path, BASE_DIR)
    except Exception:
        return None  # Skip unreadable or invalid files

def main():
    start = time.time()
    print("Scanning folders...")
    folder_dcm_map = scan_folders(BASE_DIR)
    print(f"Found {len(folder_dcm_map)} folders with both .dcm and .j2k files.")

    valid_paths = []

    with ThreadPoolExecutor() as executor:
        futures = []
        for dcm_files in folder_dcm_map.values():
            for dcm_file in dcm_files:
                futures.append(executor.submit(check_pixel_array, dcm_file))

        for i, future in enumerate(as_completed(futures), 1):
            result = future.result()
            if result:
                with lock:
                    valid_paths.append(result)
            if i % 100 == 0:
                print(f"Processed {i} DICOM files...")

    print(f"Writing {len(valid_paths)} valid paths to CSV...")
    with open(OUTPUT_CSV, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['Relative File Path'])
        writer.writerows([[path] for path in valid_paths])

    print(f"Done. Total runtime: {time.time() - start:.2f} seconds")

if __name__ == '__main__':
    main()
