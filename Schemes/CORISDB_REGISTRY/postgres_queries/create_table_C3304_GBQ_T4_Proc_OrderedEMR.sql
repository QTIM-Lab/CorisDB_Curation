DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T4_Proc_OrderedEMR_20240925;
CREATE TABLE coris_registry.C3304_GBQ_T4_Proc_OrderedEMR_20240925
(
  Arb_Person_Id BIGINT,
  Arb_Encounter_Id BIGINT,
  Arb_Procedure_ID BIGINT,
  ProcedureEpicId BIGINT,
  ProcedureName VARCHAR,
  PatientFriendlyName VARCHAR,
  ProcedureCode VARCHAR,
  ProcedureDate VARCHAR,
  ProcedureTime VARCHAR,
  ProviderRole VARCHAR,
  Department VARCHAR,
  PerformingProvName VARCHAR,
  AppointmentStatus VARCHAR,
  PrimaryLocation VARCHAR
);

