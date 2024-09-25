# Use gbq_table.py

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
pyenv activate coris_db
pyenv activate corisdb_curation
cd Schemes/CORISDB_REGISTRY/

#TMP_WORKING_AREA="/data/CorisDB_Curation"
#mkdir -p $TMP_WORKING_AREA
python # Start interpreter
```

Example using interactive python
```python
import importlib    # Import the importlib module
import gbq_table
from gbq_table import Table
# importlib.reload(gbq_table)

# Billing Code Table
billing_code_table = Table(table_name="C3304_GBQ_T20_BillingCode", \
                 gbq_table_name="C3304_GBQ_T20_BillingCode_20240830", \
                 tmp_working_area="/data/CorisDB_Curation")

billing_code_table.get_table() # Will be in tmp_working_dir
#billing_code_table.get_table(limit=100) # Will be in tmp_working_dir
billing_code_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
billing_code_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
billing_code_table.get_create_insert_statement() # Will be in postgres_queries


# Surgery Table
surgery_table = Table(table_name="C3304_GBQ_T6_Surgeries", \
                 gbq_table_name="C3304_GBQ_T6_Surgeries_20240712", \
                 tmp_working_area="/data/CorisDB_Curation")
surgery_table.get_table() # Will be in tmp_working_dir
#surgery_table.get_table(limit=100) # Will be in tmp_working_dir
surgery_table.make_postgres_importable_file() # Will be in tmp_working_dir
#may not need to re-create these two
# surgery_table.get_create_table_statement(postgres_types=False) # Will be in postgres_queries
surgery_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries
surgery_table.get_create_insert_statement() # Will be in postgres_queries

surgery_table.get_scheme()
```
