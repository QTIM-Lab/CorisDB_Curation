import xml.etree.ElementTree as ET
import numpy as np
import csv, sys
from tqdm import tqdm
import os, pdb
import time
import pandas as pd
from concurrent.futures import ThreadPoolExecutor, as_completed

# Start timing
start_time = time.time()

# Define the folder path
folder_path = '/persist/PACS/VisupacImages/'
# csv_file_path = '/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/read_xml.csv'
csv_file_path = '/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/read_xml_all'

# Ensure the directory for the CSV file exists
os.makedirs(os.path.dirname(csv_file_path), exist_ok=True)


def parse_xmls_in_this_directory(directory):
    # Collect all XML file paths
    xml_files = []
    for subdir, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.xml'):
                xml_files.append(os.path.join(subdir, file))
    # Manual | debug
    # xml_files = ['/persist/PACS/VisupacImages/106329/774740/axis01_106329_774740_20241127090242936f0ffcca1cc82bb9b.xml']
    # Function to extract headers from a single XML file
    def extract_headers(xml_file):
        try:
            tree = ET.parse(xml_file)
            root = tree.getroot()
            return set(attr for elem in root.iter() for attr in elem.attrib)
        except Exception:
            return set()  # Skip unreadable or malformed files
    # Collect headers in parallel
    with ThreadPoolExecutor() as executor:
        futures = [executor.submit(extract_headers, xml) for xml in xml_files]
        header_set = set()
        for future in as_completed(futures):
            header_set.update(future.result())
    header = ['file_path_coris'] + sorted(header_set)
    header_index = {key: idx for idx, key in enumerate(header)}
    # Function to extract row data from a single XML file
    def extract_row(xml_file):
        try:
            tree = ET.parse(xml_file)
            root = tree.getroot()
            row = [xml_file.replace('.xml', '.j2k')] + ['NULL'] * (len(header)-1)
            has_data = False
            for elem in root.iter():
                for key, value in elem.attrib.items():
                    idx = header_index.get(key)
                    if idx is not None:
                        row[idx] = value
                        has_data = True
            return row if has_data else None
        except Exception:
            return None  # Skip unreadable or malformed files
    # Extract data rows in parallel
    rows = []
    with ThreadPoolExecutor() as executor:
        futures = {executor.submit(extract_row, xml): xml for xml in xml_files}
        for i, future in enumerate(as_completed(futures), 1):
            result = future.result()
            if result:
                rows.append(result)
            print(f"Processed {i}/{len(xml_files)} files")
    # Write to CSV
    # pdb.set_trace()
    with open(os.path.join(csv_file_path, f"read_xml_{os.path.basename(directory)}.csv"), 'w', newline='') as csvfile:
        csvwriter = csv.writer(csvfile)
        csvwriter.writerow(header)
    with open(os.path.join(csv_file_path, f"read_xml_{os.path.basename(directory)}.csv"), 'a', newline='') as csvfile:
        csvwriter = csv.writer(csvfile)
        csvwriter.writerows(rows)
    # Print total runtime
    end_time = time.time()
    print("XML data has been successfully saved to CSV file.")
    print(f"Total runtime: {end_time - start_time:.2f} seconds")


folder_path = '/persist/PACS/VisupacImages/'
dirs = os.listdir(folder_path)
dirs = [int(dir) for dir in dirs]
# [dir for dir in dirs if dir.find('.DS_Store') != -1]
dirs.sort()
dirs = [str(dir) for dir in dirs]
# dirs[78313]
len(dirs)
dirs[28137]
dirs[25137:26137]
ten_thousands = 4
for dir in dirs[ten_thousands*10000:ten_thousands*10000 + 1000]: parse_xmls_in_this_directory(os.path.join(folder_path, dir))
for dir in dirs[ten_thousands*10000+1000:ten_thousands*10000 + 2000]: parse_xmls_in_this_directory(os.path.join(folder_path, dir))
for dir in dirs[ten_thousands*10000+2000:ten_thousands*10000 + 3000]: parse_xmls_in_this_directory(os.path.join(folder_path, dir))
for dir in dirs[ten_thousands*10000+3000:ten_thousands*10000 + 4000]: parse_xmls_in_this_directory(os.path.join(folder_path, dir))
for dir in dirs[ten_thousands*10000+4000:ten_thousands*10000 + 5000]: parse_xmls_in_this_directory(os.path.join(folder_path, dir))
for dir in dirs[ten_thousands*10000+5000:ten_thousands*10000 + 6000]: parse_xmls_in_this_directory(os.path.join(folder_path, dir))
for dir in dirs[ten_thousands*10000+6000:ten_thousands*10000 + 7000]: parse_xmls_in_this_directory(os.path.join(folder_path, dir))
for dir in dirs[ten_thousands*10000+7000:ten_thousands*10000 + 8000]: parse_xmls_in_this_directory(os.path.join(folder_path, dir))
for dir in dirs[ten_thousands*10000+8000:ten_thousands*10000 + 9000]: parse_xmls_in_this_directory(os.path.join(folder_path, dir))
for dir in dirs[ten_thousands*10000+9000:ten_thousands*10000 + 10000]: parse_xmls_in_this_directory(os.path.join(folder_path, dir))
for dir in dirs[ten_thousands*10000+10000:]: parse_xmls_in_this_directory(os.path.join(folder_path, dir))

