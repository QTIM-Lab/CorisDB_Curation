\copy coris_registry.C3304_2_CORIS_to_SOURCE FROM '/data/linking_various_systems/coris_db_gbq/tmp_for_import/C3304_2_CORIS_to_SOURCE_20240228.csv' DELIMITERS ',' NULL AS 'NULL' CSV QUOTE '''' HEADER;
\copy coris_registry.C3304_GBQ_T19_MYC_Messages FROM '/data/linking_various_systems/coris_db_gbq/tmp_for_import/C3304_GBQ_T19_MYC_Messages.csv' DELIMITERS ',' NULL AS 'NULL' CSV QUOTE '''' HEADER;
\copy coris_registry.C3304_T11_Notes FROM '/data/linking_various_systems/coris_db_gbq/tmp_for_import/C3304_T11_Notes_20240207.csv' DELIMITERS ',' NULL AS 'NULL' CSV QUOTE '''' HEADER;
