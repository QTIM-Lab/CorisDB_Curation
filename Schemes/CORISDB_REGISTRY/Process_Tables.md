# Use gbq_table.py

```bash
pyenv versions
# pyenv install 3.11.1
# pyenv virtualenv 3.11.1 corisdb_curation
pyenv activate corisdb_curation
# poetry config virtualenvs.create false
# poetry config virtualenvs.in-project false
# poetry init # first time only
poetry install
```

Use the notes in CloudAIResources channel in Teams to get connected to GCP (If you don't have access to that OneNote notebook, let Ben or Steve know.)


```bash
gcloud auth application-default login  # should work
```
Ex:
```bash
bearceb@soms-slce-oph1:/projects/CorisDB_Curation$ gcloud auth application-default login
Go to the following link in your browser, and complete the sign-in prompts:

    https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=764086051850-6qr4p6gpi6hn506pt8ejuq83di341hur.apps.googleusercontent.com&redirect_uri=https%3A%2F%2Fsdk.cloud.google.com%2Fapplicationdefaultauthcode.html&scope=openid+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcloud-platform+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fsqlservice.login&state=BFzxEeyzzWJDdSPx957k5fjANCvnjx&prompt=consent&token_usage=remote&access_type=offline&code_challenge=zt_xmo16Ytf6fMtHPCQUnCRIEEQlIgvQq3cm5y5ZgKc&code_challenge_method=S256

Once finished, enter the verification code provided in your browser: *************************************************************************

Credentials saved to file: [/home/bearceb/.config/gcloud/application_default_credentials.json]

These credentials will be used by any library that requests Application Default Credentials (ADC).
WARNING: 
Cannot add the project "hdcdmcoris" to ADC as the quota project because the account in ADC does not have the "serviceusage.services.use" permission on this project. You might receive a "quota_exceeded" or "API not enabled" error. Run $ gcloud auth application-default set-quota-project to add a quota project.


To take a quick anonymous survey, run:
  $ gcloud survey

```

```bash
gcloud auth login benjamin.bearce@hdcuser.org # worked 09/25/2024
```
Ex:
```bash
Your browser has been opened to visit:

    https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=32555940559.apps.googleusercontent.com&redirect_uri=http%3A%2F%2Flocalhost%3A8085%2F&scope=openid+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcloud-platform+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fappengine.admin+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fsqlservice.login+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcompute+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Faccounts.reauth&state=1Xci6p69EoEfqILmKmQsabUpgXNi6T&access_type=offline&code_challenge=kr-NSLysBqF06n99-OKgcMPFCXhGwcSHv4fs5Jt7qjw&code_challenge_method=S256


You are now logged in as [benjamin.bearce@hdcuser.org].
Your current project is [hdcdmcoris].  You can change this setting by running:
  $ gcloud config set project PROJECT_ID
```


Configure your project:
```bash
gcloud config list # see project and account settings
gcloud config set project hdcdmcoris
```


This is meant to be a class you can instantiate that models a gbq table. It will have methods meant for you to use and others that are private methods (intended to be used by class only).

```bash
. ~/.bashrc
pyenv deactivate
pyenv activate corisdb_curation
cd Schemes/CORISDB_REGISTRY/

#TMP_WORKING_AREA="/data/CorisDB_Curation"
#mkdir -p $TMP_WORKING_AREA
python # Start interpreter
```

Example using interactive python
```python
import importlib # Import the importlib module
import gbq_table
from gbq_table import Table
# importlib.reload(gbq_table)


#######################Table-Blocks##########################


#T21  -- 323 copied 10/31/2024
CPTDescription = Table(table_name="C3304_GBQ_T21_CPT_Description", \
                 gbq_table_name="C3304_GBQ_T21_CPT_Description_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
CPTDescription.get_table() # Will be in tmp_working_dir
#CPTDescription.get_table(limit=10000) # Will be in tmp_working_dir
CPTDescription.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#CPTDescription.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
CPTDescription.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
CPTDescription.get_create_insert_statement() # Will be in postgres_queries

CPTDescription.get_scheme()



#T20  -- 72715 copied 10/31/2024
BillingCode_table = Table(table_name="C3304_GBQ_T20_BillingCode", \
                 gbq_table_name="C3304_GBQ_T20_BillingCode_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
BillingCode_table.get_table() # Will be in tmp_working_dir
#BillingCode_table.get_table(limit=10000) # Will be in tmp_working_dir
BillingCode_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#BillingCode_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
BillingCode_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
BillingCode_table.get_create_insert_statement() # Will be in postgres_queries

BillingCode_table.get_scheme()




#T19  -- 2052646 copied 10/31/2024
MYCMessages_table = Table(table_name="C3304_GBQ_T19_MYC_Messages", \
                 gbq_table_name="C3304_GBQ_T19_MYC_Messages_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
#MYCMessages_table.get_table() # Will be in tmp_working_dir
MYCMessages_table.get_table(limit=10000) # Will be in tmp_working_dir
MYCMessages_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#MYCMessages_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
MYCMessages_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
MYCMessages_table.get_create_insert_statement() # Will be in postgres_queries

MYCMessages_table.get_scheme()


#T18  -- 67574693 copied 11/01/2024
OphthamologyExams_table = Table(table_name="C3304_GBQ_T18_OphthamologyExams", \
                 gbq_table_name="C3304_GBQ_T18_OphthamologyExams_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
OphthamologyExams_table.get_table() # Will be in tmp_working_dir
#OphthamologyExams_table.get_table(limit=10000) # Will be in tmp_working_dir
OphthamologyExams_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#OphthamologyExams_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
OphthamologyExams_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
OphthamologyExams_table.get_create_insert_statement() # Will be in postgres_queries

OphthamologyExams_table.get_scheme()


#T17  -- 39942 copied 10/31/2024
CensusData2014_table = Table(table_name="C3304_GBQ_T17_CensusData2014", \
                 gbq_table_name="C3304_GBQ_T17_CensusData2014_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
CensusData2014_table.get_table() # Will be in tmp_working_dir
#CensusData2014_table.get_table(limit=100) # Will be in tmp_working_dir
CensusData2014_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#CensusData2014_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
CensusData2014_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
CensusData2014_table.get_create_insert_statement() # Will be in postgres_queries

CensusData2014_table.get_scheme()


#T16  -- 61109  copied 10/30/2024
CensusData2018_table = Table(table_name="C3304_GBQ_T16_CensusData2018", \
                 gbq_table_name="C3304_GBQ_T16_CensusData2018_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
CensusData2018_table.get_table() # Will be in tmp_working_dir
#CensusData2018_table.get_table(limit=100) # Will be in tmp_working_dir
CensusData2018_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#CensusData2018_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
CensusData2018_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
CensusData2018_table.get_create_insert_statement() # Will be in postgres_queries

CensusData2018_table.get_scheme()



#T15  -- 580362  copied 10/30/2024
Referral_table = Table(table_name="C3304_GBQ_T15_Referral", \
                 gbq_table_name="C3304_GBQ_T15_Referral_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
Referral_table.get_table() # Will be in tmp_working_dir
#Referral_table.get_table(limit=100) # Will be in tmp_working_dir
Referral_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#Referral_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
Referral_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
Referral_table.get_create_insert_statement() # Will be in postgres_queries

Referral_table.get_scheme()



#T14  -- 305957  copied 10/30/2024
Allergy_table = Table(table_name="C3304_GBQ_T14_Allergy", \
                 gbq_table_name="C3304_GBQ_T14_Allergy_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
Allergy_table.get_table() # Will be in tmp_working_dir
#Allergy_table.get_table(limit=100) # Will be in tmp_working_dir
Allergy_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#Allergy_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
Allergy_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
Allergy_table.get_create_insert_statement() # Will be in postgres_queries

Allergy_table.get_scheme()


#T13  -- 4854925  copied 10/30/2024
SocialHistory_table = Table(table_name="C3304_GBQ_T13_SocialHistory", \
                 gbq_table_name="C3304_GBQ_T13_SocialHistory_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
SocialHistory_table.get_table() # Will be in tmp_working_dir
#SocialHistory_table.get_table(limit=100) # Will be in tmp_working_dir
SocialHistory_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#SocialHistory_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
SocialHistory_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
SocialHistory_table.get_create_insert_statement() # Will be in postgres_queries

SocialHistory_table.get_scheme()



#T12  -- 1736947 copied 10/30/2024
FamilyHistory_table = Table(table_name="C3304_GBQ_T12_FamilyHistory", \
                 gbq_table_name="C3304_GBQ_T12_FamilyHistory_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
FamilyHistory_table.get_table() # Will be in tmp_working_dir
#FamilyHistory_table.get_table(limit=100) # Will be in tmp_working_dir
FamilyHistory_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#FamilyHistory_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
FamilyHistory_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
FamilyHistory_table.get_create_insert_statement() # Will be in postgres_queries

FamilyHistory_table.get_scheme()



#T11
Notes_table = Table(table_name="C3304_GBQ_T11_Notes", \
                 gbq_table_name="C3304_GBQ_T11_Notes_20250117", \
                 tmp_working_area="/data/CorisDB_Curation")
Notes_table.get_table() # Will be in tmp_working_dir
#Notes_table.get_table(limit=100) # Will be in tmp_working_dir
Notes_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
Notes_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
#Notes_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
Notes_table.get_create_insert_statement() # Will be in postgres_queries

Notes_table.get_scheme()



#T10  --5125225 copied   10/29/2024
flowsheets_table = Table(table_name="C3304_GBQ_T10_Flowsheets", \
                 gbq_table_name="C3304_GBQ_T10_Flowsheets_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
flowsheets_table.get_table() # Will be in tmp_working_dir
#flowsheets_table.get_table(limit=100) # Will be in tmp_working_dir
flowsheets_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#flowsheets_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
flowsheets_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
flowsheets_table.get_create_insert_statement() # Will be in postgres_queries

flowsheets_table.get_scheme()


#T9  -- 1596094 Copied on 10/29/2024
adt_table = Table(table_name="C3304_GBQ_T9_ADT", \
                 gbq_table_name="C3304_GBQ_T9_ADT_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
adt_table.get_table() # Will be in tmp_working_dir
#adt_table.get_table(limit=100) # Will be in tmp_working_dir
adt_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#adt_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
adt_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
adt_table.get_create_insert_statement() # Will be in postgres_queries

adt_table.get_scheme()




#T8   66949163 - copied 11/01/2024

labs_table = Table(table_name="C3304_GBQ_T8_Labs", \
                 gbq_table_name="C3304_GBQ_T8_Labs_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
labs_table.get_table() # Will be in tmp_working_dir
#labs_table.get_table(limit=10000) # Will be in tmp_working_dir
labs_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#labs_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
labs_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
labs_table.get_create_insert_statement() # Will be in postgres_queries

labs_table.get_scheme()



#T7    1407605 copied - 10/18/2024
medication_table = Table(table_name="C3304_GBQ_T7_Medication", \
                 gbq_table_name="C3304_GBQ_T7_Medication_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
medication_table.get_table() # Will be in tmp_working_dir
#medication_table.get_table(limit=100) # Will be in tmp_working_dir
medication_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#medication_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
medication_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
medication_table.get_create_insert_statement() # Will be in postgres_queries

medication_table.get_scheme()



#T6  467521 copied time - varchar
surgery_table = Table(table_name="C3304_GBQ_T6_Surgeries", \
                 gbq_table_name="C3304_GBQ_T6_Surgeries_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
surgery_table.get_table() # Will be in tmp_working_dir
#surgery_table.get_table(limit=100) # Will be in tmp_working_dir
surgery_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#surgery_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
surgery_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
surgery_table.get_create_insert_statement() # Will be in postgres_queries

surgery_table.get_scheme()




#T5  -- 4515183 copied
T5_table = Table(table_name="C3304_GBQ_T5_Procedures", \
                 gbq_table_name="C3304_GBQ_T5_Procedures_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
T5_table.get_table() # Will be in tmp_working_dir
#T5_table.get_table(limit=100) # Will be in tmp_working_dir
T5_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#T5_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
T5_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
T5_table.get_create_insert_statement() # Will be in postgres_queries

T5_table.get_scheme()

#T4   -- 27923459 copied 10/18/20024
OrderedEMR_table = Table(table_name="C3304_GBQ_T4_Proc_OrderedEMR", \
                 gbq_table_name="C3304_GBQ_T4_Proc_OrderedEMR_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
OrderedEMR_table.get_table() # Will be in tmp_working_dir
# OrderedEMR_table.get_table(limit=100) # Will be in tmp_working_dir
OrderedEMR_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
#OrderedEMR_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
OrderedEMR_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
OrderedEMR_table.get_create_insert_statement() # Will be in postgres_queries

OrderedEMR_table.get_scheme()


#T3  -- 60993251 copied 10/16/2024
Diagnosis_table = Table(table_name="C3304_GBQ_T3_Diagnosis", \
                 gbq_table_name="C3304_GBQ_T3_Diagnosis_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
Diagnosis_table.get_table() # Will be in tmp_working_dir
#Diagnosis_table.get_table(limit=100) # Will be in tmp_working_dir
Diagnosis_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
Diagnosis_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
# Diagnosis_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
Diagnosis_table.get_create_insert_statement() # Will be in postgres_queries

Diagnosis_table.get_scheme()



#T2   -- 2387392 copied 10/16/2024
Encounter_table = Table(table_name="C3304_GBQ_T2_Encounter", \
                 gbq_table_name="C3304_GBQ_T2_Encounter_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
Encounter_table.get_table() # Will be in tmp_working_dir
# Encounter_table.get_table(limit=100) # Will be in tmp_working_dir
Encounter_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
# Encounter_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
Encounter_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
Encounter_table.get_create_insert_statement() # Will be in postgres_queries

Encounter_table.get_scheme()


# 09/25/2024 version - naming all tables the same 0925 to avoid confusion.
#T1
person_table = Table(table_name="C3304_GBQ_T1_Person", \
                 gbq_table_name="C3304_GBQ_T1_Person_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
person_table.get_table() # Will be in tmp_working_dir
#person_table.get_table(limit=100) # Will be in tmp_working_dir
person_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
person_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
# person_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
person_table.get_create_insert_statement() # Will be in postgres_queries

person_table.get_scheme()





#T20
BillingCode_table = Table(table_name="C3304_GBQ_T20_BillingCode", \
                 gbq_table_name="C3304_GBQ_T20_BillingCode_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
BillingCode_table.get_table() # Will be in tmp_working_dir
#BillingCode_table.get_table(limit=100) # Will be in tmp_working_dir
BillingCode_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
BillingCode_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
#BillingCode_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
BillingCode_table.get_create_insert_statement() # Will be in postgres_queries

BillingCode_table.get_scheme()


#T21
cpt_description_table = Table(table_name="C3304_GBQ_T21_CPT_Description", \
                 gbq_table_name="C3304_GBQ_T21_CPT_Description_20240925", \
                 tmp_working_area="/data/CorisDB_Curation")
cpt_description_table.get_table() # Will be in tmp_working_dir
#cpt_description_table.get_table(limit=100) # Will be in tmp_working_dir
cpt_description_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
cpt_description_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
# cpt_description_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
cpt_description_table.get_create_insert_statement() # Will be in postgres_queries

cpt_description_table.get_scheme()
```
