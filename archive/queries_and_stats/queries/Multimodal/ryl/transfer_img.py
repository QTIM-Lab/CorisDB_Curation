import shutil
import os

# Path to your CSV file
csv_file_path = "/projects/coris_db/postgres/queries_and_stats/queries/Multimodal/ryl/paths.csv" 

# Input directory where the Python script expects the image files
input_dir = "/projects/coris_db_subsets/Image_Conversion/INPUT" 

# Open the CSV file and read each line
with open(csv_file_path, 'r') as file:
    for line in file:
        # Remove whitespace and newline characters, then strip double quotes
        file_path = line.strip().strip('"')
        if os.path.exists(file_path):  # Check if the source file exists
            # Construct the destination path
            dest_path = os.path.join(input_dir, os.path.basename(file_path))
            # Copy the file
            shutil.copyfile(file_path, dest_path)
        else:
            print(f"File does not exist: {file_path}")

print("File transfer complete.")