csvs = [csv for csv in os.listdir(csv_file_path)]
csvs_int = [int(csv.replace('read_xml_','').replace('.csv','')) for csv in csvs if csv.find('_all') == -1]
csvs_int.sort()
csvs = [f'read_xml_{folder}.csv' for folder in csvs_int]

def get_superset_columns(csv_files):
    """Get all unique columns across all CSV files"""
    all_columns = set()
    for file in tqdm(csv_files):
        # Just read the header
        df = pd.read_csv(os.path.join(csv_file_path, file), nrows=0)  # nrows=0 reads only headers
        all_columns.update(df.columns)
    return sorted(list(all_columns))

all_columns = get_superset_columns(csvs)

all_columns = ['file_path_coris', 'PID', 'DOB', 'FirstName', 'LastName', 'Gender', 'AttendingPhysician', 'DataFile', 'DeviceID', 
               'ExamDate', 'TimeStamp_TotalSeconds', 'ImageFile', 'ImageGroup', 'ImageWidth', 'ImageHeight', 'Laterality', 
               'ImageNumber', 'ImageType', 'Layer_Name', 'Pathology', 'Procedure', 'ReportType', 'Scale_X', 'Scale_Y', 'Scale_Z', 'ScanPattern', 
               'SizeX', 'SizeZ', 'Start_X', 'Start_Y', 'End_X', 'End_Y', 'XSlo', 'YSlo']

def read_csv_with_superset_columns(file, superset_columns):
    """Read CSV and ensure it has all superset columns"""
    df = pd.read_csv(file)
    
    # Add missing columns with NaN
    for col in superset_columns:
        if col not in df.columns:
            df[col] = None  # or pd.NA, or np.nan
    
    # Reorder columns to match superset order
    return df[superset_columns]


def is_not_valid_integer(x):
    try:
        int(x)  # Try to convert to int
        return False  # If successful, it's a valid integer
    except (ValueError, TypeError):
        return True   # If it fails, it's not a valid integer

# for csv_ in tqdm(csvs):
problem_csv = pd.DataFrame()
os.remove(os.path.join(csv_file_path, 'read_xml_all.csv'))
for csv_ in tqdm(csvs):
    if csv_ != 'read_xml_all.csv':
        temp_csv_df = read_csv_with_superset_columns(file = os.path.join(csv_file_path, csv_), superset_columns = all_columns)
        mask = temp_csv_df['PID'].apply(is_not_valid_integer)
        temp_csv_df.loc[:,'PID_problem'] = mask
        # pdb.set_trace()
        temp_problem_csv = temp_csv_df.loc[temp_csv_df['PID_problem']].copy()
        temp_problem_csv.dropna(axis=1, how='all', inplace=True)
        problem_csv = pd.concat([problem_csv, temp_problem_csv])
        # csvs_df = pd.concat([csvs_df, temp_csv_df])
        out = temp_csv_df.loc[~temp_csv_df['PID_problem'], all_columns]
        out.to_csv(os.path.join(csv_file_path, 'read_xml_all.csv'), mode='a', index=False, header=not os.path.exists(os.path.join(csv_file_path, 'read_xml_all.csv')))

problem_csv.to_csv(os.path.join(csv_file_path, 'read_xml_all_problem.csv'), index=False)