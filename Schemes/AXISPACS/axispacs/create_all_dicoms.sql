DROP TABLE IF EXISTS axispacs.all_dicoms;
CREATE TABLE axispacs.all_dicoms (
    file_path TEXT,
    mrn varchar(100),
    StudyInstanceUID TEXT,
    SeriesInstanceUID TEXT,
    SOPInstanceUID TEXT,
    Modality VARCHAR(10),
    StudyDate DATE,
    SeriesNumber NUMERIC,
    InstanceNumber NUMERIC,
    AcquisitionDateTime varchar(50),
    SOPClassUID varchar(100),
    SOPClassDescription varchar(100),
    ImageType varchar(200),
    MIMETypeOfEncapsulateDocument varchar(50),
    InstitutionName varchar(100),
    Manufacturer varchar(50),
    ManufacturerModelName varchar(50),
    Laterality varchar(50),
    BitsAllocated varchar(50),
    PhotometricInterpretation varchar(50),
    PixelSpacing varchar(50),
    StationName varchar(50),
    SeriesDescription varchar(50),
    StudyTime varchar(50),
    DocType varchar(50),
    AverageRNFLThickness_Micrometers NUMERIC,
    OpticCupVolume_mm_squared NUMERIC,
    OpticDiskArea_mm_squared NUMERIC,
    RimArea_mm_squared NUMERIC,
    AvgCDR NUMERIC,
    VerticalCD NUMERIC,
    basename TEXT,
    -- after classification
    QTIM_Modality_pred VARCHAR(50),
    is_unknown_combo BOOLEAN DEFAULT FALSE
);

/* Login */
-- psql -U coris_admin coris_db;

/* Import */
\copy axispacs.all_dicoms FROM '/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/all_dicom_classified.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;


/* Delete */
delete from axispacs.all_dicoms;

/* Counts */
select count(*) from  axispacs.all_dicoms; -- 

/* Explore */
select * from axispacs.all_dicoms
limit 10;