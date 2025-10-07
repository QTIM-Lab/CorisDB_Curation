DROP TABLE IF EXISTS coris_registry.C3304_T2_Encounter_20250923;
CREATE TABLE coris_registry.C3304_T2_Encounter_20250923
(
  Arb_Person_ID BIGINT,
  Arb_Encounter_Id BIGINT,
  CSN NUMERIC,
  Department TEXT,
  DepartmentSpecialty TEXT,
  EncounterType TEXT,
  PatientClass TEXT,
  date TIMESTAMP,
  AdmissionDate DATE,
  DischargeDate DATE,
  LOSDays NUMERIC,
  LOSHours NUMERIC,
  ICULOSDays NUMERIC,
  ProviderName TEXT,
  PrimarySpecialty TEXT,
  PayorFinancialClass TEXT,
  PayorName TEXT
);

