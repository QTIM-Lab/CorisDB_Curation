-- \copy coris_registry.C3304_GBQ_T1_Person FROM '/scratch90/QTIM/Active/23-0284/EHR/CORIS_REGISTRY_GBQ/tmp_for_import/C3304_GBQ_T1_Person_10.csv' DELIMITERS ',' CSV QUOTE '"' HEADER NULL 'NULL';
\copy coris_registry.C3304_GBQ_T1_Person FROM '/scratch90/QTIM/Active/23-0284/EHR/CORIS_REGISTRY_GBQ/tmp_for_import/C3304_GBQ_T1_Person.csv' DELIMITERS ',' CSV QUOTE '"' HEADER NULL 'NULL';

-- delete from coris_registry.C3304_GBQ_T1_Person;