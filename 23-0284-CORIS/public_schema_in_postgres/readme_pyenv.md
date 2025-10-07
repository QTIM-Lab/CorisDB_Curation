. ~/.bashrc
pyenv virtualenvs
pyenv deactivate
pyenv activate corisdb_curation
cd CorisDB_Curation/23-0284-CORIS/public_schema_in_postgres


#pip install xlsxwriter

python read_schema.py # Start interpreter