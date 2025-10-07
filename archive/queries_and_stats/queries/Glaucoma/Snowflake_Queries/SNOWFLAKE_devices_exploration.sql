select distinct exdevtype from axispacs_snowflake.exams order by exdevtype DESC;
select distinct devsrno from axispacs_snowflake.devices order by devsrno DESC;

-- select * from devices where (devdescrition like '%Top%' or devdescrition like '%top%') limit 10;
select * from axispacs_snowflake.devices;

select
e.exsrno, f.exsrno,
d.devsrno, e.exdevtype,
e.exid, e.exdevtype, e.exisstudy,
d.devtype, d.devname, devdescrition, d.devrender, d.devconfig

-- ,*
from axispacs_snowflake.exams as e
inner join axispacs_snowflake.devices as d
on e.exdevtype = d.devsrno

inner join axispacs_snowflake.files as f
on e.exsrno = f.exsrno

limit 10;


select f.filename,*
from exams as e
inner join files as f
on f.exsrno = e.exsrno
where e.exdevtype = 53 and f.filename not like '%.j2k'
limit 5000;