DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T3_Diagnosis;
CREATE TABLE coris_registry.C3304_GBQ_T3_Diagnosis
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

