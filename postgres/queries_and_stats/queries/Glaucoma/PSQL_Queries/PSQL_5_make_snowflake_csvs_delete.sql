\copy (SELECT * FROM glaucoma.glaucoma_patients) TO '/data/Glaucoma_FROM_PACS/output.csv' WITH (FORMAT CSV, HEADER)
\copy (SELECT * FROM glaucoma.glaucoma_patients) TO '/data/Glaucoma_FROM_PACS/glaucoma_patients_from_coris_db.csv' WITH (FORMAT CSV, HEADER)
\copy (SELECT pat_id, pat_mrn FROM public.ophthalmologypatients) TO '/data/Glaucoma_FROM_PACS/all_patients_from_coris_db.csv' WITH (FORMAT CSV, HEADER)
