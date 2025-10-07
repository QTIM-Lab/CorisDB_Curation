select distinct devname from axispacs_snowflake.file_paths_and_meta
where ptid = '' --and file_path_coris not like '%.dcm'
-- where ptsrno = ''


/* Manual */
select * from axispacs_snowflake.patients where ptid = ''


select * from axispacs_snowflake.files as f
-- inner join axispacs_snowflake.exams as e
-- on f.exsrno = e.exsrno
-- inner join axispacs_snowflake.devices as d
-- on d.devsrno = e.exdevtype
where f.exsrno in (select distinct exsrno from axispacs_snowflake.exams where ptsrno = '')
    --   and filenamenew like '%.dcm'
/* Manual */



select
file_path_coris, devname, exdatetime
-- *
 from axispacs_snowflake.file_paths_and_meta
-- where ptid = '' and devname = 'HFA3 (x3)'
-- where ptid = '' and devname = 'HVF (x2) Cherry creek-Main'
where ptid = '' --and exdatetime > '2015-05-02 00:00:00' --and devname = 'Cirrus OCT'
order by devname, exdatetime
--and file_path_coris not like '%.dcm'

ex=
mrn=
filename=ax.................j2k
/data/PACS/VisupacImages/2......................j2k