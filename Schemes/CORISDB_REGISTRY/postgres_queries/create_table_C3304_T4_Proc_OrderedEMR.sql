DROP TABLE IF EXISTS coris_registry.C3304_T4_Proc_OrderedEMR_20250429;
CREATE TABLE coris_registry.C3304_T4_Proc_OrderedEMR_20250429
(
  Arb_Person_Id BIGINT,
  Arb_Encounter_Id BIGINT,
  Arb_Procedure_ID BIGINT,
  ProcedureEpicId NUMERIC,
  ProcedureName TEXT,
  PatientFriendlyName TEXT,
  ProcedureCode TEXT,
  ProcedureDate DATE,
  ProcedureTime TIME,
  ProviderRole TEXT,
  Department TEXT,
  PerformingProvName TEXT,
  AppointmentStatus TEXT,
  PrimaryLocation TEXT
);

