DROP TABLE IF EXISTS coris_registry.C3304_T25_MAR_injections_20260210;
CREATE TABLE coris_registry.C3304_T25_MAR_injections_20260210
(
  arb_person_id BIGINT,
  primarymrn TEXT,
  ordername TEXT,
  ORDEREDINSTANT TIMESTAMP,
  MEDICATIONORDEREPICID NUMERIC,
  genericname TEXT,
  therapeuticclass TEXT,
  pharmaceuticalclass TEXT,
  pharmaceuticalsubclass TEXT,
  mar_site TEXT,
  administrationroute TEXT,
  administrationaction TEXT,
  administrationinstant TIMESTAMP,
  dose TEXT,
  doseunit TEXT
);

