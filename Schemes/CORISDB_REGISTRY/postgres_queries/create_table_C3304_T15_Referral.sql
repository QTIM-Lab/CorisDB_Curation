DROP TABLE IF EXISTS coris_registry.C3304_T15_Referral_20250429;
CREATE TABLE coris_registry.C3304_T15_Referral_20250429
(
  Arb_Person_ID BIGINT,
  Arb_Encounter_Id BIGINT,
  ReferralEpicId NUMERIC,
  CreationInstant TIMESTAMP,
  ReferringProv TEXT,
  ReferringDep TEXT,
  ReferredToProv TEXT,
  ReferredToDep TEXT,
  FirstReasonForReferral TEXT,
  SecondReasonForReferral TEXT,
  ThirdReasonForReferral TEXT
);

