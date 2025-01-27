DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T13_SocialHistory_20240925;
CREATE TABLE IF NOT EXISTS coris_registry.C3304_GBQ_T13_SocialHistory_20240925 (
    Arb_Person_Id BIGINT,
    Arb_Encounter_Id BIGINT,
    Date DATE,
    CigarettePacksPerDay NUMERIC,
    TobaccoUseInYears NUMERIC,
    AlcoholOzPerWeek VARCHAR,
    IllicitDrugFreqPerWeek NUMERIC,
    Cigarettes NUMERIC,
    Pipes NUMERIC,
    Cigars NUMERIC,
    Snuff NUMERIC,
    Chew NUMERIC,
    IVDrugUser NUMERIC,
    TobaccoUse VARCHAR,
    TobaccoUseComment VARCHAR,
    SmokingTobaccoUse VARCHAR,
    SmokelessTobaccoUse VARCHAR,
    SmokelessTobaccoQuitDate DATE,
    AlcoholUseComment VARCHAR,
    AlcoholUse VARCHAR,
    IllicitDrugUseComment VARCHAR,
    IllicitDrugUse VARCHAR
                );

