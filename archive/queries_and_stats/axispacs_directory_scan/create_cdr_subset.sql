select * from axispacs_dscan.dicom_headers 
where avgcdr != 'Tag not found' -- 0
limit 10