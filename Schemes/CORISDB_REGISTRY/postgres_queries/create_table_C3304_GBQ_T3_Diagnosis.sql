DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T3_Diagnosis_20240925;
CREATE TABLE coris_registry.C3304_GBQ_T3_Diagnosis_20240925
(
  Arb_Person_ID BIGINT,
  Arb_Encounter_Id BIGINT,
  DiagnosisCodeType VARCHAR,
  DiagnosisCode VARCHAR,
  DiagnosisDescription VARCHAR,
  EncounterDate VARCHAR,
  ProblemOnsetDate VARCHAR,
  ProblemResolutonDate VARCHAR,
  Provenance VARCHAR
);

