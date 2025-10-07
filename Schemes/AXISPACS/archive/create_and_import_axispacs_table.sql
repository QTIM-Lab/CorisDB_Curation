

DROP TABLE IF EXISTS axispacs.dicom_headers;
CREATE TABLE IF NOT EXISTS axispacs.dicom_headers (
    FILENAMEPATH VARCHAR(200),
    PATIENTMRN VARCHAR(50),
    SOPINSTANCEUID VARCHAR(100),
    SERIESINSTANCEUID VARCHAR(100),
    STUDYINSTANCEUID VARCHAR(100),
    ACQUISITIONDATETIME VARCHAR(50),
    SOPCLASSUID VARCHAR(100),
    SOPCLASSUIDDESCRIPTION VARCHAR(100),
    MODALITY VARCHAR(50),
    MODALITYLUTSEQUENCE VARCHAR(50),
    IMAGETYPE VARCHAR(100),
    MIMETYPEOFENCAPSULATEDDOCUMENT VARCHAR(50),
    INSTITUTIONNAME VARCHAR(50),
    MANUFACTURER VARCHAR(50),
    MANUFACTURERMODELNAME VARCHAR(50),
    LATERALITY VARCHAR(50),
    BITSALLOCATED VARCHAR(50),
    PHOTOMETRICINTERPRETATION VARCHAR(50),
    PIXELSPACING VARCHAR(50),
    STATIONNAME VARCHAR(50),
    SERIESDESCRIPTION VARCHAR(50),
    STUDYDATE VARCHAR(50),
    STUDYTIME VARCHAR(50),
    DOCTYPE_NON_STANDARD_TAG VARCHAR(50),
    AverageRNFLThickness_micrometers VARCHAR(50),
    OpticCupVolume_mm_squared VARCHAR(50),
    OpticDiskArea_mm_squared VARCHAR(50),
    RimArea_mm_squared VARCHAR(50),
    AvgCDR VARCHAR(50),
    VerticalCD VARCHAR(50)
);

/* Login */
psql -U coris_admin coris_db;

/* Import */
\copy axispacs.dicom_headers FROM '/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/axispacs_sample_dicom_headers_parsed.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;
\copy axispacs.dicom_headers FROM '/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/axispacs_dicom_headers_parsed.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;

-- vim /scratch90/QTIM/Active/23-0284/EHR/AXISPACS/axispacs_sample_dicom_headers_parsed.csv

/* Delete */
delete from axispacs.dicom_headers;

/* Counts */
select count(*) from  axispacs.dicom_headers; -- 1,073,126

/* Explore */
select * from axispacs.dicom_headers
-- where laterality != 'Tag not found'
-- where bitsallocated != 'Tag not found'
-- where pixelspacing != 'Tag not found'
where imagetype != 'Tag not found'
limit 10;