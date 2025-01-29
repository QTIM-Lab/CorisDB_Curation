DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T5_Procedures;
CREATE TABLE coris_registry.C3304_GBQ_T5_Procedures
(
  Arb_Person_Id BIGINT,
  Arb_Encounter_Id BIGINT,
  Arb_Procedure_ID BIGINT,
  ProcedureEpicId NUMERIC,
  ProcedureName VARCHAR,
  PatientFriendlyName VARCHAR,
  ProcedureCode VARCHAR,
  ProcedureDate TIMESTAMP WITHOUT TIME ZONE,
  ProcedureTime INTERVAL,
  ProviderRole VARCHAR,
  Department VARCHAR,
  PerformingProvName VARCHAR,
  PrimaryLocation VARCHAR
);

