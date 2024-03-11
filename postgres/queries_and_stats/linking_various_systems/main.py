import os, sys, pdb
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

def ProcessCompareTables(combos):
    for combo in combos:
        tables = {
            f"{combo[0]}": Table(DB_DATABASE,DB_USER,DB_PASSWORD,DB_HOST,DB_PORT, TABLE_NAME=combo[0], LIMIT=15),
            f"{combo[1]}": Table(DB_DATABASE,DB_USER,DB_PASSWORD,DB_HOST,DB_PORT, TABLE_NAME=combo[1], LIMIT=15)
        }
        join_counts = CompareTables(tables[f"{combo[0]}"], tables[f"{combo[1]}"])
        # pdb.set_trace()
        join_counts.to_csv(os.path.join("/data/linking_various_systems", f"{combo[0]}_{combo[1]}.csv"), index=None)


def main(start_index, end_index):
    coris = Coris()
    ehr_tables = coris.get_tables(schema='ehr')
    combos = list(combinations(list(ehr_tables['table_names']), 2))
    ProcessCompareTables(combos[start_index:end_index])

if __name__ == "__main__":
    try:
        sys.argv[1]
        sys.argv[2]
        main(int(sys.argv[1]), int(sys.argv[2]))
    except IndexError as e:
        print(f"""
              This program takes 2 arguments.
              Start index and end index as integers.
              Ex: python main.py 4 10

              The point is we have many
              combos of tables so I'm
              setting this up to be run
              in batches.
              """)
        print(e)    
