DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T15_Referral_20240925;
CREATE TABLE IF NOT EXISTS coris_registry.C3304_GBQ_T15_Referral_20240925 (
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

