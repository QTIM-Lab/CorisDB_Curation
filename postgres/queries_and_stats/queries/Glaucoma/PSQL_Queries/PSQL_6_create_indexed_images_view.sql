/* We want to make a materialized view for fast viewing but that can be refreshed */


-- Devices
select * from axispacs_snowflake.exams order by exdevtype ASC;
select distinct exdevtype from axispacs_snowflake.exams order by exdevtype ASC;

select distinct devsrno from axispacs_snowflake.devices order by devsrno DESC;
select * from axispacs_snowflake.devices order by devsrno DESC;

-- Galucoma Patients
select pat_mrn from glaucoma.glaucoma_patients limit 10;

select

-- Views

-- Counts
-- count(*)


-- Key Columns
distinct e.exsrno as e_exsrno
-- sf_pat.ptid as sf_pat_ptid, g.pat_mrn as g_pat_mrn, -- join
-- sf_pat.ptsrno as sf_pat_ptsrno, e.ptsrno as e_ptsrno, -- join
-- e.exsrno as e_exsrno, f.exsrno as f_exsrno, -- join
-- e.exdevtype, d.devsrno, -- join
-- f.filepath as f_filepath,
-- f.filename as f_filename,
-- f.filepathnew as f_filepathnew,
-- f.filenamenew as f_filenamenew,
-- e.exdatetime as e_exdatetime,
-- e.tmstamp as e_tmstamp,
-- f.tmstamp as f_tmstamp,
-- d.devtype, d.devname, devdescrition, d.devrender, d.devconfig

-- All
-- ,* -- To see literally all columns (~90)

from axispacs_snowflake.patients sf_pat

right join glaucoma.glaucoma_patients as g -- RIGHT JOIN: Glaucoma only
on sf_pat.ptid = g.pat_mrn

inner join axispacs_snowflake.exams as e
on sf_pat.ptsrno = e.ptsrno -- I believe these are patient serial numbers unique to axispacs; not important other than joining

inner join axispacs_snowflake.files as f
on e.exsrno = f.exsrno -- I believe these are exam serial numbers unique to axispacs; not important other than joining

inner join axispacs_snowflake.devices as d
on e.exdevtype = d.devsrno

where g.pat_mrn is not null and d.devname like '%Nidek%'
) as tmp
order by e_exdatetime asc;
-- limit 10;




-- DROP MATERIALIZED VIEW IF EXISTS glaucoma.glaucoma_images_indexed
-- CREATE MATERIALIZED VIEW glaucoma.glaucoma_images_indexed AS
-- SELECT 


-- REFRESH MATERIALIZED VIEW glaucoma.glaucoma_images_indexed;