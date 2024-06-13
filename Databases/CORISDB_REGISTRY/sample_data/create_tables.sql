CREATE TABLE IF NOT EXISTS coris_registry.C3304_2_CORIS_to_SOURCE (
    SOURCEid VARCHAR(100),
    CORISid BIGINT

    --table_constraints
    );

CREATE TABLE IF NOT EXISTS coris_registry.C3304_GBQ_T19_MYC_Messages (
    Arb_Person_Id BIGINT,
    Arb_Encounter_Id BIGINT,
    CREATE_TIME TIMESTAMP WITH TIME ZONE,
    PROVIDER VARCHAR(100),
    MessageType VARCHAR(100),
    MSG_ID INTEGER,
    MSG_TXT TEXT,
    NoteLine INTEGER

    --table_constraints
    );

CREATE TABLE IF NOT EXISTS coris_registry.C3304_T11_Notes (
    Arb_Person_Id BIGINT,
    Arb_Encounter_Id BIGINT,
    NoteEpicId BIGINT,
    NoteType VARCHAR(100),
    NoteText TEXT,
    NoteProvider VARCHAR(100),
    DateOfNote TIMESTAMP WITH TIME ZONE,
    TimeOfNote TIME

    --table_constraints
    );

