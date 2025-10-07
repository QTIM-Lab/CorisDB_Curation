DROP TABLE IF EXISTS coris_registry.C3304_T13_SocialHistory_20250429;
CREATE TABLE coris_registry.C3304_T13_SocialHistory_20250429
(
  Arb_Person_Id BIGINT,
  Arb_Encounter_Id BIGINT,
  Date DATE,
  CigarettePacksPerDay NUMERIC,
  TobaccoUseInYears NUMERIC,
  AlcoholOzPerWeek TEXT,
  IllicitDrugFreqPerWeek NUMERIC,
  Cigarettes NUMERIC,
  Pipes NUMERIC,
  Cigars NUMERIC,
  Snuff NUMERIC,
  Chew NUMERIC,
  IVDrugUser NUMERIC,
  TobaccoUse TEXT,
  TobaccoUseComment TEXT,
  SmokingTobaccoUse TEXT,
  SmokelessTobaccoUse TEXT,
  SmokelessTobaccoQuitDate DATE,
  AlcoholUseComment TEXT,
  AlcoholUse TEXT,
  IllicitDrugUseComment TEXT,
  IllicitDrugUse TEXT
);

