
CREATE TABLE axispacs_snowflake.spectralis_filepaths_and_meta (
    file_path_coris text,
    "PID" text,
    "ExamDate" text,
    "Laterality" text,
    "Procedure" text,
    "ReportType" text,
    "ImageNumber" text,
    "ImageGroup" text,
    "ImageType" text,
    type text,
    "ImageWidth" text,
    "ImageHeight" text,
    "Start_X" text,
    "Start_Y" text,
    "End_X" text,
    "End_Y" text,
    "ILM" text,
    "RPE" text,
    status text,
    "Scale_X" text,
    "Scale_Y" text,
    "Scale_Z" text,
    "SizeX" text,
    "SizeZ" text,
    "XSlo" text,
    "YSlo" text,
    "ScanPattern" text,
    "TimeStamp_TotalSeconds" text,
    "AttendingPhysician" text
);

-- bulk insert data from the CSV file
-- must run from psql terminal...not executable in vscode like other sql code
-- really annoying but trust me:

-- $ psql -U coris_admin coris_db;
-- Password for user coris_admin: 
-- psql (16.9 (Ubuntu 16.9-0ubuntu0.24.04.1))
-- Type "help" for help.

-- coris_db=> 
\copy axispacs_snowflake.spectralis_filepaths_and_meta FROM '/scratch90/QTIM/Active/23-0284/EHR/SNOWFLAKE/spectralis_filepaths_and_meta.csv' DELIMITERS ',' CSV QUOTE '"' HEADER;