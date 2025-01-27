DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T8_Labs_20240925;
CREATE TABLE IF NOT EXISTS coris_registry.C3304_GBQ_T8_Labs_20240925 (
    Arb_Person_ID BIGINT,
    Arb_Encounter_Id BIGINT,
    LabEpicID VARCHAR,
    LabOrderEpicId NUMERIC,
    LabName VARCHAR,
    PanelName VARCHAR,
    ComponentName VARCHAR,
    NumericValue FLOAT8,
    Unit VARCHAR,
    ReferenceRange VARCHAR,
    CollectionDate DATE,
    ResultDate DATE,
    AuthorizingProv VARCHAR,
    OrderingProv VARCHAR,
    LoincCode VARCHAR
                );

