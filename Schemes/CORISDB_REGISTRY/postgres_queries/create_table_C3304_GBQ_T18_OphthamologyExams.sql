DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T18_OphthamologyExams;
CREATE TABLE IF NOT EXISTS coris_registry.C3304_GBQ_T18_OphthamologyExams (
    Arb_Person_ID BIGINT,
    Arb_Encounter_Id BIGINT,
    SmartDataElementEpicId VARCHAR,
    ExamName VARCHAR,
    Abbreviation VARCHAR,
    Value VARCHAR,
    Date DATE
                );

