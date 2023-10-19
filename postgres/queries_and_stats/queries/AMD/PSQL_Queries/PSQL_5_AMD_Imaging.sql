select * from axispacs_snowflake.file_paths_and_meta f
inner join amd.raw_mrns_from_csv amd
on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
-- Tags Spectralis OCT (Scans) with filenote as "(######) Single" from axispacs_snowflake.file_paths_and_meta as Auto Fluorescenses
where devsrno = 9 and filenote like '%Single%'
limit 100;

/*

* Auto Fluorescences images nested within Spectralis OCT (Scans) and not it's own device type.
* There is no "Auto Fluorescence" devsrno.

*/