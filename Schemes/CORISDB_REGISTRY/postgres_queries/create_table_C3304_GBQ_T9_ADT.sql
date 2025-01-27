DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T9_ADT_20240925;
CREATE TABLE IF NOT EXISTS coris_registry.C3304_GBQ_T9_ADT_20240925 (
    Arb_Patient_Id BIGINT,
    Arb_Encounter_Id BIGINT,
    DepartmentEpicId VARCHAR,
    HospitalUnit VARCHAR,
    line_number BIGINT,
    PatientClass VARCHAR,
    EventType VARCHAR,
    AdmissionType VARCHAR,
    DischargeDisposition VARCHAR,
    TransferInDate DATE,
    TransferOutTime INTERVAL,
    TimeValue VARCHAR
                );

