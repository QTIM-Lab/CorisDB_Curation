import os, pdb
from tqdm import tqdm
import argparse

import pandas as pd
import numpy as np

def parse_args() -> argparse.Namespace:
    """Parse command line arguments"""
    parser = argparse.ArgumentParser('')
    parser.add_argument('--file_in', type=str, required=True, help='Input file with files to retrieve')
    parser.add_argument('--file_out', type=str, required=True, help='Output file where to save info')
    return parser.parse_args()

import xml.etree.ElementTree as ET

def extract_all_attributes(xml_file_path):
    tree = ET.parse(xml_file_path)
    root = tree.getroot()

    attributes_list = {}

    # Traverse all elements
    for elem in root.iter():
        if elem.attrib:
            # Add a record with element tag and its attributes
            attributes_list.update(elem.attrib)

    return attributes_list

def main(args: argparse.Namespace) -> None:
    """Main function the script will run"""

    imgs = pd.read_csv(args.file_in)
    print(f'Read {len(imgs):,d} images')
    # pdb.set_trace()
    dirnames = set([os.path.dirname(x) for x in imgs['0'].values])
    print(f'Found {len(dirnames):,d} directories to explore')

    extracted_info = []
    for dir_name in tqdm(dirnames, total=len(dirnames), desc='Retrieving images'):
        xmls = [os.path.join(dir_name, f) for f in os.listdir(dir_name) if os.path.splitext(f)[1] == '.xml']

        for xml in xmls:
            corresponding_j2k = xml.replace('.xml', '.j2k')
            if os.path.exists(corresponding_j2k):
                curr_info = extract_all_attributes(xml)
                curr_info['file_path_coris'] = corresponding_j2k
                extracted_info.append(curr_info)

    extracted_info = pd.DataFrame(extracted_info)
    print(f'Extracted info for {extracted_info.file_path_coris.nunique():,d} images and {extracted_info.PID.nunique():,d} patients')
    extracted_info.to_csv(args.file_out, index=False)

if __name__ == '__main__':
    args: argparse.Namespace = parse_args()

    main(args)
    print('Done')
