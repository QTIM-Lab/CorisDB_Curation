-- select * from axispacs_snowflake.devices;

        -- inner join axispacs_snowflake.files as f 
        -- on e.exsrno = sf_f.exsrno 


/** Can't use temp\views to make material view **/
/** So we build the views first to test and then copy into code below **/

/* Exam count by device for all axispacs patients */ 
create temporary table exam_counts_by_device_all_patients as (
    -- Source Exam Data -- All
    select
    d.devsrno, count(*) as exam_count_all_patients
    from axispacs_snowflake.patients as sf_pat
        inner join axispacs_snowflake.exams as e
        on e.ptsrno = sf_pat.ptsrno
        inner join axispacs_snowflake.devices as d
        on e.exdevtype = d.devsrno
    group by d.devsrno
    order by d.devsrno
);

-- Test all view
select * from exam_counts_by_device_all_patients;

/* Exam count by device for glaucoma axispacs patients */
create temporary table exam_counts_by_device_glaucoma_patients as (
    -- Source Exam Data -- Glaucoma 
    select
    d.devsrno, count(*) as exam_count_glaucoma
    from glaucoma.glaucoma_patients as g -- RIGHT JOIN: Glaucoma only 
        left join axispacs_snowflake.patients as sf_pat
        on sf_pat.ptid = g.pat_mrn
        inner join axispacs_snowflake.exams as e
        on e.ptsrno = sf_pat.ptsrno
        inner join axispacs_snowflake.devices as d
        on e.exdevtype = d.devsrno
    group by d.devsrno
    order by d.devsrno
);

-- Test glaucoma view 
select * from exam_counts_by_device_glaucoma_patients; 

/** Create materialized view of devices with counts added on **/
DROP MATERIALIZED VIEW IF EXISTS axispacs_snowflake.devices_counts;
CREATE MATERIALIZED VIEW axispacs_snowflake.devices_counts AS
    select 
    d.devsrno,
    d.devtype,
    d.devver,
    d.devname,
    d.devproc,
    d.devdescription,
    d.devrender,
    d.devicon,
    d.usrsrno,
    d.devtimestamp,
    d.tmstamp,
    d.devconfig,
    d.dicomaetitle,
    d.dicomreports,
    d.devguid,
    eca.exam_count_all_patients,
    ecg.exam_count_glaucoma,
    fca.file_count_all_patients,
    fcg.file_count_glaucoma
    from axispacs_snowflake.devices as d
    
    inner join 
    (
    -- Source Exam Data -- All
    select
    d.devsrno, count(*) as exam_count_all_patients
    from axispacs_snowflake.patients as sf_pat
        inner join axispacs_snowflake.exams as e
        on e.ptsrno = sf_pat.ptsrno
        inner join axispacs_snowflake.devices as d
        on e.exdevtype = d.devsrno
    group by d.devsrno
    order by d.devsrno
    ) as eca
    on d.devsrno = eca.devsrno

    inner join     
    (
    -- Source Exam Data -- Glaucoma 
    select
    d.devsrno, count(*) as exam_count_glaucoma
    from glaucoma.glaucoma_patients as g -- RIGHT JOIN: Glaucoma only 
        left join axispacs_snowflake.patients as sf_pat
        on sf_pat.ptid = g.pat_mrn
        inner join axispacs_snowflake.exams as e
        on e.ptsrno = sf_pat.ptsrno
        inner join axispacs_snowflake.devices as d
        on e.exdevtype = d.devsrno
    group by d.devsrno
    order by d.devsrno
    ) as ecg
    on d.devsrno = ecg.devsrno
    
    inner join 
    (
    -- Source File Data -- All
    select
    d.devsrno, count(*) as file_count_all_patients
    from axispacs_snowflake.patients as sf_pat
        inner join axispacs_snowflake.exams as e
        on e.ptsrno = sf_pat.ptsrno
        inner join axispacs_snowflake.devices as d
        on e.exdevtype = d.devsrno
        inner join axispacs_snowflake.files as f
        on e.exsrno = f.exsrno
    group by d.devsrno
    order by d.devsrno
    ) as fca
    on d.devsrno = fca.devsrno
    
    inner join 
    (
    -- Source File Data -- Glaucoma
    select
    d.devsrno, count(*) as file_count_glaucoma
    from glaucoma.glaucoma_patients as g -- RIGHT JOIN: Glaucoma only 
        left join axispacs_snowflake.patients as sf_pat
        on sf_pat.ptid = g.pat_mrn
        inner join axispacs_snowflake.exams as e
        on e.ptsrno = sf_pat.ptsrno
        inner join axispacs_snowflake.devices as d
        on e.exdevtype = d.devsrno
        inner join axispacs_snowflake.files as f
        on e.exsrno = f.exsrno
    group by d.devsrno
    order by d.devsrno
    ) as fcg
    on d.devsrno = fca.devsrno
    ;




REFRESH MATERIALIZED VIEW axispacs_snowflake.devices_counts;
