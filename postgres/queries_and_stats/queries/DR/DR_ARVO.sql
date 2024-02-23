SELECT DISTINCT (a.file_path_coris), a.exdevtype, a.exdatetime, a.year, a.month, a.day, a.exsrno, a.ptsrno, a.ptid, a.devname, a.devdescription, a.devtype, a.devproc, a.dicomaetitle, a.devsrno, a.fileeye, a.filenote, a.filetype, a.tmstamp, a.filedata, e.*
FROM ehr.ophthalmologyencountervisit e
INNER JOIN axispacs_snowflake.file_paths_and_meta a ON e.pat_mrn = a.ptid
WHERE a.devname in ('NonMyd', 'Photos', 'Nidek', 'Optos', 'Topcon', 'Eidon') and e.progress_note ilike '%diabetic retinopathy%'
LIMIT 10;