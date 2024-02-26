-- CDRS subset

select count(*) 
select * 
from forum_dscan.cdrs -- 333,838
where avgcdr != '0'
order by avgcdr
limit 10000

select avgcdr, count(avgcdr) from forum_dscan.cdrs
group by avgcdr
order by count(avgcdr) desc
limit 10000



select count(distinct (studyinstanceuid) ) from forum_dscan.cdrs  -- 78,245
select count(distinct (studyinstanceuid) ) from forum_dscan.cdrs 

select count(distinct (studyinstanceuid) ) from forum_dscan.cdrs 

select distinct studyinstanceuid, seriesdescription, studytime, avgcdr, laterality, patientmrn
from forum_dscan.cdrs 
order by studyinstanceuid, avgcdr
limit 10000


select count(distinct(patientmrn)) 
from forum_dscan.cdrs -- 24914

select count(*) 
from forum_dscan.cdrs where seriesdescription = 'Glaucoma OU Analysis' -- 138,138

select count(distinct(patientmrn)) 
from forum_dscan.cdrs where seriesdescription = 'Glaucoma OU Analysis' -- 18,517


-- All
select count(*) from forum_dscan.dicom_headers -- 333,838
select count(distinct(patientmrn)) from forum_dscan.dicom_headers -- 24,914

select *
from forum_dscan.dicom_headers
where seriesdescription = 'Optic Disc Cube 200x200'
limit 100;



