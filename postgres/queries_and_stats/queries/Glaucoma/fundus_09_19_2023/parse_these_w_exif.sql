-- Send csv or json with exif data for these 12.

--bearceb@soms-slce-oph1:/projects/coris_db$ ls -la /data/PACS/VisupacImages/2......*.j2k
-rwxr-xr-x 1 svc-somd-ophtransfer svc-somd-ophtransfer 6264226 Sep 18  2019 /data/PACS/VisupacImages/26...............................j2k
-rwxr-xr-x 1 svc-somd-ophtransfer svc-somd-ophtransfer 6266955 Sep 18  2019 /data/PACS/VisupacImages/26...............................j2k
-rwxr-xr-x 1 svc-somd-ophtransfer svc-somd-ophtransfer 6238212 Sep 18  2019 /data/PACS/VisupacImages/26...............................j2k
-rwxr-xr-x 1 svc-somd-ophtransfer svc-somd-ophtransfer 6289834 Sep 18  2019 /data/PACS/VisupacImages/26...............................j2k
-rwxr-xr-x 1 svc-somd-ophtransfer svc-somd-ophtransfer 6267655 Sep 18  2019 /data/PACS/VisupacImages/26...............................j2k
-rwxr-xr-x 1 svc-somd-ophtransfer svc-somd-ophtransfer 6270376 Sep 18  2019 /data/PACS/VisupacImages/26...............................j2k
-rwxr-xr-x 1 svc-somd-ophtransfer svc-somd-ophtransfer 6241630 Sep 18  2019 /data/PACS/VisupacImages/26...............................j2k
-rwxr-xr-x 1 svc-somd-ophtransfer svc-somd-ophtransfer 6293271 Sep 18  2019 /data/PACS/VisupacImages/26...............................j2k
-rwxr-xr-x 1 svc-somd-ophtransfer svc-somd-ophtransfer 5351193 Feb 22  2021 /data/PACS/VisupacImages/26...............................j2k
-rwxr-xr-x 1 svc-somd-ophtransfer svc-somd-ophtransfer 5269735 Feb 22  2021 /data/PACS/VisupacImages/26...............................j2k
-rwxr-xr-x 1 svc-somd-ophtransfer svc-somd-ophtransfer 5322940 Feb 22  2021 /data/PACS/VisupacImages/26...............................j2k
-rwxr-xr-x 1 svc-somd-ophtransfer svc-somd-ophtransfer 5305225 Feb 22  2021 /data/PACS/VisupacImages/26...............................j2k


select * from axispacs_snowflake.file_paths_and_meta
where devname = 'Non'
order by exdatetime limit 10000


select * from axispacs_snowflake.file_paths_and_meta --limit 10; 
where exdatetime = '2019-09-18 00:00:00' and ptid = ''
-- where exdatetime >= '2019-09-18 00:00:00' and ptid = ''
order by exdatetime limit 10000



select * from axispacs_snowflake.files where filenamenew like '%axis0...............0%'

select * from axispacs_snowflake.exams 
where exdatetime >= '2019-09-18 00:00:00'
order by exdatetime limit 10000

select 
*
from axispacs_dscan.dicom_headers
where patientmrn = '' limit 1000


select 
*
from axispacs_dscan.dicom_headers
-- where filenamepath like '%2.............7%' 
where patientmrn = '' --and acquisitiondatetime like '%2019%'
limit 1000

axis01_26.....................

2019
09 - 18

select 
*
from forum_dscan.dicom_headers
-- where patientmrn = '' and acquisitiondatetime like '%2019%'
where filenamepath like '%2019/9%' and patientmrn = ''
limit 1000
