import os

def check_folders(base_path):
    mismatched_folders = []
    dcm_only_folders = []

    # Walk through all folders and subfolders
    for root, dirs, files in os.walk(base_path):
        # Separate .dcm and .j2k files
        dcm_files = [f for f in files if f.endswith('.dcm')]
        j2k_files = [f for f in files if f.endswith('.j2k')]

        # If the folder only contains .dcm files, add to dcm_only_folders
        if dcm_files and not j2k_files:
            dcm_only_folders.append((root, '.dcm'))
            continue

        # Check prefix of .j2k files before '-'
        j2k_prefixes = set(f.split('-')[0] for f in j2k_files)

        # Check if there is a matching .dcm file for each prefix
        for prefix in j2k_prefixes:
            matching_dcm = any(f.startswith(prefix) for f in dcm_files)
            if not matching_dcm:
                mismatched_folders.append((root, '.j2k'))
                break

    return mismatched_folders, dcm_only_folders

# Define the base path
base_path = '/persist/PACS/DICOM'

# Check folders and print mismatched ones
mismatched_folders, dcm_only_folders = check_folders(base_path)
if mismatched_folders:
    print("Mismatched folders:")
    for folder, file_extension in mismatched_folders:
        print(f"Folder: {folder}, Mismatched file extension: {file_extension}")
else:
    print("All folders are good.")

if dcm_only_folders:
    print("Folders that only contain .dcm files:")
    for folder, file_extension in dcm_only_folders:
        print(f"Folder: {folder}, File extension: {file_extension}")



###########check file names under certain folder##############
# Define the file path
#file_path = "/persist/PACS/DICOM/35223/390753"  ##only contains j2k
file_path = "/persist/PACS/DICOM/49557/458020" ##only contains j2k

# List all files in the directory
file_names = os.listdir(file_path)

# Print the file names
print(file_names)
