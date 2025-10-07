DROP TABLE IF EXISTS coris_registry.C3304_T9_ADT_20250429;
CREATE TABLE coris_registry.C3304_T9_ADT_20250429
(
  Arb_Patient_Id BIGINT,
  Arb_Encounter_Id BIGINT,
  DepartmentEpicId TEXT,
  HospitalUnit TEXT,
  line_number BIGINT,
  PatientClass TEXT,
  EventType TEXT,
  AdmissionType TEXT,
  DischargeDisposition TEXT,
  TransferInDate DATE,
  TransferOutTime TIME,
  TimeValue TIME
);

