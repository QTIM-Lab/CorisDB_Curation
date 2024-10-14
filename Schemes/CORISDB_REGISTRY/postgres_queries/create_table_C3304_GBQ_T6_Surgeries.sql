DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T6_Surgeries_20240925;
CREATE TABLE coris_registry.C3304_GBQ_T6_Surgeries_20240925
(
  Arb_Person_ID INTEGER,
  Arb_Encounter_Id INTEGER,
  Arb_SurgeryEncounter_Id INTEGER,
  SurgicalCaseEpicId VARCHAR,
  SurgeryProcedureID VARCHAR,
  ProcedureName VARCHAR,
  PatientFriendlyName VARCHAR,
  DisplayName VARCHAR,
  DateOfProcedure TIMESTAMP WITHOUT TIME ZONE,
  TimeOfProcedure TIME WITHOUT TIME ZONE,
  DepartmentName VARCHAR,
  TeamType VARCHAR,
  LogStatus VARCHAR,
  PrimaryProviderName VARCHAR,
  PrimaryProviderType VARCHAR,
  SecondProvName VARCHAR,
  SecondProvType VARCHAR,
  ThirdProvName VARCHAR,
  ThirdProvType VARCHAR
);

