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
cd CorisDB_Curation/Schemes/CORISDB_REGISTRY/

#TMP_WORKING_AREA="/scratch90/QTIM/Active/23-0284/EHR/CORIS_REGISTRY_GBQ/live"
#mkdir -p $TMP_WORKING_AREA
python # Start interpreter
```


Example using interactive python
```python
import importlib # Import the importlib module
import gbq_table
from gbq_table import Table
# importlib.reload(gbq_table)


tmp_working_area="/scratch90/QTIM/Active/23-0284/EHR/CORIS_REGISTRY_GBQ/live"
# create a table object from a gbq table and work with it below
table = Table(table_name="C3304_T1_Person", gbq_table_name="C3304_T1_Person_20250923", tmp_working_area=tmp_working_area)
table = Table(table_name="C3304_T2_Encounter", gbq_table_name="C3304_T2_Encounter_20250923", tmp_working_area=tmp_working_area)
table = Table(table_name="C3304_T3_Diagnosis", gbq_table_name="C3304_T3_Diagnosis_20250923", tmp_working_area=tmp_working_area)
table = Table(table_name="C3304_T11_Notes", gbq_table_name="C3304_T11_Notes_20250923", tmp_working_area=tmp_working_area)
table = Table(table_name="C3304_T18_OphthamologyExams", gbq_table_name="C3304_T18_OphthamologyExams_20250923", tmp_working_area=tmp_working_area)
table = Table(table_name="C3304_T22_CU_MedBillingCode", gbq_table_name="C3304_T22_CUMedBillingCode_20250923", tmp_working_area=tmp_working_area)
table = Table(table_name="C3304_T20_BillingCode", gbq_table_name="C3304_T20_BillingCode_20250925", tmp_working_area=tmp_working_area)

# work with table here
table.get_table() # Will be in tmp_working_dir
# table.get_table(limit=10000) # Will be in tmp_working_dir
table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
#table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
table.get_create_insert_statement() # Will be in postgres_queries

table.get_scheme()
```
