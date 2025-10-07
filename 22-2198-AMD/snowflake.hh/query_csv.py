import numpy as np
import pandas as pd
import psycopg2
import time

# Database connection parameters
db_params = {
    'dbname': 'coris_db',
    'user': 'coris_admin',
    'password': '',
    'host': 'localhost',
    'port': '5432'
}

def run_query(query: str) -> pd.DataFrame:
    """Returns a dataframe with the results of the given query"""

    # connect to the axispacs imaging database
    conn = psycopg2.connect(**db_params)

    # process data
    try:
        # run query on database        
        cursor = conn.cursor()
        cursor.execute(query)

        # Fetch the column names
        colnames = [desc[0] for desc in cursor.description]

        # Fetch the data
        data = cursor.fetchall()

        # Create a pandas DataFrame for raw data
        df = pd.DataFrame(data, columns=colnames)

        return df
        
    except psycopg2.Error as e:
        print(f"Error: {e}")
        return None
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

# Read the query from the file
query_file_path = '/scratch90/QTIM/Active/23-0284/EHR/CorisDB_Curation/22-2198-AMD/snowflake.hh/snowflake.hh_t1_cohort.sql'
with open(query_file_path, 'r') as file:
    query = file.read()

# Track the start time
start_time = time.time()

# Run the query and get the results as a DataFrame
df = run_query(query)

# Track the end time
end_time = time.time()

# Calculate the time spent
time_spent = end_time - start_time

# Write the DataFrame to a CSV file
output_csv_path = '/scratch90/QTIM/Active/23-0284/EHR/CorisDB_Curation/22-2198-AMD/snowflake.hh/snowflake.hh_t1_cohort_20250527.csv'
if df is not None:
    df.to_csv(output_csv_path, index=False)
    print(f"The query results have been written to {output_csv_path}.")
else:
    print("Failed to retrieve data from the database.")

print(f"Time spent from start to finish: {time_spent} seconds.")