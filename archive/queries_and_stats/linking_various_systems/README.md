# Use Calculate Joins

## Setup environment
```bash
ROOT=/projects/coris_db
pyenv deactivate
source ~/.bashrc; pyenv activate coris_db
cd $ROOT/postgres/queries_and_stats/linking_various_systems
# bpython # if you want a good exploratory shell
python # debug\interactive
python main.py 0 10 # running
python main.py 10 20 # running
python main.py 20 50 # running
python main.py 50 100 # running
python main.py 100 200 # 
python main.py 200 300 # 
python main.py 400 500 # 
python main.py 500 528 # 
```

## Import packages and env variables
```python
import os, pdb
import pandas as pd
import math
from itertools import combinations
import matplotlib.pyplot as plt
import seaborn as sns

from join_utils import Coris, Table, CompareTables

from dotenv import load_dotenv
load_dotenv()

DB_DATABASE = os.getenv('DB_DATABASE')
DB_USER = os.getenv('DB_USER')
DB_PASSWORD = os.getenv('DB_PASSWORD')
DB_HOST = os.getenv('DB_HOST')
DB_PORT = os.getenv('DB_PORT')
```

## Get Coris DB client
```python
coris = Coris()
ehr_tables = coris.get_tables(schema='ehr')
```

## Exhaustive list of table combos to search
```python
n = len(ehr_tables)
combos = list(combinations(list(ehr_tables['table_names']), 2))
# QA:These should be the same
## https://www.quora.com/How-do-you-find-the-number-of-possible-pairs-in-a-set-of-numbers#:~:text=from%20the%20set.-,To%20find%20the%20number%20of%20possible%20pairs%20in%20a%20set,*%20(n%2D2)!)
len(combos) == math.factorial(n) / (math.factorial(2) * math.factorial(n-2))
```

## Get sample join profile to test
```python
# ophthalmologypatients = Table(DB_DATABASE,DB_USER,DB_PASSWORD,DB_HOST,DB_PORT, TABLE_NAME='ophthalmologypatients', LIMIT=15)
# ophthalmologyencountervisit = Table(DB_DATABASE,DB_USER,DB_PASSWORD,DB_HOST,DB_PORT, TABLE_NAME='ophthalmologyencountervisit', LIMIT=15)

# join_counts = CompareTables(ophthalmologyencountervisit, ophthalmologypatients)
# join_counts.to_csv(os.path.join("/data/linking_various_systems", "encountervisitTable_patientsTable.csv"), index=None)
join_counts = pd.read_csv(os.path.join("/data/linking_various_systems", "encountervisitTable_patientsTable.csv"))
```

## Plot this:
```python
join_counts.head()

join_counts_pivot = join_counts.pivot(index='table1_column_name', columns='table2_column_name', values='count')

# Create the heatmap
plt.figure(figsize=(8, 6))
sns.heatmap(join_counts_pivot, annot=False, cmap='rocket', fmt='g')
plt.title(f'Heatmap of Join Counts | encountervisitTable vs patientsTable')
plt.xlabel('table1_column_name')
plt.ylabel('table2_column_name')
plt.show()
plt.savefig(os.path.join("/data/linking_various_systems", "encountervisitTable_patientsTable.png"))
```

## Retrieve join counts 
```python

def ProcessCompareTables(combos):
    for combo in combos:
        tables = {
            f"{combo[0]}": Table(DB_DATABASE,DB_USER,DB_PASSWORD,DB_HOST,DB_PORT, TABLE_NAME=combo[0], LIMIT=15),
            f"{combo[1]}": Table(DB_DATABASE,DB_USER,DB_PASSWORD,DB_HOST,DB_PORT, TABLE_NAME=combo[1], LIMIT=15)
        }
        join_counts = CompareTables(tables[f"{combo[0]}"], tables[f"{combo[1]}"])
        # pdb.set_trace()
        join_counts.to_csv(os.path.join("/data/linking_various_systems", f"{combo[0]}_{combo[0]}.csv"), index=None)


ProcessCompareTables(combos[0:1])

```

## Notes table to all else
```python

combos = [('c3304_t11_notes', 'ophthalmologydiagnosesdm'),
('c3304_t11_notes', 'ophthalmologyproviderall'),
('c3304_t11_notes', 'ophthalmologyradiology'),
('c3304_t11_notes', 'ophthalmologyencountervisit'),
('c3304_t11_notes', 'ophthalmologyfamilyhistory'),
('c3304_t11_notes', 'ophthalmologypatientdiagnoses'),
('c3304_t11_notes', 'ophthalmologysurgeryall'),
('c3304_t11_notes', 'ophthalmologyimplant'),
('c3304_t11_notes', 'ophthalmologycurrentmedications'),
('c3304_t11_notes', 'ophthalmologysupplydm'),
('c3304_t11_notes', 'ophthalmologyimplantdm'),
('c3304_t11_notes', 'ophthalmologysurgeryprocedure'),
('c3304_t11_notes', 'ophthalmologyorders'),
('c3304_t11_notes', 'ophthalmologyencountercharge'),
('c3304_t11_notes', 'ophthalmologysurgerymedication'),
('c3304_t11_notes', 'ophthalmologysurgerysurgeon'),
('c3304_t11_notes', 'ophthalmologyencounterexam'),
('c3304_t11_notes', 'ophthalmologymedications'),
('c3304_t11_notes', 'ophthalmologysurgerybill'),
('c3304_t11_notes', 'ophthalmologysupply'),
('c3304_t11_notes', 'ophthalmologyencounters'),
('c3304_t11_notes', 'ophthalmologyvisitsummary'),
('c3304_t11_notes', 'ophthalmologymedicationdm'),
('c3304_t11_notes', 'ophthalmologyproviderdm'),
('c3304_t11_notes', 'ophthalmologyencounterproblemlist'),
('c3304_t11_notes', 'ophthalmologysurgery'),
('c3304_t11_notes', 'ophthalmologylaborder'),
('c3304_t11_notes', 'ophthalmologypatients'),
('c3304_t11_notes', 'ophthalmologyencounterdiagnoses'),
('c3304_t11_notes', 'ophthalmologysurgerydm'),
('c3304_t11_notes', 'ophthalmologylabs'),
('c3304_t11_notes', 'c3304_2_coris_to_source')]

ProcessCompareTables(combos[1:])

```