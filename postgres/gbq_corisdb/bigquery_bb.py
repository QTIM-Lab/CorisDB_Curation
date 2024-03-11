```bash
source ~/.bashrc; pyenv activate coris_db; python

````

import json
import pandas as pd
from google.cloud import bigquery

# Initialize a BigQuery client
client = bigquery.Client()

tables = [
"C3304_GBQ_T15_Referral_20240207",
"C3304_GBQ_T4_Proc_OrderedEMR_20240207",
"C3304_T1_Person_20231222",
"C3304_GBQ_T6_Surgeries_20240207",
"C3304_T11_Notes_20231222",
"C3304_GBQ_T16_CensusData2018_20240207",
"C3304_GBQ_T11_Notes_20240207",
"C3304_GBQ_T5_Procedures_20240207",
"C3304_GBQ_T8_Labs_20240207",
"C3304_GBQ_T2_Encounter_20240207",
"C3304_GBQ_T1_Person_20240207",
"C3304_GBQ_T14_Allergy_20240207",
"C3304_GBQ_T18_OphthamologyExams_20240207",
"C3304_GBQ_T9_ADT_20240207",
"C3304_GBQ_T13_SocialHistory_20240207",
"C3304_GBQ_T3_Diagnosis_20240207",
"C3304_T3_Diagnosis_20231222",
"C3304_GBQ_T17_CensusData2014_20240207",
"C3304_GBQ_T10_Flowsheets_20240207",
"C3304_T18_OphthamologyExams_20231222",
"C3304_GBQ_T12_FamilyHistory_20240207",
"C3304_T2_Encounter_20231222",
]

len(tables)

def get_table(table):
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



get_table("C3304_GBQ_T15_Referral_20240207") # running
get_table("C3304_GBQ_T4_Proc_OrderedEMR_20240207") # running
get_table("C3304_T1_Person_20231222") # done
get_table("C3304_GBQ_T6_Surgeries_20240207") # done
get_table("C3304_T11_Notes_20231222") # running
get_table("C3304_GBQ_T16_CensusData2018_20240207") # done
get_table("C3304_GBQ_T11_Notes_20240207") # running
get_table("C3304_GBQ_T5_Procedures_20240207") # running
get_table("C3304_GBQ_T8_Labs_20240207") # running
get_table("C3304_GBQ_T2_Encounter_20240207") # running
get_table("C3304_GBQ_T1_Person_20240207") # running
get_table("C3304_GBQ_T14_Allergy_20240207") # running
get_table("C3304_GBQ_T18_OphthamologyExams_20240207") # running
get_table("C3304_GBQ_T9_ADT_20240207") # running
get_table("C3304_GBQ_T13_SocialHistory_20240207") # running
get_table("C3304_GBQ_T3_Diagnosis_20240207") # running
get_table("C3304_T3_Diagnosis_20231222") # running
get_table("C3304_GBQ_T17_CensusData2014_20240207") # running
get_table("C3304_GBQ_T10_Flowsheets_20240207") # running
get_table("C3304_T18_OphthamologyExams_20231222") # running
get_table("C3304_GBQ_T12_FamilyHistory_20240207") # running
get_table("C3304_T2_Encounter_20231222") # running