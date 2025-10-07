import os, pandas as pd
from dotenv import load_dotenv

os.chdir("/home/mcnamast/coris_db/postgres/queries_and_stats/queries/AMD/Process_Raw_Data")
load_dotenv()

csv_path = os.getenv('csv_paths', '')

amd_csv = pd.read_csv(os.path.join(csv_path,'AMDDatabaseLogitudin_DATA_2023_08_17 for JK.csv'), encoding='ISO-8859-1')
amd_csv.head()
list(amd_csv.columns)

header = ['mrn','can_use','ferris','sex']


# amd_csv_processed = amd_csv[(amd_csv['can_use'] == 1) & (~pd.isna(amd_csv['mrn']))]
amd_csv_processed = amd_csv[(~pd.isna(amd_csv['can_use'])) & (~pd.isna(amd_csv['mrn']))]
amd_csv_processed['mrn'] = amd_csv_processed['mrn'].astype(int)
amd_csv_processed['can_use'] = amd_csv_processed['can_use'].astype(int)
amd_csv_processed['ferris'] = amd_csv_processed['ferris'].astype(str)
amd_csv_processed['sex'] = amd_csv_processed['sex'].astype(int)
amd_csv_processed[header].to_csv(os.path.join(csv_path,'AMDDatabaseLogitudin_DATA_OUTPUT.csv'), index=None)
print(csv_path)