DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T15_Referral;
CREATE TABLE IF NOT EXISTS coris_registry.C3304_GBQ_T15_Referral (
    Arb_Person_ID BIGINT,
    Arb_Encounter_Id BIGINT,
    ReferralEpicId NUMERIC,
    CreationInstant TIME,
    ReferringProv VARCHAR,
    ReferringDep VARCHAR,
    ReferredToProv VARCHAR,
    ReferredToDep VARCHAR,
    FirstReasonForReferral VARCHAR,
    SecondReasonForReferral VARCHAR,
    ThirdReasonForReferral VARCHAR
                );

