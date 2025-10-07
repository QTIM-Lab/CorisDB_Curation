. ~/.bashrc
pyenv virtualenvs
pyenv deactivate
pyenv activate corisdb_curation
cd CorisDB_Curation/22-2198-AMD/amd.hh_c3854

#pip install pandas /sqlalchemy/ psycopg2
#pip install sqlalchemy

python # Start interpreter
import pandas as pd


# Load the CSV file
file_path = '/scratch90/QTIM/Active/23-0284/EHR/CorisDB_Curation/22-2198-AMD/amd.hh_c3854/amd.hh_t2_note_image_20250423.csv'
df = pd.read_csv(file_path)

# Get all column headers
column_headers = df.columns.tolist()

# Get distinct count for each column
distinct_counts = df.nunique()

# Print the results
print("Column Headers:", column_headers)
print("Distinct Counts for each column:")
print(distinct_counts)

