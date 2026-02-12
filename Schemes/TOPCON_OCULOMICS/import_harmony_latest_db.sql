-- Active: 1740690905379@@127.0.0.1@5432@coris_db@topcon_oculomics
-- Create annotations table
DROP TABLE IF EXISTS topcon_oculomics.harmony_latest_dataex_annotations CASCADE;
CREATE TABLE topcon_oculomics.harmony_latest_dataex_annotations (
    id INTEGER NOT NULL,
    studyinstanceuid VARCHAR(255),
    seriesinstanceuid VARCHAR(255),
    sopinstanceuid VARCHAR(255),
    framenumber INTEGER,
    annotationdata TEXT,
    measurementboxx INTEGER,
    measurementboxy INTEGER,
    type VARCHAR(255),
    created TIMESTAMP,
    modified TIMESTAMP,
    deleted TIMESTAMP
);

/* Import */
\copy topcon_oculomics.harmony_latest_dataex_annotations FROM '/scratch90/QTIM/Active/23-0284/EHR/TOPCON_OCULOMICS/harmony_latest_db/dataex_annotation.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;

-- Create patients table
DROP TABLE IF EXISTS topcon_oculomics.harmony_latest_dataex_patients CASCADE;
CREATE TABLE topcon_oculomics.harmony_latest_dataex_patients (
    id INTEGER NOT NULL,
    patientid VARCHAR(255),
    lastname VARCHAR(255),
    firstname VARCHAR(255),
    sex VARCHAR(255),
    birthdate TIMESTAMP,
    mergeid INTEGER,
    created TIMESTAMP,
    modified TIMESTAMP,
    deleted TIMESTAMP,
    CONSTRAINT pk_harmony_latest_dataex_patients PRIMARY KEY (id)
);
\copy topcon_oculomics.harmony_latest_dataex_patients FROM '/scratch90/QTIM/Active/23-0284/EHR/TOPCON_OCULOMICS/harmony_latest_db/dataex_patients.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;


-- Create exams table
DROP TABLE IF EXISTS topcon_oculomics.harmony_latest_dataex_exams CASCADE;
CREATE TABLE topcon_oculomics.harmony_latest_dataex_exams (
    id INTEGER NOT NULL,
    patient_fk INTEGER NOT NULL,
    studydatetime TIMESTAMP,
    studyinstanceuid VARCHAR(255),
    organizationcode VARCHAR(255),
    examtype VARCHAR(255),
    datatype VARCHAR(255),
    devicemodelname VARCHAR(255),
    stationname VARCHAR(255),
    modalities VARCHAR(255),
    created TIMESTAMP,
    modified TIMESTAMP,
    deleted TIMESTAMP,
    permanentlydeleted TIMESTAMP,
    CONSTRAINT pk_harmony_latest_dataex_exams PRIMARY KEY (id),
    CONSTRAINT patient_fk FOREIGN KEY (patient_fk) 
        REFERENCES topcon_oculomics.harmony_latest_dataex_patients (id)
);
\copy topcon_oculomics.harmony_latest_dataex_exams FROM '/scratch90/QTIM/Active/23-0284/EHR/TOPCON_OCULOMICS/harmony_latest_db/dataex_exams.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;


-- Create status table
DROP TABLE IF EXISTS topcon_oculomics.harmony_latest_dataex_status CASCADE;
CREATE TABLE topcon_oculomics.harmony_latest_dataex_status (
    id INTEGER NOT NULL,
    issuer TEXT,
    last_run TIMESTAMP,
    max_patid INTEGER,
    max_examid INTEGER,
    max_annotationid INTEGER,
    CONSTRAINT pk_harmony_latest_dataex_status PRIMARY KEY (id)
);

\copy topcon_oculomics.harmony_latest_dataex_status FROM '/scratch90/QTIM/Active/23-0284/EHR/TOPCON_OCULOMICS/harmony_latest_db/dataex_status.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;
