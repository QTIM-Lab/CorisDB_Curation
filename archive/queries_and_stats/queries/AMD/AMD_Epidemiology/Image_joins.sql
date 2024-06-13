--Generate table with AMD epidemiology data and filepaths to Color Fundus Photos from listed devices
SELECT DISTINCT (a.file_path_coris), e.pat_mrn, a.exdevtype, a.exdatetime, a.year, a.month, a.day, a.exsrno, a.ptsrno, a.ptid, a.devname, a.devdescription, a.devtype, a.devproc, a.dicomaetitle, a.devsrno, a.fileeye, a.filenote, a.filetype, a.tmstamp, a.filedata, ae.*
FROM ehr.ophthalmologypatients e
INNER JOIN axispacs_snowflake.file_paths_and_meta a ON e.pat_mrn = a.ptid
INNER JOIN amd_epidemiology.amddatabaselogitudin_data_imaging_CFP ae 
  ON CAST(e.pat_mrn as INTEGER) = ae.MRN
  AND EXTRACT(YEAR FROM ae.date_image) = a.year
  AND EXTRACT(MONTH FROM ae.date_image) = a.month
  AND EXTRACT(DAY FROM ae.date_image) = a.day
WHERE a.devname in ('NonMyd', 'Photos', 'Nidek', 'Optos', 'Topcon', 'Eidon');


--Generate table with AMD epidemiology data and filepaths to OCT B scans from Spectralis
SELECT DISTINCT (a.file_path_coris), e.pat_mrn, a.exdevtype, a.exdatetime, a.year, a.month, a.day, a.exsrno, a.ptsrno, a.ptid, a.devname, a.devdescription, a.devtype, a.devproc, a.dicomaetitle, a.devsrno, a.fileeye, a.filenote, a.filetype, a.tmstamp, a.filedata, ae.*
FROM ehr.ophthalmologypatients e
INNER JOIN axispacs_snowflake.file_paths_and_meta a ON e.pat_mrn = a.ptid
INNER JOIN amd_epidemiology.amddatabaselogitudin_data_imaging_oct ae 
  ON CAST(e.pat_mrn as INTEGER) = ae.MRN
  AND EXTRACT(YEAR FROM ae.date_image) = a.year
  AND EXTRACT(MONTH FROM ae.date_image) = a.month
  AND EXTRACT(DAY FROM ae.date_image) = a.day
WHERE devsrno = 9 AND filenote NOT LIKE '%Single%'
LIMIT 10; -- These are B scans because of 'NOT LIKE'

--Generate table with AMD epidemiology data and filepaths to AFs/en face IR from Spectralis
SELECT DISTINCT (a.file_path_coris), e.pat_mrn, a.exdevtype, a.exdatetime, a.year, a.month, a.day, a.exsrno, a.ptsrno, a.ptid, a.devname, a.devdescription, a.devtype, a.devproc, a.dicomaetitle, a.devsrno, a.fileeye, a.filenote, a.filetype, a.tmstamp, a.filedata, ae.*
FROM ehr.ophthalmologypatients e
INNER JOIN axispacs_snowflake.file_paths_and_meta a ON e.pat_mrn = a.ptid
INNER JOIN amd_epidemiology.amddatabaselogitudin_data_imaging_af ae 
  ON CAST(e.pat_mrn as INTEGER) = ae.MRN
  AND EXTRACT(YEAR FROM ae.date_image) = a.year
  AND EXTRACT(MONTH FROM ae.date_image) = a.month
  AND EXTRACT(DAY FROM ae.date_image) = a.day
WHERE a.devsrno = 9 AND a.filenote LIKE '%Single%';-- These are AFs/en face IR because of 'LIKE'




	select * from axispacs_snowflake.file_paths_and_meta f
	inner join amd.raw_mrns_from_csv amd
	on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
	-- Tags Spectralis OCT (Scans) with filenote as "(######) Single" from axispacs_snowflake.file_paths_and_meta as Auto Fluorescenses
	where ferris like'%GA AMD%'and devsrno = 9 and filenote like '%Single%' -- This is AF
	-- where ferris like '%GA AMD%' and devsrno = 9 and filenote not like '%Single%'-- Ths is non AF

-- # of rows that do not contain a number for ptid
SELECT count(ptid)
FROM axispacs_snowflake.file_paths_and_meta 
WHERE ptid !~ '^[0-9]+$';
-- WHERE ptid LIKE '%Generic%';


SELECT COUNT(*)
FROM your_table
WHERE your_column !~ '^[0-9]+$';

SELECT *
FROM amd.amd_patients ap
INNER JOIN axispacs_snowflake.file_paths_and_meta a
-- INNER JOIN amd_epidemiology.amddatabaselogitudin_data_imaging_CFP ae
ON ap.pat_id = a.ptid;
  -- AND CAST(pat_mrn as INTEGER) = ae.mrn
  -- AND EXTRACT(YEAR from ae.date_image) = a.year
  -- AND EXTRACT(MONTH from ae.date_image) = a.month
  -- AND EXTRACT(DAY from ae.date_image) = a.day;

--Generate table with AMD epidemiology data and filepaths to Color Fundus Photos from listed devices
SELECT DISTINCT (a.file_path_coris), e.pat_mrn, a.exdevtype, a.exdatetime, a.year, a.month, a.day, a.exsrno, a.ptsrno, a.ptid, a.devname, a.devdescription, a.devtype, a.devproc, a.dicomaetitle, a.devsrno, a.fileeye, a.filenote, a.filetype, a.tmstamp, a.filedata, ae.*
FROM ehr.ophthalmologypatients e
INNER JOIN axispacs_snowflake.file_paths_and_meta a ON e.pat_mrn = a.ptid
INNER JOIN amd_epidemiology.amddatabaselogitudin_data_imaging_CFP ae 
  ON CAST(e.pat_mrn as INTEGER) = ae.MRN
  AND EXTRACT(YEAR FROM ae.date_image) = a.year
  AND EXTRACT(MONTH FROM ae.date_image) = a.month
  AND EXTRACT(DAY FROM ae.date_image) = a.day
WHERE a.devname in ('NonMyd', 'Photos', 'Nidek', 'Optos', 'Topcon', 'Eidon');