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


select * from forum_dscan.cdrs 
where seriesdescription = 'Glaucoma OU Analysis' and avgcdr != '0' and verticalcd != '0' and rimarea_mm_squared != '0' and opticdiskarea_mm_squared != '0' and averagernflthickness_micrometers != '0' 
limit 10;

-- Creating CSV to merge with Scott's CFP CSV that include OCT Glaucoma OU Analysis Data from the reports
select 
    filenamepath,
    patientmrn,
    acquisitiondatetime,
    sopclassuid,
    modality,
    laterality,
    seriesdescription,
    studydate,
    studytime,
    doctype_non_standard_tag,
    averagernflthickness_micrometers,
    opticcupvolume_mm_squared,
    opticdiskarea_mm_squared,
    rimarea_mm_squared,
    avgcdr,
    verticalcd,
    extract (year from cast(studydate as date)) as year,
    extract (month from cast(studydate as date)) as month,
    extract(day from cast(studydate as date)) as day
from
    forum_dscan.CDRS
where
    seriesdescription = 'Glaucoma OU Analysis'
    and avgcdr != '0'
    and verticalcd != '0'
    and rimarea_mm_squared!= '0'
    and opticdiskarea_mm_squared!= '0'
    and averagernflthickness_micrometers != '0'
    and patientmrn not like '%CZMI%';
