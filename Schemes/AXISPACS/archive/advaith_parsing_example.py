import os
import pandas as pd
from tqdm import tqdm
import xml.etree.ElementTree as ET

csv_file_path = '/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/advaith_read_xml_BB.csv'

def parse_xml(xml_file):
    # Advaith's code to parse XML
    fields = {}
    try:
        tree = ET.parse(xml_file)
        root = tree.getroot()
        for elem in root.iter():
            tag = elem.tag
            attrib = elem.attrib
            if tag in ['AxisImageXMLInformation', 'Patient', 'Exam', 'Image', 'BScan', 'SLOImage', 'SegmentationLine']:
                fields = fields | attrib
            if tag == 'BScan':
                fields['type'] = 'BScan'
            if tag == 'SLOImage':
                fields['type'] = 'SLOImage'
            if tag == 'SegmentationLayer' and attrib.get('Layer_Name') == 'ILM':
                for child in elem:
                    if child.tag == 'P':
                        fields['ILM'] = child.text.strip() if child.text else 'Not Found'
            if tag == 'SegmentationLayer' and attrib.get('Layer_Name') == 'RPE':
                for child in elem:
                    if child.tag == 'P':
                        fields['RPE'] = child.text.strip() if child.text else 'Not Found'
    except Exception as e:
        print(f"Error parsing {xml_file}: {e}")
    return fields

def load_metadata(file_path):
    # Load metadata from CSV
    return pd.read_csv(file_path)

def compare_metadata(df1, df2):
    # Compare metadata between two DataFrames
    return df1.equals(df2)

# Load DCM metadata
dcm_metadata = load_metadata('path/to/dcm_metadata.csv')

# Find XML files associated with J2K files
# xml_files = [f.replace('.j2k', '.xml') for f in os.listdir('path/to/j2k_files') if f.endswith('.j2k')]
xml_files = ['/persist/PACS/VisupacImages/106329/774740/axis01_106329_774740_20241127090242936f0ffcca1cc82bb9b.xml']


# Parse XML files and store metadata
output = []
for xml_file in tqdm(xml_files):
    if os.path.exists(xml_file):
        xml_parsed = parse_xml(xml_file)
        xml_parsed['Has XML'] = True
        output.append(xml_parsed)
    else:
        output.append({'Has XML': False})

# Save XML metadata to CSV
xml_metadata = pd.DataFrame(output)
xml_metadata.to_csv(csv_file_path, index=False)

# Compare XML metadata with DCM metadata
xml_metadata = load_metadata(csv_file_path)
is_duplicate = compare_metadata(xml_metadata, dcm_metadata)

if is_duplicate:
    print("All metadata in DCM table is in XML table. J2K files can be disregarded.")
else:
    print("Some metadata in DCM table is included in XML table. J2K files provide more information and need to be considered.")
