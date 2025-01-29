DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T7_Medication;
CREATE TABLE IF NOT EXISTS coris_registry.C3304_GBQ_T7_Medication (
    Arb_Person_ID BIGINT,
    Arb_Encounter_Id BIGINT,
    MedicationEpicId NUMERIC,
    MedicationOrderEpicId NUMERIC,
    MedicationCode varchar,
    MedicationName varchar,
    Source varchar,
    Dose NUMERIC,
    DoseUnit varchar,
    MedicationStartDate DATE,
    MedicationStopDate DATE,
    Route varchar,
    Frequency varchar,
    Mode varchar,
    TherapeuticClass varchar,
    PharmaceuticalClass varchar,
    PharmaceuticalSubclass varchar,
    OrderedDate DATE,
    DispensePreparedInstant TIME,
    OrderedByProvider varchar,
    AuthorizingProvider varchar,
    OrderedBySpecialty varchar,
    AuthorizingBySpecialty varchar
                );

