/* AMD Queries */
SELECT table_name, column_name, data_type FROM information_schema.columns --limit 100;
WHERE table_name like '%amd%';

/* DANGER */
DROP TABLE IF EXISTS amd.amd_summary_stats; -- Backed Up
DROP VIEW IF EXISTS amd.amd_demographics; -- Backed Up
DROP VIEW IF EXISTS amd.last_encounters; -- Backed Up
DROP TABLE IF EXISTS amd.amd_encounters; -- Backed Up
DROP TABLE IF EXISTS amd.amd_visits; -- Backed Up
DROP TABLE IF EXISTS amd.amd_patients; -- Backed Up
DROP TABLE IF EXISTS amd.amd_counts;
DROP TABLE IF EXISTS amd.diagnosis_and_patient; -- Backed Up
DROP VIEW IF EXISTS amd.amd_diagnosis_dx_ids; -- Backed Up

DROP TABLE IF EXISTS amd.amd_encounter_visit_join; -- Backed Up
/* DANGER */
