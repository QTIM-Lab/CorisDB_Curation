import os, pdb
import pandas as pd
import psycopg

class Coris:
    def __init__(self, \
                 DB_DATABASE='', \
                 DB_USER='', \
                 DB_PASSWORD='', \
                 DB_HOST='', \
                 DB_PORT=''):
            # Class-level variables (optional)
        self.conn = psycopg.connect(dbname=os.getenv('DB_DATABASE'),
                                    user=os.getenv('DB_USER'),
                                    password=os.getenv('DB_PASSWORD'),
                                    host=os.getenv('DB_HOST'),
                                    port=os.getenv('DB_PORT'))    
        
    def get_tables(self, schema='ehr'):
        try:
            with self.conn.cursor() as cur:
                # Open a cursor to perform database operations
                # pdb.set_trace()
                query = f"""
                SELECT table_name
                FROM information_schema.tables
                WHERE table_schema = '{schema}'
                AND table_type = 'BASE TABLE'
                """
                print(query)
                cur.execute(query)
                records = cur.fetchall()
                df = pd.DataFrame(records, columns=['table_names'])
                self.conn.commit()  # Commit the transaction if successful
                return df
        except psycopg.errors.InFailedSqlTransaction:
            # Rollback the transaction if it failed
            self.conn.rollback()
            # Handle the error or log it appropriately


class Table(Coris):
    # Constructor (optional)
    def __init__(self, *args, SCHEMA='ehr', TABLE_NAME=None, LIMIT=None, **kwargs):
        super().__init__(*args, **kwargs)
        self.schema = SCHEMA
        self.table_name = TABLE_NAME
        self.limit = LIMIT

    @property
    def DataFrame(self):
        table_cols_and_their_types = self._get_columns_and_types()
        column_names = [item[0] for item in table_cols_and_their_types]
        data_types = [item[1] for item in table_cols_and_their_types]
        character_maximum_lengths = [item[2] for item in table_cols_and_their_types]
        records = self._get_records()
        df = pd.DataFrame(records, columns=column_names)
        return df


    def _get_columns_and_types(self):
        # Method body
        try:
            with self.conn.cursor() as cur:
                # Open a cursor to perform database operations
                cur.execute(
                f"""
                select column_name, data_type, character_maximum_length
                from information_schema.columns
                where table_schema = '{self.schema}'
                AND table_name = '{self.table_name}';
                """)
                records = cur.fetchall()
                self.conn.commit()  # Commit the transaction if successful
                return records
        except psycopg.errors.InFailedSqlTransaction:
            # Rollback the transaction if it failed
            self.conn.rollback()
            # Handle the error or log it appropriately


    def _get_records(self):
        try:
            with self.conn.cursor() as cur:
                # Open a cursor to perform database operations
                # pdb.set_trace()
                cur.execute(
                f"""
                select * from {self.schema}.{self.table_name} 
                {f"limit {self.limit}" if self.limit is not None else ''};
                """)
                records = cur.fetchall()
                self.conn.commit()  # Commit the transaction if successful
                return records
        except psycopg.errors.InFailedSqlTransaction:
            # Rollback the transaction if it failed
            self.conn.rollback()
            # Handle the error or log it appropriately

   
def CompareTables(Table1, Table2):
    header = ['table1_column_name', 'table2_column_name', 'count']
    join_counts = pd.DataFrame(columns = header)
    for table1_column_name, table1_data_type, table1_character_maximum_length in Table1._get_columns_and_types():
        for table2_column_name, table2_data_type, table2_character_maximum_length in Table2._get_columns_and_types():
            try:
                with Table1.conn.cursor() as cur:
                    # Open a cursor to perform database operations
                    where_filter = cast_rules(table1_data_type, table2_data_type, table1_column_name, table2_column_name, Table2.schema, Table2.table_name)
                    query = f"""
                    select count(distinct {table1_column_name}) from {Table1.schema}.{Table1.table_name}
                    where {where_filter}
                    """
                    print(query)
                    cur.execute(query)
                    records = cur.fetchall()
                    join_counts_row = pd.DataFrame([(table1_column_name, table2_column_name, records[0][0])], columns=header)
                    join_counts = pd.concat([join_counts_row, join_counts], axis=0)
                    Table1.conn.commit()  # Commit the transaction if successful
                    # pdb.set_trace()
            except psycopg.errors.InFailedSqlTransaction:
                # Rollback the transaction if it failed
                Table1.conn.rollback()
                # Handle the error or log it appropriately
    
    join_counts.sort_values('count', ascending=False, inplace=True)
    return join_counts
        

