DROP TABLE IF EXISTS coris_registry.C3304_T3_Diagnosis_20250923;
CREATE TABLE coris_registry.C3304_T3_Diagnosis_20250923
(
  Arb_Person_ID BIGINT,
  Arb_Encounter_Id BIGINT,
  DiagnosisCodeType TEXT,
  DiagnosisCode TEXT,
  DiagnosisDescription TEXT,
  EncounterDate DATE,
  ProblemOnsetDate DATE,
  ProblemResolutonDate DATE,
  Provenance TEXT
);

