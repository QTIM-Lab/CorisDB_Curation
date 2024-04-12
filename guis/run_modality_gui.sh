#!/usr/bin/bash

python guis/modality_screening.py \
--root coris_db_subsets/image_modality_classifier/ \
--csv-path raw_data_inspect.csv \
--image-col-name file_path_coris \
--save-as raw_data_inspected.csv