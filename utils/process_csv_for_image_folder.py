import pandas as pd
import os

def filter_csv_by_filenames(csv_path, folder_path, column_name):
    """
    Filters rows in a CSV file based on the presence of corresponding files in a specified folder.

    Parameters:
        csv_path (str): The path to the CSV file.
        folder_path (str): The directory path where the files are stored.
        column_name (str): The name of the column in the CSV to match filenames against.

    Returns:
        DataFrame: A pandas DataFrame containing only the rows where the file exists.
    """
    # Load the CSV file
    df = pd.read_csv(csv_path)

    # Get a set of filenames existing in the folder
    filenames = {file.lower() for file in os.listdir(folder_path)}

    # Create a new column that will hold the standardized filename to compare against
    # df['filename_to_check'] = df[column_name].apply(lambda x: str(x).lower().strip())
    df['filename_to_check'] = df[column_name].apply(lambda x: os.path.basename(str(x)).lower().strip())


    # Filter the DataFrame based on file presence
    filtered_df = df[df['filename_to_check'].isin(filenames)]

    # Drop the helper column as it's no longer needed
    filtered_df = filtered_df.drop(columns=['filename_to_check'])

    return filtered_df

# Example usage
csv_file_path = '/projects/coris_db_subsets/AMD/Fundus_Auto_Fluorescence/OptimEYES_Prospective/OptimEYES_Prospective_GA_Cohort.csv'  # Update this path
directory_path = '/data/coris_db_subsets/AMD/Auto-Fluorescences/OptimEYES_Prospective/Test_Train_SM'  # Update this path
column_to_match = 'file_path_coris'  # Update this column name

# Perform the filtering
resulting_df = filter_csv_by_filenames(csv_file_path, directory_path, column_to_match)

# Save the filtered DataFrame to a new CSV
resulting_df.to_csv('/projects/coris_db_subsets/AMD/Fundus_Auto_Fluorescence/OptimEYES_Prospective/OptimEYES_Prospective_GA_Cohort_Good_Quality.csv', index=False)
