import importlib
import gbq_table
from gbq_table import Table
import time

# Function to measure and print runtime
def measure_runtime(func):
    def wrapper(*args, **kwargs):
        start_time = time.time()
        result = func(*args, **kwargs)
        end_time = time.time()
        print(f"Runtime for {func.__name__} ({args[0]}): {end_time - start_time} seconds")
        return result
    return wrapper

# Function to process tables
@measure_runtime
def process_table(table_name, gbq_table_name, tmp_working_area):
    table = Table(
        table_name=table_name,
        gbq_table_name=gbq_table_name,
        tmp_working_area=tmp_working_area
    )
    table.get_table()
    table.make_postgres_importable_file()
    table.get_create_table_statement(postgres_types=False)
    table.get_create_insert_statement()
    table.get_scheme()
    print(f"{table_name} is done successfully")

# Define table details
tables = [
    ("C3304_GBQ_T1_Person", "C3304_GBQ_T1_Person_20250429"),
    ("C3304_GBQ_T2_Encounter", "C3304_GBQ_T2_Encounter_20250429"),
    ("C3304_GBQ_T3_Diagnosis", "C3304_GBQ_T3_Diagnosis_20250429"),
    ("C3304_GBQ_T4_Proc_OrderedEMR", "C3304_GBQ_T4_Proc_OrderedEMR_20250429"),
    ("C3304_GBQ_T5_Procedures", "C3304_GBQ_T5_Procedures_20250429"),
    ("C3304_GBQ_T6_Surgeries", "C3304_GBQ_T6_Surgeries_20250429"),
    ("C3304_GBQ_T7_Medication", "C3304_GBQ_T7_Medication_20250429"),
    #("C3304_GBQ_T8_Labs", "C3304_GBQ_T8_Labs_20250429"),
    ("C3304_GBQ_T9_ADT", "C3304_GBQ_T9_ADT_20250429"),
    ("C3304_GBQ_T10_Flowsheets", "C3304_GBQ_T10_Flowsheets_20250429"),
    ("C3304_GBQ_T11_Notes", "C3304_GBQ_T11_Notes_20250429"),
    ("C3304_GBQ_T12_FamilyHistory", "C3304_GBQ_T12_FamilyHistory_20250429"),
    ("C3304_GBQ_T13_SocialHistory", "C3304_GBQ_T13_SocialHistory_20250429"),
    ("C3304_GBQ_T14_Allergy", "C3304_GBQ_T14_Allergy_20250429"),
    ("C3304_GBQ_T15_Referral", "C3304_GBQ_T15_Referral_20250429"),
    ("C3304_GBQ_T16_CensusData2018", "C3304_GBQ_T16_CensusData2018_20250429"),
    ("C3304_GBQ_T17_CensusData2014", "C3304_GBQ_T17_CensusData2014_20250429"),
    ("C3304_GBQ_T18_OphthalmologyExams", "C3304_GBQ_T18_OphthalmologyExams_20250429"),
    ("C3304_GBQ_T19_MYC_Messages", "C3304_GBQ_T19_MYC_Messages_20250429"),
    ("C3304_GBQ_T20_BillingCode", "C3304_GBQ_T20_BillingCode_20250429"),
    ("C3304_GBQ_T21_CPT_Description", "C3304_GBQ_T21_CPT_Description_20250429")
]

tmp_working_area = "/scratch90/QTIM/Active/23-0284/EHR/CORIS_REGISTRY_GBQ/live"

# Process each table
for table_name, gbq_table_name in tables:
    process_table(table_name, gbq_table_name, tmp_working_area)


