-- CDRS subset

select count(*) 
select * 
from forum_dscan.cdrs -- 
where avgcdr != '0'
order by avgcdr
limit 10000

select avgcdr, count(avgcdr) from forum_dscan.cdrs
group by avgcdr
order by count(avgcdr) desc
limit 10000



select count(distinct (studyinstanceuid) ) from forum_dscan.cdrs  -- 
select count(distinct (studyinstanceuid) ) from forum_dscan.cdrs 

select distinct studyinstanceuid, seriesinstanceuid, sopinstanceuid, patientmrn, laterality, acquisitiondatetime, avgcdr 
from forum_dscan.cdrs
where laterality = 'R' and avgcdr != '0' and avgcdr != '-3.4028230607370965e+38'
order by studyinstanceuid,laterality, avgcdr 
limit 1000

select distinct studyinstanceuid, seriesdescription, studytime, avgcdr, laterality, patientmrn
from forum_dscan.cdrs 
order by studyinstanceuid, avgcdr
limit 10000


select count(distinct(patientmrn)) 
from forum_dscan.cdrs -- 

select count(*) 
from forum_dscan.cdrs where seriesdescription = 'Glaucoma OU Analysis' -- 

select count(distinct(patientmrn)) 
from forum_dscan.cdrs where seriesdescription = 'Glaucoma OU Analysis' -- 


-- All
select count(*) from forum_dscan.dicom_headers -- 
select count(distinct(patientmrn)) from forum_dscan.dicom_headers -- 

select *
from forum_dscan.dicom_headers
where seriesdescription = 'Optic Disc Cube 200x200'
limit 100;



