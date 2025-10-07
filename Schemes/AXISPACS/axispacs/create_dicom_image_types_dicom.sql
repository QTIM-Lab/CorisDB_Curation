DROP TABLE IF EXISTS axispacs.dicom_image_types;
CREATE TABLE axispacs.dicom_image_types (
    QTIM_Modality varchar(100),
    SOPClassDescription varchar(200),
    Modality varchar(15),
    Manufacturer varchar(50),
    ManufacturerModelName varchar(50),
    PhotometricInterpretation varchar(50),
    SeriesDescription varchar(100),
    count INT,
    Raw_Type varchar(10),
    Misc varchar(200)
);

/* Login */
-- psql -U coris_admin coris_db;

/* Import */
\copy axispacs.dicom_image_types FROM '/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/axispacs_image_types_dicom_manually_curated.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;


/* Delete */
delete from axispacs.dicom_image_types;

/* Counts */
select count(*) from  axispacs.dicom_image_types; -- 

/* Explore */
select * from axispacs.dicom_image_types limit 10;