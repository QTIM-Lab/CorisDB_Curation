# Script to import AMD Epidemiology CSVs

import os, shutil, pdb, pandas as pd

SOURCE_directory="/home/mcnamast/SOURCE/"
tmp_for_import="/projects/coris_db/tmp_for_import"
table_def_orig_csvs="/projects/coris_db/table_def_orig_csvs"

type_key={
    "INTEGER":"Int64",
    "STRING":"object",
    "LONG_STRING":"object",
    "DATETIME":"datetime64",
    "TIMESTAMP":"datetime64",
    "DATE":"datetime64",
    "FLOAT":"float64",
}


# Make directory if doesn't exists
if not os.path.isdir(tmp_for_import):
    os.mkdir(tmp_for_import)

# Read in files and write again via pandas to tmp directory
# for csv in [i for i in os.listdir(SOURCE_directory) if i.find(".csv") != -1]:

# Above for loop explicit
csvs = [
        'AMDDatabaseLogitudin_DATA_Imaging_AF.csv',
        'AMDDatabaseLogitudin_DATA_Imaging_CFP.csv',
        'AMDDatabaseLogitudin_DATA_Imaging.csv',
        'AMDDatabaseLogitudin_DATA_Imaging_OCT_AF_CFP.csv',
        'AMDDatabaseLogitudin_DATA_Imaging_OCT.csv',
        'AMDDatabaseLogitudin_DATA_Relevant_Info_All.csv',
        ]
for csv in csvs:
    print(csv)
    pdb.set_trace()
    types = pd.read_csv(os.path.join(table_def_orig_csvs, csv))
    types['Type_pandas'] = types['Type'].apply(lambda x: type_key[x])
    new_types = dict(zip(types['Field name'], types['Type_pandas']))
    tmp = pd.read_csv(os.path.join(SOURCE_directory, csv), dtype=object, encoding='ISO-8859-1')
    tmp = tmp.fillna("NULL")
    # tmp.astype(new_types)
    # tmp['TOTAL_ENC'].astype('Int64')
    tmp.to_csv(os.path.join(tmp_for_import, csv), index=None, quotechar="'", lineterminator="\n")


# Delete directory if exists
# if os.path.isdir(tmp_for_import):
#     shutil.rmtree(tmp_for_import)