DROP TABLE IF EXISTS coris_registry.C3304_T8_Labs_20250429;
CREATE TABLE coris_registry.C3304_T8_Labs_20250429
(
  Arb_Person_ID BIGINT,
  Arb_Encounter_Id BIGINT,
  LabEpicID TEXT,
  LabOrderEpicId NUMERIC,
  LabName TEXT,
  PanelName TEXT,
  ComponentName TEXT,
  NumericValue FLOAT8,
  Unit TEXT,
  ReferenceRange TEXT,
  CollectionDate DATE,
  ResultDate DATE,
  AuthorizingProv TEXT,
  OrderingProv TEXT,
  LoincCode TEXT
);

