DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T6_Surgeries;
CREATE TABLE IF NOT EXISTS coris_registry.C3304_GBQ_T6_Surgeries (
    Arb_Person_ID BIGINT,
    Arb_Encounter_Id BIGINT,
    Arb_SurgeryEncounter_Id BIGINT,
    SurgicalCaseEpicId VARCHAR,
    SurgeryProcedureID VARCHAR,
    ProcedureName VARCHAR,
    PatientFriendlyName VARCHAR,
    DisplayName VARCHAR,
    DateOfProcedure DATE,
    TimeOfProcedure VARCHAR,
    DepartmentName VARCHAR,
    TeamType VARCHAR,
    LogStatus VARCHAR,
    PrimaryProviderName VARCHAR,
    PrimaryProviderType VARCHAR,
    SecondProvName VARCHAR,
    SecondProvType VARCHAR,
    ThirdProvName VARCHAR,
    ThirdProvType VARCHAR
                );

