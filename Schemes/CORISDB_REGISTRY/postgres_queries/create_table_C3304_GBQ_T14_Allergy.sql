DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T14_Allergy;
CREATE TABLE IF NOT EXISTS coris_registry.C3304_GBQ_T14_Allergy (
    Arb_Person_ID BIGINT,
    AllergenEpicId NUMERIC,
    AllergyName VARCHAR,
    AllergyReactions VARCHAR,
    AllergyStartDate DATE,
    AllergyEndDate DATE
                );