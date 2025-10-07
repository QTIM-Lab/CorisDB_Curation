/* Glaucoma Queries */
SELECT table_name, column_name, data_type FROM information_schema.columns --limit 100;
WHERE table_name like '%glaucoma%';

/* DANGER */
DROP TABLE IF EXISTS glaucoma.glaucoma_summary_stats; -- Backed Up
DROP VIEW IF EXISTS glaucoma.glaucoma_demographics; -- Backed Up
DROP VIEW IF EXISTS glaucoma.last_encounters; -- Backed Up
DROP TABLE IF EXISTS glaucoma.glaucoma_encounters; -- Backed Up
DROP TABLE IF EXISTS glaucoma.glaucoma_visits; -- Backed Up
DROP TABLE IF EXISTS glaucoma.glaucoma_patients; -- Backed Up
DROP TABLE IF EXISTS glaucoma.glaucoma_counts;
DROP TABLE IF EXISTS glaucoma.diagnosis_and_patient; -- Backed Up
DROP VIEW IF EXISTS glaucoma.glaucoma_diagnosis_dx_ids; -- Backed Up

DROP TABLE IF EXISTS glaucoma.glaucoma_encounter_visit_join; -- Backed Up
/* DANGER */
