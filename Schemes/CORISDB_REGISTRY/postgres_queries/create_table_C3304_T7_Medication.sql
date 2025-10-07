DROP TABLE IF EXISTS coris_registry.C3304_T7_Medication_20250429;
CREATE TABLE coris_registry.C3304_T7_Medication_20250429
(
  Arb_Person_ID BIGINT,
  Arb_Encounter_Id BIGINT,
  MedicationEpicId NUMERIC,
  MedicationOrderEpicId NUMERIC,
  MedicationCode TEXT,
  MedicationName TEXT,
  Source TEXT,
  Dose NUMERIC,
  DoseUnit TEXT,
  MedicationStartDate DATE,
  MedicationStopDate DATE,
  Route TEXT,
  Frequency TEXT,
  Mode TEXT,
  TherapeuticClass TEXT,
  PharmaceuticalClass TEXT,
  PharmaceuticalSubclass TEXT,
  OrderedDate DATE,
  DispensePreparedInstant TIMESTAMP,
  OrderedByProvider TEXT,
  AuthorizingProvider TEXT,
  OrderedBySpecialty TEXT,
  AuthorizingBySpecialty TEXT
);

