DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T2_Encounter;
CREATE TABLE IF NOT EXISTS coris_registry.C3304_GBQ_T2_Encounter (
    Arb_Person_ID BIGINT,
    Arb_Encounter_Id BIGINT,
    CSN NUMERIC,
    Department VARCHAR,
    DepartmentSpecialty VARCHAR,
    EncounterType VARCHAR,
    PatientClass VARCHAR,
    date TIMESTAMP WITH TIME ZONE,
    AdmissionDate TIMESTAMP WITHOUT TIME ZONE,
    DischargeDate TIMESTAMP WITHOUT TIME ZONE,
    LOSDays INTEGER,
    LOSHours INTEGER,
    ICULOSDays INTEGER,
    ProviderName VARCHAR,
    PrimarySpecialty VARCHAR,
    PayorFinancialClass VARCHAR,
    PayorName VARCHAR
                );

