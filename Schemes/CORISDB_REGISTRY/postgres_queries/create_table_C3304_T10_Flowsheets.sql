DROP TABLE IF EXISTS coris_registry.C3304_T10_Flowsheets_20250429;
CREATE TABLE coris_registry.C3304_T10_Flowsheets_20250429
(
  Arb_Person_Id BIGINT,
  Arb_Encounter_Id BIGINT,
  FlowsheetTemplateEpicId TEXT,
  FlowsheetRowEpicId TEXT,
  FlowsheetTemplateName TEXT,
  FlowsheetRowName TEXT,
  DisplayName TEXT,
  Value TEXT,
  NumericValue NUMERIC,
  Unit TEXT,
  FlowsheetDate TIMESTAMP,
  TakenByEmployee TEXT,
  DocumentedByEmployee TEXT
);

