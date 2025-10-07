import json, os
import pandas as pd
import pdb
from google.cloud import bigquery
import math
#from datetime import datetime

class Table:
    # Class attribute
    project = "hdcdmcoris"
    server = "coris_registry"
    # Initialize a BigQuery client
    client = bigquery.Client()

    def __init__(self, table_name, gbq_table_name, tmp_working_area):
        """
        Constructor method to initialize the table.
        """
        self.table_name = table_name
        self.gbq_table_name = gbq_table_name
        self.tmp_working_area = tmp_working_area
        self.where_statements = [] # Only needed for super large tables (pulling in bins with where filters)
        self.rows = None # default is to not have any but upon initialization, we populate with `set_row_count`

    def set_row_count(self):   
        query = f"""select count (*) from {Table.project}.{Table.server}.{self.gbq_table_name};""";
        query_job = Table.client.query(query)
        # Fetch results
        results = query_job.result()
        # Convert results to list of dictionaries
        results = [dict(row.items()) for row in results]
        self.rows = results[0]['f0_']
    
    def get_scheme(self):
        query = f"""
        SELECT column_name, data_type
        FROM hdcdmcoris.coris_registry.INFORMATION_SCHEMA.COLUMNS
        WHERE table_name = '{self.gbq_table_name}'
        """;
        query_job = Table.client.query(query)
        # Fetch results
        results = query_job.result()
        # Convert results to list of dictionaries
        results = [dict(row.items()) for row in results]
        # Create a Pandas DataFrame
        df = pd.DataFrame(results)
        return df

    def get_table(self, limit=None, pieces=1):
        # Instance method
        if pieces == 1:
            # Run a query
            limit_clause = '' if limit is None else f'limit {limit}'
            query = f"""select * from {Table.project}.{Table.server}.{self.gbq_table_name} {limit_clause}"""; query_job = Table.client.query(query)
            # Fetch results
            results = query_job.result()
            # Convert results to list of dictionaries
            results = [dict(row.items()) for row in results]
            # Create a Pandas DataFrame
            df = pd.DataFrame(results)
            path = os.path.join(self.tmp_working_area, f"{self.table_name}.csv")
            df.to_csv(path, index=None)
        else:
            # We need the Table Scheme
            scheme = self.get_scheme()
            order_by = ""
            scheme['column_name'].to_list()
            for i, col in enumerate(scheme['column_name']):
                order_by += f"{col} ASC,\n" if i + 1 != scheme.shape[0] else f"{col} ASC\n"
            
            # We need to force the order of the table
            # by all columns to force reproduceability.
            query = f"""
            select * from (
                select
                (row_number() 
                    over (
                    order by 
                        {order_by}
                    )
                ) as row_num
                ,*
                from {Table.project}.{Table.server}.{self.gbq_table_name}
                order by 
                    {order_by}
            )
            """
            # Based on var pieces, calculate where filters to make subsequent queries
            self.set_row_count() # Need for the math
            limit = math.floor(self.rows / pieces)
            left_over = self.rows % pieces
            for piece in range(pieces):
                left_limit = piece * limit + 1
                right_limit = (piece+1) * limit + 1
                self.where_statements.append(f"where row_num >= {left_limit} and row_num < {right_limit} order by row_num")

            if left_over != 0:
                self.where_statements.append(f"where row_num >= {right_limit} and row_num <= {self.rows} order by row_num")

            # For each where block, make the query and append to file
            for i, where in enumerate(self.where_statements):
                print(f"On range: {where} (~{100*(i+1)/pieces}%) and total row count is: {self.rows}")
                q = f"{query} {where}"; query_job = Table.client.query(q)
                # Fetch results
                results = query_job.result()
                # Convert results to list of dictionaries
                results = [dict(row.items()) for row in results]
                # Create a Pandas DataFrame
                df = pd.DataFrame(results)
                path = os.path.join(self.tmp_working_area, f"{self.table_name}.csv")
                if not os.path.exists(path) or i == 0:
                    df[[col for col in df.columns if col != 'row_num']].to_csv(path, index=None, mode='w')
                else:
                    df[[col for col in df.columns if col != 'row_num']].to_csv(path, index=None, mode='a', header=False)


    def make_postgres_importable_file(self):
        # We need the Table Scheme
        scheme = self.get_scheme()
        type_key = {
            "INT64": "Int64", 
            "STRING": "str",
            "TIME": "object", 
            "DATETIME": "object",  
            "TIMESTAMP": "object",  
            "DATE": "object",  
            "FLOAT64": "float",  
            "NUMERIC": "float",
            "INTEGER": "Int64"
        }
        scheme['Type_pandas'] = scheme['data_type'].apply(lambda x: type_key[x])
        new_types = dict(zip(scheme['column_name'], scheme['Type_pandas']))
        
        tmp = pd.read_csv(os.path.join(self.tmp_working_area, f"{self.table_name}.csv"), quotechar='"', dtype=object)
        
        # Convert datetime columns separately
        for col, dtype in new_types.items():
            if dtype == 'object' and col in tmp.columns:
                if scheme[scheme['column_name'] == col]['data_type'].iloc[0] in ['DATETIME', 'TIMESTAMP', 'DATE']:
                    if scheme[scheme['column_name'] == col]['data_type'].iloc[0] == 'DATE':
                        # Convert DATE fields (YYYY-MM-DD format)
                        tmp[col] = pd.to_datetime(tmp[col], format='%Y-%m-%d', errors='coerce').dt.date
                    elif scheme[scheme['column_name'] == col]['data_type'].iloc[0] == 'TIME':
                        # Convert DATETIME fields (HH:MM:SS format)
                        tmp[col] = pd.to_datetime(tmp[col], format='%H:%M:%S', errors='coerce')
                    elif scheme[scheme['column_name'] == col]['data_type'].iloc[0] == 'DATETIME':
                        # Convert DATETIME fields (YYYY-MM-DD HH:MM:SS format)
                        tmp[col] = pd.to_datetime(tmp[col], format='%Y-%m-%d %H:%M:%S', errors='coerce')
                    elif scheme[scheme['column_name'] == col]['data_type'].iloc[0] == 'TIMESTAMP':
                        # Convert TIMESTAMP fields (with time zone)
                        tmp[col] = pd.to_datetime(tmp[col], format='%Y-%m-%d %H:%M:%S%z', errors='coerce')
                        
            elif dtype in ['Int64', 'float']:
                #tmp[col] = tmp[col].fillna(0)
                tmp[col] = pd.to_numeric(tmp[col], errors='coerce')
                tmp[col] = tmp[col].astype(dtype)

            else:
                tmp[col] = tmp[col].astype(dtype)

        # Save the modified CSV for PostgreSQL import
        if not os.path.exists(os.path.join(self.tmp_working_area, "tmp_for_import")):
            os.mkdir(os.path.join(self.tmp_working_area, "tmp_for_import"))
            
        tmp.to_csv(os.path.join(self.tmp_working_area, "tmp_for_import", f"{self.table_name}.csv"), 
                na_rep='', index=None, quotechar='"', lineterminator="\n")


    def get_create_table_statement(self, postgres_types=False):
        """
        postgres_types: When True we look up more granular postgres types. When False, reasonable approximations are used.
            Ex: GBQ only have INT64 integer types. Postgres has SMALLINT, INTEGER, BIGINT...
        """
        if postgres_types:
            postgres_types_df = pd.read_csv(os.path.join("postgres_types", f"{self.table_name}.csv"))
            with open(os.path.join("postgres_queries", f"create_table_{self.table_name}.sql"), mode='w') as file:
                file.write(f"DROP TABLE IF EXISTS {Table.server}.{self.gbq_table_name};\n")
                create_table_statement = f"CREATE TABLE IF NOT EXISTS {Table.server}.{self.gbq_table_name} (\n"
                col_and_type_definition_block = ""
                for index, (col, type) in enumerate(zip(postgres_types_df['Field name'], postgres_types_df['PostgresType'])):
                    if postgres_types_df.shape[0] != index+1:
                        col_and_type_definition_block += f"    {col} {type},\n"
                    else:
                        col_and_type_definition_block += f"    {col} {type}"
                create_table_statement += col_and_type_definition_block 
                create_table_statement += """
                );\n\n"""
                file.write(create_table_statement)    
        else:
            query = f"""
            SELECT
            table_name, ddl
            FROM {Table.project}.{Table.server}.INFORMATION_SCHEMA.TABLES
            WHERE table_name = '{self.gbq_table_name}';
            """;
            query_job = Table.client.query(query)
            # Fetch results
            results = query_job.result()
            # Convert results to list of dictionaries
            results = [dict(row.items()) for row in results]
            with open(os.path.join("postgres_queries", f"create_table_{self.table_name}.sql"), mode='w') as file:
                r = results[0]['ddl'].replace('hdcdmcoris.', '')
                # Postgres types and formatting
                ## remove db project in GBQ
                r = r.replace('hdcdmcoris.', '')
                ## remove "`"
                r = r.replace('`', '')
                ## data types conversion
                r = r.replace('INT,', 'BIGINT,')  # Change INT64 to BIGINT
                r = r.replace('INT,\n', 'BIGINT\n')
                r = r.replace('INT64,', 'BIGINT,')  # Change INT64 to BIGINT
                r = r.replace('INT64,\n', 'BIGINT\n')
                r = r.replace('FLOAT64,', 'FLOAT8,')  # Use FLOAT8 instead of NUMERIC
                r = r.replace('FLOAT64\n', 'FLOAT8\n')
                r = r.replace('STRING,', 'TEXT,')  # Use TEXT for variable-length
                r = r.replace('STRING\n', 'TEXT\n')
                r = r.replace('TIME,', 'TIME,')
                r = r.replace('TIME\n', 'TIME\n')
                r = r.replace('TIMESTAMP,', 'TIMESTAMP,')
                r = r.replace('TIMESTAMP\n', 'TIMESTAMP\n')
                r = r.replace('DATE,', 'DATE,')  # DATE remains DATE
                r = r.replace('DATE\n', 'DATE\n')
                file.write(f"DROP TABLE IF EXISTS {Table.server}.{results[0]['table_name']};\n")
                file.write(r)
                file.write("\n\n") 


    def get_create_insert_statement(self):
        with open(os.path.join("postgres_queries", f"import_table_{self.table_name}.sql"), mode='w') as file:
            insert_query = f"""\copy {Table.server}.{self.gbq_table_name} FROM '{self.tmp_working_area}/tmp_for_import/{self.table_name}.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;"""
            file.write(f"{insert_query}\n")

    



    # @classmethod
    # def class_method(cls):
    #     """
    #     Class method to perform some operation related to the class.
    #     """
    #     print(f"This is a class method. Class variable: {cls.server}")

    # @staticmethod
    # def static_method(param):
    #     """
    #     Static method to perform some operation. Does not depend on class or instance.
    #     """
    #     print(f"This is a static method. Parameter: {param}")
