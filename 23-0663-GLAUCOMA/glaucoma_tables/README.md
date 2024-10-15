# Making Glaucoma Tables

Make tables in this order:

0. Look in CorisDB_Curation/23-0284-CORIS folder for `coris_registry.bb_gbq_diagnosis_20240925.sql`.
    - This make overall diagnosis table crystalized with a primary key
    - Extracted from diagnosis table but stripping out encounters

1. Make `glaucoma.bb_gbq_glaucoma_diagnosis_20240925` with `glaucoma.bb_gbq_glaucoma_diagnosis_20240925`.
2. Make `glaucoma.bb_gbq_encounter_diagnosis_20240925` with `glaucoma.bb_gbq_encounter_diagnosis_20240925.sql`.
3. Make `glaucoma.bb_gbq_encounter_20240925` with `glaucoma.bb_gbq_encounter_20240925.sql`.
4. Make `glaucoma.bb_gbq_person_20240925` with `glaucoma.bb_gbq_person_20240925.sql`.