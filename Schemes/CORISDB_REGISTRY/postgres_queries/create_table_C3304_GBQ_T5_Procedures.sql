DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T5_Procedures_20240925;
CREATE TABLE coris_registry.C3304_GBQ_T5_Procedures_20240925
(
  Arb_Person_Id INTEGER,
  Arb_Encounter_Id INTEGER,
  Arb_Procedure_ID INTEGER,
  ProcedureEpicId NUMERIC,
  ProcedureName VARCHAR,
  PatientFriendlyName VARCHAR,
  ProcedureCode VARCHAR,
  ProcedureDate TIMESTAMP WITHOUT TIME ZONE,
  ProcedureTime TIME WITHOUT TIME ZONE,
  ProviderRole VARCHAR,
  Department VARCHAR,
  PerformingProvName VARCHAR,
  PrimaryLocation VARCHAR
);

