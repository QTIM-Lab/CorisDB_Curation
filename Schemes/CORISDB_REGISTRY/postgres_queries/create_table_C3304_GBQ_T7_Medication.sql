DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T7_Medication_20240925;
CREATE TABLE coris_registry.C3304_GBQ_T7_Medication_20240925
(
  Arb_Person_ID INTEGER,
  Arb_Encounter_Id INTEGER,
  MedicationEpicId NUMERIC,
  MedicationOrderEpicId NUMERIC,
  MedicationCode VARCHAR,
  MedicationName VARCHAR,
  Source VARCHAR,
  Dose NUMERIC,
  DoseUnit VARCHAR,
  MedicationStartDate TIMESTAMP WITHOUT TIME ZONE,
  MedicationStopDate TIMESTAMP WITHOUT TIME ZONE,
  Route VARCHAR,
  Frequency VARCHAR,
  Mode VARCHAR,
  TherapeuticClass VARCHAR,
  PharmaceuticalClass VARCHAR,
  PharmaceuticalSubclass VARCHAR,
  OrderedDate TIMESTAMP WITHOUT TIME ZONE,
  DispensePreparedInstant TIMESTAMP WITH TIME ZONE,
  OrderedByProvider VARCHAR,
  AuthorizingProvider VARCHAR,
  OrderedBySpecialty VARCHAR,
  AuthorizingBySpecialty VARCHAR
);

