SELECT table_name, column_name, data_type FROM information_schema.columns --limit 100;
WHERE table_name like '%FILES%'
limit 5;

select * FROM files limit 100;
select * FROM files
where filepath is not null and filenamenew is not null
limit 100;

SELECT
filenamenew,
filepathnew,
filepath,
filetype,
dicomseriesdescription,
dicommodality,
dicomdocumenttitle,
dicomimagetype,
* 
FROM files
where filepathnew is not null
limit 5;

select DISTINCT(file_extension)
from (
    SELECT
    LENGTH(filenamenew) - POSITION(REVERSE('.') IN REVERSE(filenamenew)) + 1 AS last_occurrence,
    SUBSTRING(filenamenew, last_occurrence + 1, LEN(filenamenew)) as file_extension
    FROM files
) as sub_query -- ['dcm', 'j2k']


-- select * from files where FILEUP is not null limit 1; -- ALL NULL
-- select * from files where FILEPATHNEW is not null limit 1;
-- select * from files where STORESRNO is not null limit 1;
-- select * from files where FILEPATH is not null limit 1;
-- select * from files where FILETAG is not null limit 1;
-- select * from files where DICOMDOCUMENTTITLE is not null limit 1;
-- select * from files where DICOMACQUISITIONDATETIME is not null limit 1;
-- select * from files where DICOMSERIESDATETIME is not null limit 1;
-- select * from files where FILENOTE is not null limit 1;
-- select * from files where TMSTAMP is not null limit 1;
-- select * from files where DICOMSERIESNUMBER is not null limit 1;
-- select * from files where USRSRNO is not null limit 1;
-- select * from files where FILEEYE is not null limit 1;
-- select * from files where DICOMTAG is not null limit 1; -- ALL NULL
-- select * from files where FILENAMENEW is not null limit 1;
-- select * from files where FILEINDEX is not null limit 1;
-- select * from files where DICOMSERIESDESCRIPTION is not null limit 1;
-- select * from files where DICOMMODALITY is not null limit 1;
-- select * from files where FILENAME is not null limit 1;
-- select * from files where FILETMSTMP is not null limit 1;
-- select * from files where DICOMSERIESUID is not null limit 1;
-- select * from files where DICOMREFERENCESOPINSTANCEUID is not null limit 1; -- ALL NULL
-- select * from files where DICOMIMAGETYPE is not null limit 1;
-- select * from files where DICOMSTUDYID is not null limit 1; -- ALL NULL
-- select * from files where FILETYPE is not null limit 1;
-- select * from files where EXSRNO is not null limit 1;
-- select * from files where DICOMSTUDYUID is not null limit 1; -- ALL NULL
-- select * from files where FILEVALID is not null limit 1; -- ALL NULL
-- select * from files where DICOMSOPINSTANCEUID is not null limit 1;
-- select * from files where DICOMTAGINDEX is not null limit 1; -- ALL NULL
-- select * from files where FILERENDER is not null limit 1;
-- select * from files where FILEDATA is not null limit 1;
-- select * from files where FILEUPDTTM is not null limit 1; -- ALL NULL
-- select * from files where FILESRNO is not null limit 1;
