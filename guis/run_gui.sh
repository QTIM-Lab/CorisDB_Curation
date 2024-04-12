#!/usr/bin/bash

python AF_vs_IR_screening_GUI.py \
--root coris_db_subsets/AMD/Fundus_Auto_Fluorescence \
--csv-path AMD_Epi_AF-IR_preprocessed.csv \
--image-col-name file_path_coris \
--save-as AMD_Epi_AF-IR_wmodality.csv
