/* Create a simplified slimmed down diagnosis table from coris_registry.c3304_gbq_t3_diagnosis_<date> */

-- | diagnosis_pk | diagnosiscodetype | diagnosiscode | diagnosisdescription | provenance |
DROP TABLE IF EXISTS coris_registry.bb_gbq_diagnosis_20240925;
CREATE TABLE coris_registry.bb_gbq_diagnosis_20240925 AS -- Replace with your desired table name
WITH distinct_data AS (
    SELECT DISTINCT 
        diagnosiscodetype, 
        diagnosiscode, 
        diagnosisdescription, 
        provenance
    FROM 
        coris_registry.c3304_gbq_t3_diagnosis_20240925
)
SELECT 
    ROW_NUMBER() OVER (ORDER BY diagnosiscodetype, diagnosiscode, diagnosisdescription, provenance) AS diagnosis_pk,  -- Generate a unique row number
    diagnosiscodetype,
    diagnosiscode,
    diagnosisdescription,
    provenance
FROM 
    distinct_data;
