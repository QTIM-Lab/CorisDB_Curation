DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T10_Flowsheets_20240925;
CREATE TABLE IF NOT EXISTS coris_registry.C3304_GBQ_T10_Flowsheets_20240925 (
    Arb_Person_Id BIGINT,
    Arb_Encounter_Id BIGINT,
    FlowsheetTemplateEpicId VARCHAR,
    FlowsheetRowEpicId VARCHAR,
    FlowsheetTemplateName VARCHAR,
    FlowsheetRowName VARCHAR,
    DisplayName VARCHAR,
    Value VARCHAR,
    NumericValue NUMERIC,
    Unit VARCHAR,
    FlowsheetDate DATE,
    TakenByEmployee VARCHAR,
    DocumentedByEmployee VARCHAR
                );

