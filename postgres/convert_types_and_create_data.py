import os, pdb, pandas as pd

type_key={
    "INTEGER":"INTEGER",
    "BIGINT":"BIGINT",
    "STRING":"VARCHAR(100)",
    "LONG_STRING":"VARCHAR(500)",
    "TEXT":"TEXT",
    "DATETIME":"TIMESTAMP WITH TIME ZONE",
    "TIMESTAMP":"TIMESTAMP WITH TIME ZONE",
    "DATE":"TIMESTAMP WITH TIME ZONE",
    "FLOAT":"NUMERIC(18,6)",
}

data_key={
    "INTEGER":"1",
    "BIGINT":"10000000000",
    "STRING":"sample_text",
    "LONG_STRING":"Long sample_text-----------------------------------------------------------------------------------",
    "TEXT":"text "*1000,
    "DATETIME":"2023-02-21 00:00:00-07",
    "TIMESTAMP":"2023-02-21 00:00:00-07",
    "DATE":"2023-02-21 00:00:00-07",
    "FLOAT":"1.0",
}

DATE="20230217"

table_def_orig_csvs_path = "table_def_orig_csvs"
sample_data_csvs_path = "sample_data"
tables_for_import_path = "/projects/CORIS_DB/tmp_for_import"


def retrieve_csv_cols_and_types(path=""):
    """
    Return the column names and types for CREATE TABLE Statement creation
    """
    with open(path, "r") as csv_file:
        # pdb.set_trace()
        csv_data = csv_file.readlines()
        header = csv_data[0].replace("\n", "")
        data = [i.replace("\n","") for i in csv_data[1:]]
        col_and_type = [(i.split(",")[0], i.split(",")[1]) for i in data]
        col, type = zip(*col_and_type)
        return col, type

def create_table_code(table, cols, types):
    template = f"CREATE TABLE IF NOT EXISTS {table} (\n"
    cols_count = len(cols)
    index = 0
    columns_code = ""
    for col, type in zip(cols,types):
        index+=1
        constraint=""
        if cols_count != index:
            columns_code += f"    {col} {type_key[type]}{constraint},\n"
        else:
            columns_code += f"    {col} {type_key[type]}{constraint}\n"
    
    template += columns_code 
    template += """
    --table_constraints
    );\n\n"""
    
    return template

def create_sample_data(table, cols, types):
    sd = pd.DataFrame({col:[data_key[type]] for col, type in zip(cols, types)})
    return sd

def create_bulk_insert_statements(table):
    # pdb.set_trace()
    # template = f"\copy {table} FROM './{table}_sd.csv' DELIMITERS ',' CSV QUOTE '''' HEADER;\n" # _sd sample data
    template = f"\copy {table} FROM '{tables_for_import_path}/{table}_{DATE}.csv' DELIMITERS ',' NULL AS 'NULL' CSV QUOTE '''' HEADER;\n"
    return template

def create_drop_statements(table):
    # pdb.set_trace()
    template = f"DROP TABLE {table};\n"    
    return template


for csv in [i for i in os.listdir(table_def_orig_csvs_path) if i.find(".csv") != -1]:
    table = csv.replace(".csv","")
    print(f"Creating Table {table} from {table_def_orig_csvs_path}/{csv}")
    cols, types = retrieve_csv_cols_and_types(path=os.path.join(table_def_orig_csvs_path, csv))
    table_code = create_table_code(table, cols, types)
    sample_data = create_sample_data(table, cols, types)
    bulk_insert_code = create_bulk_insert_statements(table)
    drop_statements_code = create_drop_statements(table)
    # sample_data.to_csv( os.path.join(sample_data_csvs_path, table+"_sd"+".csv") , index=None)
    # Create Tables Script
    append_or_write_ct = 'a' if os.path.exists(os.path.join(table_def_orig_csvs_path, "create_tables.sql")) else "w"
    # pdb.set_trace()
    with open(os.path.join(table_def_orig_csvs_path, "create_tables.sql"), append_or_write_ct) as create_tables_file:
        create_tables_file.write(table_code)
    # Bulk Insert Statements Script
    append_or_write_sd = 'a' if os.path.exists(os.path.join(sample_data_csvs_path, "bulk_insert_sample_data.sql")) else "w"
    with open(os.path.join(sample_data_csvs_path, "bulk_insert_sample_data.sql"), append_or_write_sd) as create_tables_file:
            create_tables_file.write(bulk_insert_code)
    # Drop Table Statements Script
    append_or_write_sd = 'a' if os.path.exists(os.path.join(sample_data_csvs_path, "drop_statements.sql")) else "w"
    with open(os.path.join(sample_data_csvs_path, "drop_statements.sql"), append_or_write_sd) as drop_tables_file:
            drop_tables_file.write(drop_statements_code)
    
    

