import xml.etree.ElementTree as ET
import csv
import os

# Define the folder path
folder_path = '/persist/PACS/VisupacImages/33333'
csv_file_path = '/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/read_xml.csv'

# Ensure the directory for the CSV file exists
os.makedirs(os.path.dirname(csv_file_path), exist_ok=True)

# Function to process a single XML file and collect column names
def process_xml_file(xml_file, header):
    tree = ET.parse(xml_file)
    root = tree.getroot()
    
    # Collect all column names
    for elem in root.iter():
        for key in elem.attrib.keys():
            if key not in header:
                header.append(key)

# Collect all column names from all XML files
header = []
for subdir, _, files in os.walk(folder_path):
    for file in files:
        if file.endswith('.xml'):
            xml_file_path = os.path.join(subdir, file)
            process_xml_file(xml_file_path, header)

# Open the CSV file for writing
with open(csv_file_path, 'w', newline='') as csvfile:
    csvwriter = csv.writer(csvfile)
    
    # Write the header row
    csvwriter.writerow(header)
    
    # Function to write data rows to CSV
    def write_data_rows(xml_file, csvwriter, header):
        tree = ET.parse(xml_file)
        root = tree.getroot()
        
        row = ['NULL'] * len(header)
        for elem in root.iter():
            for key in elem.attrib.keys():
                index = header.index(key)
                row[index] = elem.attrib[key]
        csvwriter.writerow(row)
    
    # Walk through the folder and subfolders to find XML files and write data rows
    total_files = sum([len(files) for _, _, files in os.walk(folder_path) if any(file.endswith('.xml') for file in files)])
    processed_files = 0
    
    for subdir, _, files in os.walk(folder_path):
        for file in files:
            if file.endswith('.xml'):
                xml_file_path = os.path.join(subdir, file)
                write_data_rows(xml_file_path, csvwriter, header)
                processed_files += 1
                print(f"Processed {processed_files}/{total_files} files")

print("XML data has been successfully saved to CSV file.")
