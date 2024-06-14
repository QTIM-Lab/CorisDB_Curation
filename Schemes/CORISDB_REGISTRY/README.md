# Use gbq_table.py

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