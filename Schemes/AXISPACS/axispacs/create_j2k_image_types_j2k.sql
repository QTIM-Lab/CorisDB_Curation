DROP TABLE IF EXISTS axispacs.j2k_image_types;
CREATE TABLE axispacs.j2k_image_types (
QTIM_Modality varchar(50),
ImageType varchar(15),
ParsedImageGroup varchar(25),
ReportType varchar(15),
Layer_Name varchar(15),
Procedure varchar(50),
ScanPattern varchar(15),
count INT,
Raw_Type varchar(10),
Misc varchar(200)
);

/* Login */
-- psql -U coris_admin coris_db;

/* Import */
\copy axispacs.j2k_image_types FROM '/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/axispacs_image_types_j2k_manually_curated.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;


/* Delete */
delete from axispacs.j2k_image_types;

/* Counts */
select count(*) from  axispacs.j2k_image_types; -- 

/* Explore */
select * from axispacs.j2k_image_types
limit 10;