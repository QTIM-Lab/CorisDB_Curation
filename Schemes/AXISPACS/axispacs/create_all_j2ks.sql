DROP TABLE IF EXISTS axispacs.all_j2ks;
CREATE TABLE axispacs.all_j2ks (
    file_path TEXT,
    file_path_xml TEXT,
    mrn VARCHAR(200),
    FirstName TEXT,
    LastName TEXT,
    DOB DATE,
    Gender CHAR(1),
    ExamDate DATE,
    Laterality TEXT,
    DeviceID NUMERIC,
    DataFile TEXT,
    ImageWidth NUMERIC,
    ImageNumber NUMERIC,
    ImageHeight NUMERIC,
    ImageGroup TEXT,
    ImageFile TEXT,
    AttendingPhysician TEXT,
    ReportType TEXT,
    Pathology TEXT,
    Procedure TEXT,
    Layer_Name TEXT,
    Start_X NUMERIC,
    Start_Y NUMERIC,
    End_X NUMERIC,
    End_Y NUMERIC,
    SizeX NUMERIC,
    SizeZ NUMERIC,
    ScanPattern TEXT,
    Scale_X NUMERIC,
    Scale_Y NUMERIC,
    Scale_Z NUMERIC,
    XSlo NUMERIC,
    YSlo NUMERIC,
    TimeStamp_TotalSeconds NUMERIC,
    ImageType TEXT,
    file_path_dcm TEXT,
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
    MIMETypeOfEncapsulateDocument varchar(50),
    InstitutionName varchar(100),
    Manufacturer varchar(50),
    ManufacturerModelName varchar(50),
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
    basename VARCHAR(200),
    -- after classification
    QTIM_Modality_pred VARCHAR(50),
    is_unknown_combo BOOLEAN DEFAULT FALSE
);


/* Login */
-- psql -U coris_admin coris_db;

/* Import */
\copy axispacs.all_j2ks FROM '/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/all_j2k_classified.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;


/* Delete */
delete from axispacs.all_j2ks;

/* Counts */
select count(*) from  axispacs.all_j2ks; -- 

/* Explore */
select * from axispacs.all_j2ks
limit 10;