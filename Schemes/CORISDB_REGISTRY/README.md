# Use gbq_table.py

Use the notes in CloudAIResources channel in Teams to get connected to GCP (If you don't have access to that OneNote notebook, let Ben or Steve know.)
```bash
gcloud auth application-default login 
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
PS: Without the above the below won't work.

This is meant to be a class you can instantiate that models a gbq table. It will have methods meant for you to use and others that are private methods (intended to be used by class only).

```bash
pyenv activate corisdb_curation
cd Schemes/CORISDB_REGISTRY/

TMP_WORKING_AREA="/data/linking_various_systems/coris_db_gbq"
mkdir -p $TMP_WORKING_AREA
python # Start interpreter
```

```python
import importlib    # Import the importlib module
import gbq_table

importlib.reload(gbq_table)
from gbq_table import Table

my_table = Table(table_name="C3304_GBQ_T19_MYC_Messages", \
                 gbq_table_name="C3304_GBQ_T19_MYC_Messages_20240531", \
                 tmp_working_area="/data/linking_various_systems/coris_db_gbq")

my_table.make_postgres_importable_file() # Will be in tmp_working_dir

# View attributes
my_table.table_name
my_table.gbq_table_name
my_table.tmp_working_area
my_table.where_statements
my_table.rows

my_table.set_row_count()
my_table.rows

# my_table.get_table(pieces=20) # Will be in tmp_working_dir
my_table.get_table(limit=100) # Will be in tmp_working_dir

# my_table.get_create_table_statements()
my_table.get_create_table_statement(postgres_types=True) # Will be in postgres_queries

my_table.get_create_insert_statement() # Will be in postgres_queries



```