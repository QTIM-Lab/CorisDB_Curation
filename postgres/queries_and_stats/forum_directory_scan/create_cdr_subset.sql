CREATE TABLE forum_dscan.cdrs as 
select * from (
    select * from forum_dscan.dicom_headers
    where avgcdr != 'Tag not found'
) as cdrs

-- select * from forum_dscan.cdrs limit 10;