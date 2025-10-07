import argparse
from functools import partial
import xml.etree.ElementTree as ET
import os, csv, sys, time, pdb
import multiprocessing
import pandas as pd
from tqdm import tqdm
from functools import reduce
import re

# Function to process a single XML file and collect column names
def process_xml_file(xml_file, all_columns=None, out_csv=None):
    values = {col: 'NULL' for col in all_columns} 
    values['file_path'] = xml_file
    values['file_path_j2k_maybe'] = xml_file.replace('.xml', '.j2k')
    try:
        tree = ET.parse(xml_file)
        root = tree.getroot()
        # Collect all column names
        for elem in root.iter():
            for key in elem.attrib.keys():
                values[key] = elem.attrib[key]
        values = dict(sorted(values.items(), reverse=True))
    except:
        print(f"Problematic XML during XML values parsing: {xml_file}")
    return values



def find_all_cols(xml_file):
    columns = []
    try:
        tree = ET.parse(xml_file)
        root = tree.getroot()
        for elem in root.iter():
            for key in elem.attrib.keys():
                columns.append(key)
    except:
        print(f"Problematic XML during column parsing: {xml_file}")
    # Collect all column names
    return set(columns)


def is_strictly_int(value):
    if isinstance(value, str):
        return bool(re.fullmatch(r'\d+', value))
    return False



if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Read XMLs from csv and process in parallel')
    # Optional arguments
    parser.add_argument('-x', '--xml_path', help="Input XML file list csv", default="/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/visupac_preview_xml_files.csv")
    parser.add_argument('-o', '--out', help="Out csv", default=os.path.join('/scratch90/QTIM/Active/23-0284/EHR/AXISPACS', 'new_xml_parsing_true_parallel.csv'))
    parser.add_argument('-s', '--series', action='store_true', help="Don't process in parallel (default true)")
    parser.add_argument('-r', '--range', help="Number of XML files to parse", type=int, default=-1)
    parser.add_argument('-e', '--edit', action='store_true', help="Edit previously made CSV")

    args = parser.parse_args()

    # Use the arguments
    print(f"Input XML file list csv: {args.xml_path}")
    print(f"CSV Out Directory: {args.out}")
    print(f"In Series: {args.series}")
    print(f"Range: {'all' if args.range == -1 else args.range}")
    print(f"Edit CSV Mode: {args.edit}")

    if args.edit:
        df = pd.read_csv(args.out)

        new_columns = [
        'file_path', 'file_path_j2k_maybe', 'PID', 'FirstName', 'LastName', 'DOB', 'Gender',
        'ExamDate', 'Laterality', 'DeviceID', 'DataFile', 'ImageWidth', 'ImageType', 'ImageNumber', 'ImageHeight', 'ImageGroup', 'ImageFile',
        'AttendingPhysician', 'ReportType', 'Pathology', 'Procedure', 'Layer_Name',
        'Start_X', 'Start_Y', 'End_X', 'End_Y', 'SizeX', 'SizeZ', 'ScanPattern', 'Scale_X', 'Scale_Y', 'Scale_Z', 'XSlo', 'YSlo', 'TimeStamp_TotalSeconds'
        ]

        df['PID_strictly_int'] = df['PID'].apply(is_strictly_int)

        df[df['PID_strictly_int']][new_columns].to_csv(args.out.replace(".csv", "_int_pids.csv"), index=False)
        df[~df['PID_strictly_int']][new_columns].to_csv(args.out.replace(".csv", "_problem_pids.csv"), index=False)
        # pdb.set_trace()

    else:
        if os.path.exists(args.out):
            os.remove(args.out)

        # Set nrows to None to read the entire file
        nrows = args.range if args.range > 0 else None
        xmls = pd.read_csv(args.xml_path, nrows=nrows)
        # Standard For Loop
        if args.series:
            # find cols first #
            start_time = time.perf_counter()
            column_sets = []
            for xml in tqdm(xmls['xml_path']):
                column_sets.append(find_all_cols(xml))
            # Combine all discovered columns
            finish_time = time.perf_counter()
            all_columns = reduce(set.union, column_sets, set())
            print(f"Series Columns Processed in {finish_time - start_time}")

            # Parse XMLs
            start_time = time.perf_counter()
            values_array = []
            for xml in tqdm(xmls['xml_path']):
                values_array.append(process_xml_file(xml, all_columns, args.out))
            finish_time = time.perf_counter()
            pd.DataFrame(values_array).to_csv(args.out, header=True, index=False)
            print(f"Series XMLs Processed in {finish_time - start_time}")

        # Multiprocessing
        else:
            # find cols first #
            start_time = time.perf_counter()
            with multiprocessing.Pool(int(multiprocessing.cpu_count() * 0.75)) as pool:
                column_sets = pool.map(find_all_cols, xmls['xml_path'])
            # Combine all discovered columns
            all_columns = reduce(set.union, column_sets, set())
            del(column_sets) # Clear RAM to help with memory usage
            finish_time = time.perf_counter()
            print(f"Multiprocessed Columns in {finish_time - start_time}")
            # use partial to fix other args #
            process_xml_with_args = partial(process_xml_file, all_columns=all_columns, out_csv=args.out)
            start_time = time.perf_counter()
            with multiprocessing.Pool(int(multiprocessing.cpu_count() * 0.75)) as pool:
                values_array = pool.map(process_xml_with_args, xmls['xml_path'])
            finish_time = time.perf_counter()
            pd.DataFrame(values_array).to_csv(args.out, header=True, index=False)
            print(f"Multiprocessed XMLs in {finish_time - start_time}")

