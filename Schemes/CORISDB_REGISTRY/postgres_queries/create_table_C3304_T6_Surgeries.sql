DROP TABLE IF EXISTS coris_registry.C3304_T6_Surgeries_20250429;
CREATE TABLE coris_registry.C3304_T6_Surgeries_20250429
(
  Arb_Person_ID BIGINT,
  Arb_Encounter_Id BIGINT,
  Arb_SurgeryEncounter_Id BIGINT,
  SurgicalCaseEpicId TEXT,
  SurgeryProcedureID TEXT,
  ProcedureName TEXT,
  PatientFriendlyName TEXT,
  DisplayName TEXT,
  DateOfProcedure DATE,
  TimeOfProcedure TIME,
  DepartmentName TEXT,
  TeamType TEXT,
  LogStatus TEXT,
  PrimaryProviderName TEXT,
  PrimaryProviderType TEXT,
  SecondProvName TEXT,
  SecondProvType TEXT,
  ThirdProvName TEXT,
  ThirdProvType TEXT
);

