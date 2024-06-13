select year, count(pat_mrn)
from (
    select
    distinct sf_pat.ptid, g.pat_mrn,
    -- sf_ex.ptsrno, sf_pat.ptsrno,
    -- sf_ex.exdatetime,
    -- , * 
    -- DATE_PART('YEAR', sf_ex.exdatetime) AS year,
    -- g.pat_mrn,
    d.devsrno, d.devname
    -- count (*)
    from glaucoma.glaucoma_patients as g -- RIGHT JOIN: Glaucoma only
    left join axispacs_snowflake.patients as sf_pat
    on sf_pat.ptid = g.pat_mrn
    inner join axispacs_snowflake.exams as sf_ex
    on sf_ex.ptsrno = sf_pat.ptsrno
    inner join axispacs_snowflake.devices as d
    on sf_ex.exdevtype = d.devsrno
    -- where g.pat_mrn = ''
    -- group by year, g.pat_mrn, d.devsrno
    -- order by sf_ex.exdatetime asc
    order by year, g.pat_mrn, d.devsrno
    ) as tmp
group by year -- break this out by device id
limit 10;

-- All
select d.devsrno, d.devname, count(exsrno)
from axispacs_snowflake.exams as sf_ex
inner join axispacs_snowflake.devices as d
on sf_ex.exdevtype = d.devsrno
group by d.devsrno, d.devname;

select d.devsrno, d.devname, count(sf_f) 
from axispacs_snowflake.exams as sf_ex
inner join axispacs_snowflake.devices as d
on sf_ex.exdevtype = d.devsrno
inner join axispacs_snowflake.files as sf_f
on sf_ex.exsrno = sf_f.exsrno
group by d.devsrno, d.devname;


-- Glaucoma
select d.devsrno, d.devname, count(exsrno)
    from glaucoma.glaucoma_patients as g -- RIGHT JOIN: Glaucoma only
    left join axispacs_snowflake.patients as sf_pat
    on sf_pat.ptid = g.pat_mrn
    inner join axispacs_snowflake.exams as sf_ex
    on sf_ex.ptsrno = sf_pat.ptsrno
    inner join axispacs_snowflake.devices as d
    on sf_ex.exdevtype = d.devsrno
group by d.devsrno, d.devname;


select d.devsrno, d.devname, count(sf_f.exsrno)
    from glaucoma.glaucoma_patients as g -- RIGHT JOIN: Glaucoma only
    left join axispacs_snowflake.patients as sf_pat
    on sf_pat.ptid = g.pat_mrn
    inner join axispacs_snowflake.exams as sf_ex
    on sf_ex.ptsrno = sf_pat.ptsrno
    inner join axispacs_snowflake.devices as d
    on sf_ex.exdevtype = d.devsrno
    inner join axispacs_snowflake.files as sf_f
    on sf_ex.exsrno = sf_f.exsrno
group by d.devsrno, d.devname;



select * from axispacs_snowflake.devices

--Fundus:
--4
--8
--21
--29
--37
--42
--50
--53
--54
-- Are these Fundus?:
--19
--20


-- Should be same as other queries we are asking for. Make sure...
OCT:
Reports:
!!!Add exam counts by device to devices table;


select exdevtype, count(*) from axispacs_snowflake.exams
group by exdevtype





--
SELECT count(*)
from axispacs_snowflake.exams
where exdatetime < '2000-01-01 00:00:00'
order by exdatetime asc limit 1000;

axispacs_snowflake.patients:
  - ptid:pat_mrn
  - ptsrno: links axis pacs together


-- 08_10_2023
select count(*) from axispacs_snowflake.exams
where exdevtype = 4 and DATE_PART('YEAR', exdatetime) = 2019 -- 
limit 100;

select 
	distinct concept_name
-- concept_id,
-- 	pat_mrn,
-- 	pat_id,
-- 	pat_enc_csn_id,
-- 	cur_value_datetime,
-- 	element_value_id,
-- 	line,
-- 	smrtdta_elem_value,
-- 	contact_date
  ,count(*)
 from ophthalmologyencounterexam 
 group by concept_name
	