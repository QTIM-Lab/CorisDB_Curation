-- Active: 1739829834515@@0.0.0.0@5432@coris_db@axispacs


DROP TABLE IF EXISTS axispacs.all_xmls;
CREATE TABLE axispacs.all_xmls (
    file_path TEXT,
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
    ImageType TEXT,
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
    basename VARCHAR(200)
);


/* Login */
-- psql -U coris_admin coris_db;

/* Import */
\copy axispacs.all_xmls FROM '/scratch90/QTIM/Active/23-0284/EHR/AXISPACS/all_xmls.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;


/* Delete */
delete from axispacs.all_xmls;

/* Counts */
select count(*) from  axispacs.all_xmls; -- 

/* Explore */
select * from axispacs.all_xmls
limit 10;