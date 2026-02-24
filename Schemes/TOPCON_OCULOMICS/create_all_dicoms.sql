
DROP TABLE IF EXISTS topcon_oculomics.all_dicoms;
CREATE TABLE topcon_oculomics.all_dicoms (
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
    SOPDescription varchar(100),
    ImageType varchar(100),
    MIMETypeOfEncapsulateDocument varchar(50),
    DocumentTitle varchar(50),
    InstitutionName varchar(50),
    Manufacturer varchar(50),
    ManufacturerModelName varchar(50),
    Laterality varchar(50),
    PerFrameFunctionalGroupsSequence JSONB,
    BitsAllocated varchar(50),
    PhotometricInterpretation varchar(50),
    PixelSpacing varchar(50),
    StationName varchar(50),
    SeriesDescription varchar(50),
    StudyTime varchar(50),
    DOCType varchar(50),
    AverageRNFLThickness_Micrometers NUMERIC,
    OpticCupVolume_mm_squared NUMERIC,
    OpticDiskArea_mm_squared NUMERIC,
    RimArea_mm_squared NUMERIC,
    AvgCDR NUMERIC,
    VerticalCD NUMERIC, --,
    -- basename TEXT, -- do we need anymore (was more useful in AXISPACS to join j2ks\xmls\dicoms together by file basename)
    
    --# after classification #--
    QTIM_Modality_pred VARCHAR(50),
    is_unknown_combo BOOLEAN DEFAULT FALSE
);

/* Login */
-- psql -U coris_admin coris_db;

/* Import */
\copy topcon_oculomics.all_dicoms FROM '/scratch90/QTIM/Active/23-0284/EHR/TOPCON_OCULOMICS/parsed/topcon_oculomics_parse_dicom_for_postgres_classified.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;


/* Delete */
-- delete from topcon_oculomics.all_dicoms;

/* Counts */
select count(*) from  topcon_oculomics.all_dicoms; -- 

/* Explore */
select file_path, mrn, modality from topcon_oculomics.all_dicoms
limit 10;