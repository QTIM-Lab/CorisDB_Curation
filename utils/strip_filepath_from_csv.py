import pandas as pd
import os
from shutil import copy2

# Step 1: Read the CSV file
csv_file_path = '/projects/coris_db_subsets/AMD/Fundus_Auto_Fluorescence/OptimEYES_Prospective/OptimEYES_Prospective_GA_ICD_Code_Cohort_good_quality_only_new_SM.csv'  # Replace with your CSV file path
df = pd.read_csv(csv_file_path)

# Column name that contains the file paths
file_path_column = 'file_path_coris'  # Replace with the name of the column that contains the file paths

# Step 2: Create a new folder for the copied images if it doesn't already exist
new_folder_path = '/projects/coris_db_subsets/Image_Conversion/INPUT'  # Replace with the path to the folder where you want to copy the images
os.makedirs(new_folder_path, exist_ok=True)

# Step 3: Iterate through the DataFrame and copy images
for index, row in df.iterrows():
    original_file_path = row[file_path_column]
    if os.path.isfile(original_file_path):  # Check if the file exists
        # Construct the new file path
        file_name = os.path.basename(original_file_path)
        new_file_path = os.path.join(new_folder_path, file_name)

        # Copy the image
        copy2(original_file_path, new_file_path)  # Copy the image to the new folder

print('Images have been copied.')



