#!/usr/bin/bash

python guis/data_quality_screening_GUI.py \
--root coris_db_subsets/AMD/Fundus_Auto_Fluorescence/OptimEYES_Prospective/ \
--csv-path OptimEYES_Prospective_GA_ICD_Code_Cohort_converted.csv \
--image-col-name file_path_coris \
--save-as OptimEYES_Prospective_GA_ICD_Code_Cohort_inspected.csv