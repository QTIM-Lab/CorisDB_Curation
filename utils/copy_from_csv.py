import pandas as pd
import os
import shutil
from pathlib import Path

def remove_redundant_path(source_dir, image_path):
    """
    Removes redundant path elements that appear in both the source directory and the image path.
    
    Args:
    - source_dir (str): The base directory for image paths.
    - image_path (str): The full path of the image from the CSV.
    
    Returns:
    - str: A cleaned-up path that eliminates redundant directories.
    """
    # Normalize paths for consistency
    source_dir = os.path.normpath(source_dir)
    image_path = os.path.normpath(image_path)

    # Remove the source_dir from image_path if it is a prefix
    if image_path.startswith(source_dir):
        # +1 to remove the trailing slash as well
        return image_path[len(source_dir)+1:]
    return image_path

def copy_images(csv_file, source_dir, dest_dir, image_column='file_path_coris'):
    """
    Copies images listed in a specific column of a CSV file from a source directory to a destination directory.

    Args:
    - csv_file (str): Path to the CSV file.
    - source_dir (str): Directory where images currently exist.
    - dest_dir (str): Directory where images should be copied to.
    - image_column (str): Column name in the CSV file where image paths are stored.

    Returns:
    - None
    """
    # Read the CSV file
    df = pd.read_csv(csv_file)

    # Ensure the destination directory exists
    Path(dest_dir).mkdir(parents=True, exist_ok=True)

    # Normalize the source directory
    source_dir = os.path.normpath(source_dir)

    # Process and copy each image
    for image_path in df[image_column]:
        # Handle potential redundant paths
        cleaned_path = remove_redundant_path(source_dir, image_path)

        # Construct the full absolute path
        full_image_path = os.path.join(source_dir, cleaned_path)
        final_path = os.path.normpath(full_image_path)

        # Check existence and copy
        if os.path.isfile(final_path):
            shutil.copy(final_path, dest_dir)
        else:
            print(f"Warning: {final_path} does not exist.")

if __name__ == "__main__":
    # Define the CSV file path
    csv_file_path = '/projects/coris_db_subsets/AMD/Fundus_Auto_Fluorescence/OptimEYES_Prospective/OptimEYES_Prospective_GA_ICD_Code_Cohort_good_quality_only_new.csv'
    
    # Define the source directory where images are currently stored
    source_directory = '/projects/coris_db_subsets/AMD/Fundus_Auto_Fluorescence/OptimEYES_Prospective/AF_IR_images_OptimEYES'
    
    # Define the destination directory where images should be copied
    destination_directory = '/data/coris_db_subsets/AMD/Auto-Fluorescences/OptimEYES_Prospective/Test_Train_AV'
    
    # Define the column name in the CSV that contains the image paths
    image_column_name = 'file_path_coris'
    
    # Run the function
    copy_images(csv_file_path, source_directory, destination_directory, image_column_name)
