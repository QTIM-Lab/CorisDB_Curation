DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T2_Encounter_20240925;
CREATE TABLE coris_registry.C3304_GBQ_T2_Encounter_20240925
(
  Arb_Person_ID BIGINT,
  Arb_Encounter_Id BIGINT,
  CSN BIGINT,
  Department VARCHAR,
  DepartmentSpecialty VARCHAR,
  EncounterType VARCHAR,
  PatientClass VARCHAR,
  date VARCHAR,
  AdmissionDate VARCHAR,
  DischargeDate VARCHAR,
  LOSDays BIGINT,
  LOSHours BIGINT,
  ICULOSDays BIGINT,
  ProviderName VARCHAR,
  PrimarySpecialty VARCHAR,
  PayorFinancialClass VARCHAR,
  PayorName VARCHAR
);