def cast_rules(table1_data_type, table2_data_type, table1_column_name, table2_column_name, table2_schema, table2_table_name):
    # pdb.set_trace()
    """
    Designed to give table 1 preference and will cast table 2's column to match table 1's.
    """
    print(table1_data_type, table2_data_type)
    if table1_data_type == 'integer' and table2_data_type == 'integer':
        where_filter = f"{table1_column_name} in (select distinct {table2_column_name} from {table2_schema}.{table2_table_name})"

    elif table1_data_type == 'integer' and table2_data_type == 'character varying':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct {table2_column_name} from {table2_schema}.{table2_table_name})"
    elif table1_data_type == 'character varying' and table2_data_type == 'integer':
        where_filter = f"{table1_column_name} in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"

    elif table1_data_type == 'character varying' and table2_data_type == 'timestamp with time zone':
        where_filter = f"{table1_column_name} in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"
    elif table1_data_type == 'timestamp with time zone' and table2_data_type == 'character varying':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct {table2_column_name} from {table2_schema}.{table2_table_name})"

    elif table1_data_type == 'text' and table2_data_type == 'timestamp with time zone':
        where_filter = f"{table1_column_name} in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"
    elif table1_data_type == 'timestamp with time zone' and table2_data_type == 'text':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct {table2_column_name} from {table2_schema}.{table2_table_name})"

    elif table1_data_type == 'text' and table2_data_type == 'integer':
        where_filter = f"{table1_column_name} in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"
    elif table1_data_type == 'integer' and table2_data_type == 'text':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct {table2_column_name} from {table2_schema}.{table2_table_name})"

    elif table1_data_type == 'text' and table2_data_type == 'numeric':
        where_filter = f"{table1_column_name} in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"
    elif table1_data_type == 'numeric' and table2_data_type == 'text':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct {table2_column_name} from {table2_schema}.{table2_table_name})"

    elif table1_data_type == 'text' and table2_data_type == 'bigint':
        where_filter = f"{table1_column_name} in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"
    elif table1_data_type == 'bigint' and table2_data_type == 'text':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct {table2_column_name} from {table2_schema}.{table2_table_name})"


    elif table1_data_type == 'integer' and table2_data_type == 'timestamp with time zone':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"
    elif table1_data_type == 'timestamp with time zone' and table2_data_type == 'integer':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"

    elif table1_data_type == 'numeric' and table2_data_type == 'timestamp with time zone':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"
    elif table1_data_type == 'timestamp with time zone' and table2_data_type == 'numeric':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"

    elif table1_data_type == 'bigint' and table2_data_type == 'timestamp with time zone':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"
    elif table1_data_type == 'timestamp with time zone' and table2_data_type == 'bigint':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"

    elif table1_data_type == 'integer' and table2_data_type == 'time without time zone':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"
    elif table1_data_type == 'time without time zone' and table2_data_type == 'integer':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"

    elif table1_data_type == 'character varying' and table2_data_type == 'time without time zone':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"
    elif table1_data_type == 'time without time zone' and table2_data_type == 'character varying':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"


    elif table1_data_type == 'character varying' and table2_data_type == 'numeric':
        where_filter = f"{table1_column_name} in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"
    elif table1_data_type == 'numeric' and table2_data_type == 'character varying':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct {table2_column_name} from {table2_schema}.{table2_table_name})"

    elif table1_data_type == 'character varying' and table2_data_type == 'bigint':
        where_filter = f"{table1_column_name} in (select distinct cast({table2_column_name} as varchar) from {table2_schema}.{table2_table_name})"
    elif table1_data_type == 'bigint' and table2_data_type == 'character varying':
        where_filter = f"cast({table1_column_name} as varchar) in (select distinct {table2_column_name} from {table2_schema}.{table2_table_name})"


    else:
        where_filter = f"{table1_column_name} in (select distinct {table2_column_name} from {table2_schema}.{table2_table_name})"

    return where_filter