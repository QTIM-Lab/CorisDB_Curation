DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T19_MYC_Messages;
CREATE TABLE IF NOT EXISTS coris_registry.C3304_GBQ_T19_MYC_Messages (
    Arb_Person_Id BIGINT,
    Arb_Encounter_Id BIGINT,
    CREATE_TIME TIMESTAMP,
    PROVIDER VARCHAR,
    MessageType VARCHAR,
    MSG_ID VARCHAR,
    MSG_TXT TEXT,
    NoteLine BIGINT
                );

