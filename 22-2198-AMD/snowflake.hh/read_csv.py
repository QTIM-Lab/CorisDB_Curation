import os
import pandas as pd
import re
# Define the folder path
folder_path = '/scratch90/QTIM/Active/23-0284/EHR/CorisDB_Curation/22-2198-AMD/snowflake.hh'

# Function to perform natural sorting
def natural_sort_key(s):
    return [int(text) if text.isdigit() else text.lower() for text in re.split(r'(\d+)', s)]

# Initialize an empty list to store the results
results = []

# Initialize counters for total rows and rows with 'Cirrus Photo (Scans)'
total_rows = 0
cirrus_photo_scans_rows = 0

# Iterate over all files in the folder
for file_name in os.listdir(folder_path):
    if file_name.endswith('.csv') and re.search(r'\d+\.csv$', file_name):
        file_path = os.path.join(folder_path, file_name)
        try:
            df = pd.read_csv(file_path)
            total_rows += len(df)
            cirrus_photo_scans_rows += len(df[df['devproc'] == 'Cirrus Photo (Scans)'])
            for column_name in df.columns:
                unique_count = df[column_name].nunique()
                results.append([file_name, column_name, unique_count])
        except Exception as e:
            print(f"Error reading {file_name}: {e}")

# Convert the results list to a DataFrame
results_df = pd.DataFrame(results, columns=['File Name', 'Column Name', 'Unique Count'])

# Create DataFrames for total rows and Cirrus Photo (Scans) rows
summary_df = pd.DataFrame([
    ['Total', 'Rows', total_rows],
    ['Total', 'Cirrus Photo (Scans) Rows', cirrus_photo_scans_rows]
], columns=['File Name', 'Column Name', 'Unique Count'])

# Concatenate the results
results_df = pd.concat([results_df, summary_df], ignore_index=True)

# Sort the DataFrame by file name using natural sorting
results_df = results_df.sort_values(
    by='File Name',
    key=lambda col: col.map(natural_sort_key)
)

# Save the results to a CSV file
output_file_path = os.path.join(folder_path, 'read_csv.csv')
results_df.to_csv(output_file_path, index=False)

print(f"Results saved to {output_file_path}")


