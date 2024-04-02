import os, shutil, pdb, pandas as pd

SOURCE_directory="/data/SOURCE"
tmp_for_import="/data/SOURCE/tmp_for_import"
table_def_orig_csvs="table_def_orig_csvs"

type_key={
    "INTEGER":"Int64",
    "BIGINT": "Int64",
    "STRING":"object",
    "LONG_STRING":"object",
    "TEXT":"object",
    "TIME":"datetime64",
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
        # Ongoing
        # "C3304_T11_Notes_20240207.csv",
        "C3304_2_CORIS_to_SOURCE_20240228.csv"
        # Done commented
        # "OphthalmologyCurrentMedications_20230217.csv",
        # "OphthalmologyDiagnosesDm_20230222.csv",
        # "OphthalmologyEncounterCharge_20230217.csv",
        # "OphthalmologyEncounterDiagnoses_20230217.csv",
        # "OphthalmologyEncounterExam_20230217.csv",
        # "OphthalmologyEncounterProblemList_20230217.csv",
        # "OphthalmologyEncounters_20230217.csv",
        # "OphthalmologyEncounterVisit_20230217.csv",
        # "OphthalmologyFamilyHistory_20230217.csv",
        # "OphthalmologyImplant_20230217.csv",
        # "OphthalmologyImplantDm_20230222.csv",
        # "OphthalmologyLabOrder_20230217.csv",
        # "OphthalmologyLabs_20230217.csv",
        # "OphthalmologyMedicationDm_20230222.csv",
        # "OphthalmologyMedications_20230217.csv",
        # "OphthalmologyOrders_20230217.csv",
        # "OphthalmologyPatientDiagnoses_20230217.csv",
        # "OphthalmologyPatients_20230217.csv",
        # "OphthalmologyProviderAll_20230217.csv",
        # "OphthalmologyProviderDm_20230222.csv",
        # "OphthalmologyRadiology_20230217.csv",
        # "OphthalmologySupply_20230217.csv",
        # "OphthalmologySupplyDm_20230222.csv",
        # "OphthalmologySurgery_20230217.csv",
        # "OphthalmologySurgeryAll_20230217.csv",
        # "OphthalmologySurgeryBill_20230217.csv",
        # "OphthalmologySurgeryDm_20230222.csv",
        # "OphthalmologySurgeryMedication_20230217.csv",
        # "OphthalmologySurgeryProcedure_20230217.csv",
        # "OphthalmologySurgerySurgeon_20230217.csv",
        # "OphthalmologyVisitSummary_20230217.csv",      
        ]
for csv in csvs:
    print(csv)
    types = pd.read_csv(os.path.join(table_def_orig_csvs, csv))
    pdb.set_trace()
    types['Type_pandas'] = types['Type'].apply(lambda x: type_key[x])
    new_types = dict(zip(types['Field name'], types['Type_pandas']))
    tmp = pd.read_csv(os.path.join(SOURCE_directory, csv), dtype=object)
    tmp = tmp.fillna("NULL")
    # tmp.astype(new_types)
    # tmp['TOTAL_ENC'].astype('Int64')
    tmp.to_csv(os.path.join(tmp_for_import, csv), index=None, quotechar="'", lineterminator="\n")


# Delete directory if exists
# if os.path.isdir(tmp_for_import):
#     shutil.rmtree(tmp_for_import)