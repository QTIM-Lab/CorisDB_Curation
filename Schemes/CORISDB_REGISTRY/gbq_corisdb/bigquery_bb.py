```bash
source ~/.bashrc; pyenv activate corisdb_curation; python

````

import json, os
import pandas as pd
import pdb
from google.cloud import bigquery
import math

# Initialize a BigQuery client
client = bigquery.Client()

tables = [
  "C3304_GBQ_T19_MYC_Messages_20240531",
# "C3304_GBQ_T20_BillingCode_20240610",
# "C3304_GBQ_T15_Referral_20240207",
# "C3304_GBQ_T4_Proc_OrderedEMR_20240207",
# "C3304_T1_Person_20231222",
# "C3304_GBQ_T6_Surgeries_20240207",
# "C3304_T11_Notes_20231222",
# "C3304_GBQ_T16_CensusData2018_20240207",
# "C3304_GBQ_T11_Notes_20240207",
# "C3304_GBQ_T5_Procedures_20240207",
# "C3304_GBQ_T8_Labs_20240207",
# "C3304_GBQ_T2_Encounter_20240207",
# "C3304_GBQ_T1_Person_20240207",
# "C3304_GBQ_T14_Allergy_20240207",
# "C3304_GBQ_T18_OphthamologyExams_20240207",
# "C3304_GBQ_T9_ADT_20240207",
# "C3304_GBQ_T13_SocialHistory_20240207",
# "C3304_GBQ_T3_Diagnosis_20240207",
# "C3304_T3_Diagnosis_20231222",
# "C3304_GBQ_T17_CensusData2014_20240207",
# "C3304_GBQ_T10_Flowsheets_20240207",
# "C3304_T18_OphthamologyExams_20231222",
# "C3304_GBQ_T12_FamilyHistory_20240207",
# "C3304_T2_Encounter_20231222",
]

len(tables)

# special case for billing as it is so large

pieces = 10000
rows = 406177872
limit = math.floor(rows / pieces)
left_over = rows % pieces
# limit*pieces + left_over
wheres = []
for piece in range(pieces):
    left_limit = piece * limit + 1
    right_limit = (piece+1) * limit + 1
    wheres.append(f"where row_num >= {left_limit} and row_num < {right_limit} order by row_num")

if left_over != 0:
    wheres.append(f"where row_num >= {right_limit} and row_num <= {406177872} order by row_num")


query = """
select * from (
  select
  (row_number() 
    over (
      order by 
          Arb_Person_ID ASC, 
          Arb_Encounter_Id ASC, 
          ICD_Code ASC, 
          Billing_Code ASC, 
          CPT_Code ASC, 
          Loinc_Code ASC, 
          SNOMED_Code ASC
      )
  ) as row_num
  ,*
  from `coris_registry.C3304_GBQ_T20_BillingCode_20240610`
  order by 
          Arb_Person_ID ASC, 
          Arb_Encounter_Id ASC, 
          ICD_Code ASC, 
          Billing_Code ASC, 
          CPT_Code ASC, 
          Loinc_Code ASC, 
          SNOMED_Code ASC
)
"""

def get_table(table, query=None, wheres=None):
    if query is None:
        # Run a query
        query = f"""select * from `coris_registry.{table}`"""; query_job = client.query(query)
        # Fetch results
        results = query_job.result()
        # Convert results to list of dictionaries
        results = [dict(row.items()) for row in results]
        # Create a Pandas DataFrame
        df = pd.DataFrame(results)
        path = f"/data/linking_various_systems/coris_db_gbq/{table}.csv"
        df.to_csv(path, index=None)
    else:
        for i, where in enumerate(wheres):
            print(f"On range: {where}")
            q = f"{query} {where}"; query_job = client.query(q)
            # Fetch results
            results = query_job.result()
            # Convert results to list of dictionaries
            results = [dict(row.items()) for row in results]
            # Create a Pandas DataFrame
            df = pd.DataFrame(results)
            path = f"/data/linking_various_systems/coris_db_gbq/{table}.csv"
            if not os.path.exists(path) or i == 0:
                df[[col for col in df.columns if col != 'row_num']].to_csv(path, index=None, mode='w')
            else:
                df[[col for col in df.columns if col != 'row_num']].to_csv(path, index=None, mode='a', header=False)
            # pdb.set_trace()



# Can loop through tables but it takes a while.
# Do in parallel in tmux instead
# get_table("C3304_lGBQ_T19_MYC_Messages_20240531") # done
get_table("C3304_GBQ_T20_BillingCode_20240610", query=query, wheres=wheres) # done
# get_table("C3304_GBQ_T15_Referral_20240207") # done
# get_table("C3304_GBQ_T4_Proc_OrderedEMR_20240207") # done
# get_table("C3304_T1_Person_20231222") # done
# get_table("C3304_GBQ_T6_Surgeries_20240207") # done
# get_table("C3304_T11_Notes_20231222") # done
# get_table("C3304_GBQ_T16_CensusData2018_20240207") # done
# get_table("C3304_GBQ_T11_Notes_20240207") # done
# get_table("C3304_GBQ_T5_Procedures_20240207") # done
# get_table("C3304_GBQ_T8_Labs_20240207") # done
# get_table("C3304_GBQ_T2_Encounter_20240207") # done
# get_table("C3304_GBQ_T1_Person_20240207") # done
# get_table("C3304_GBQ_T14_Allergy_20240207") # done
# get_table("C3304_GBQ_T18_OphthamologyExams_20240207") # done
# get_table("C3304_GBQ_T9_ADT_20240207") # done
# get_table("C3304_GBQ_T13_SocialHistory_20240207") # done
# get_table("C3304_GBQ_T3_Diagnosis_20240207") # done
# get_table("C3304_T3_Diagnosis_20231222") # done
# get_table("C3304_GBQ_T17_CensusData2014_20240207") # done
# get_table("C3304_GBQ_T10_Flowsheets_20240207") # done
# get_table("C3304_T18_OphthamologyExams_20231222") # done
# get_table("C3304_GBQ_T12_FamilyHistory_20240207") # done
# get_table("C3304_T2_Encounter_20231222") # done


def get_create_table_statements():
    # Run a query
    """
    BEWARE: 
            - postgres/gbq_corisdb/create_tables.sql
              This file is created by this function BUT
              INTEGER data dytpes sometimes need to become BIGINT in create_tables.sql.
              INTEGER data dytpes sometimes need to become NUMERIC in create_tables.sql.
              
              I manually changed these as this function doesn't handle that.
              That is in create_tables_manual_types.sql
    """
    query = f"""
    SELECT
    table_name, ddl
    FROM `coris_registry`.INFORMATION_SCHEMA.TABLES
    """;
    query_job = client.query(query)
    # Fetch results
    results = query_job.result()
    # Convert results to list of dictionaries
    results = [dict(row.items()) for row in results]
    for i, result in enumerate(results):
        # pdb.set_trace()
        mode = "a"
        if i == 0:
            mode = "w"
        with open("/projects/CorisDB_Curation/Schemes/CORISDB_REGISTRY/gbq_corisdb/create_tables.sql", mode) as file:
            r = result['ddl'].replace('hdcdmcoris.', '')
            # Postgres types and formatting
            ## remove db server in GBQ
            r = r.replace('hdcdmcoris.', '')
            ## remove "`"
            r = r.replace('`', '')
            ## data types conversion
            r = r.replace('INT64,', 'INTEGER,')
            r = r.replace('INT64,\n', 'INTEGER,\n')
            r = r.replace('FLOAT64,', 'NUMERIC,')
            r = r.replace('FLOAT64\n', 'NUMERIC\n')
            r = r.replace('STRING,', 'VARCHAR,')
            r = r.replace('STRING\n', 'VARCHAR\n')
            r = r.replace('TIME,', 'TIME WITHOUT TIME ZONE,')
            r = r.replace('TIME\n', 'TIME WITHOUT TIME ZONE\n')
            r = r.replace('TIMESTAMP,', 'TIMESTAMP WITH TIME ZONE,')
            r = r.replace('TIMESTAMP\n', 'TIMESTAMP WITH TIME ZONE\n')
            r = r.replace('DATE,', 'TIMESTAMP WITHOUT TIME ZONE,')
            r = r.replace('DATE\n', 'TIMESTAMP WITHOUT TIME ZONE\n')
            file.write(f"DROP TABLE IF EXISTS coris_registry.{result['table_name']};\n")
            file.write(r)
            file.write("\n\n")
    

get_create_table_statements()



def create_insert_statements():
    # Run a query
    query = f"""
    SELECT
    table_name, ddl
    FROM `coris_registry`.INFORMATION_SCHEMA.TABLES
    """;
    query_job = client.query(query)
    # Fetch results
    results = query_job.result()
    # Convert results to list of dictionaries
    results = [dict(row.items()) for row in results]
    for i, result in enumerate(results):
        # pdb.set_trace()
        mode = "a"
        if i == 0:
            mode = "w"
        with open("/projects/coris_db/postgres/gbq_corisdb/import_tables.sql", mode) as file:
            table_name = result['table_name']
            insert_query = f"""\copy coris_registry.{table_name} FROM '/data/linking_various_systems/coris_db_gbq/{table_name}.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;"""
            # pdb.set_trace()
            file.write(f"{insert_query}\n")


create_insert_statements()


