CREATE EXTENSION tablefunc; -- adds (installs) crosstab func and other variants to "Functions"

-- Example Pivot Table
SELECT *
FROM crosstab(
    'SELECT date, product, SUM(quantity)
      FROM sales
      GROUP BY date, product
      ORDER BY date, product',
    'SELECT DISTINCT product FROM sales ORDER BY product'
) AS ct (date text, "Product A" int, "Product B" int, "Product C" int);

--------------- All --------------

-- Source Exam Data -- All
select
DATE_PART('YEAR', sf_ex.exdatetime) AS year, d.devsrno, count(*)
from axispacs_snowflake.patients as sf_pat
    inner join axispacs_snowflake.exams as sf_ex
    on sf_ex.ptsrno = sf_pat.ptsrno
    inner join axispacs_snowflake.devices as d
    on sf_ex.exdevtype = d.devsrno
group by year, d.devsrno
order by year, d.devsrno
limit 100;


-- Exam counts by year and across device
SELECT *
FROM crosstab('select
               DATE_PART(''YEAR'', sf_ex.exdatetime) AS year, ''device_'' || d.devsrno, count(*)
               from axispacs_snowflake.patients as sf_pat
                   inner join axispacs_snowflake.exams as sf_ex
                   on sf_ex.ptsrno = sf_pat.ptsrno
                   inner join axispacs_snowflake.devices as d
                   on sf_ex.exdevtype = d.devsrno
               group by year, ''device_'' || d.devsrno
               order by year, ''device_'' || d.devsrno',
    -- 'SELECT DISTINCT ''device_'' || devsrno FROM axispacs_snowflake.devices ORDER BY ''device_'' || devsrno limit 2'
    'SELECT DISTINCT ''device_'' || devsrno FROM axispacs_snowflake.devices ORDER BY ''device_'' || devsrno'
-- ) AS ct (year float, "device_1" int, "device_2" int);
) AS ct (year float, "device_1" int, "device_2" int, "device_4" int, "device_5" int, "device_6" int, "device_7" int, "device_8" int, "device_9" int, "device_10" int, "device_12" int, "device_13" int, "device_14" int, "device_15" int, "device_16" int, "device_17" int, "device_18" int, "device_19" int, "device_20" int, "device_21" int, "device_22" int, "device_23" int, "device_24" int, "device_25" int, "device_26" int, "device_27" int, "device_28" int, "device_29" int, "device_30" int, "device_31" int, "device_32" int, "device_33" int, "device_34" int, "device_35" int, "device_36" int, "device_37" int, "device_38" int, "device_39" int, "device_40" int, "device_41" int, "device_42" int, "device_43" int, "device_44" int, "device_45" int, "device_46" int, "device_47" int, "device_48" int, "device_49" int, "device_50" int, "device_51" int, "device_52" int, "device_53" int, "device_54" int, "device_55" int, "device_58" int, "device_59" int, "device_60" int, "device_61" int, "device_62" int, "device_63" int, "device_64" int, "device_65" int, "device_66" int, "device_67" int, "device_68" int, "device_69" int, "device_70" int, "device_71" int, "device_72" int, "device_73" int, "device_74" int, "device_75" int, "device_76" int, "device_77" int, "device_78" int, "device_79" int, "device_80" int, "device_81" int);

-- Build columns
SELECT '"device_' || devsrno || '"' || ' int,'
FROM axispacs_snowflake.devices ORDER BY devsrno


-- Source File Data -- All
select
DATE_PART('YEAR', sf_ex.exdatetime) AS year, 'device_' || sf_d.devsrno, count(*)
from axispacs_snowflake.patients as sf_pat
    inner join axispacs_snowflake.exams as sf_ex
    on sf_ex.ptsrno = sf_pat.ptsrno
    inner join axispacs_snowflake.devices as sf_d
    on sf_ex.exdevtype = sf_d.devsrno
    inner join axispacs_snowflake.files as sf_f
    on sf_ex.exsrno = sf_f.exsrno
group by year, 'device_' || sf_d.devsrno
order by year, 'device_' || sf_d.devsrno
limit 100;


SELECT *
FROM crosstab('select
               DATE_PART(''YEAR'', sf_ex.exdatetime) AS year, ''device_'' || sf_d.devsrno, count(*)
               from axispacs_snowflake.patients as sf_pat
                   inner join axispacs_snowflake.exams as sf_ex
                   on sf_ex.ptsrno = sf_pat.ptsrno
                   inner join axispacs_snowflake.devices as sf_d
                   on sf_ex.exdevtype = sf_d.devsrno
                   inner join axispacs_snowflake.files as sf_f
                   on sf_ex.exsrno = sf_f.exsrno
               group by year, ''device_'' || sf_d.devsrno
               order by year, ''device_'' || sf_d.devsrno',
    -- 'SELECT DISTINCT ''device_'' || devsrno FROM axispacs_snowflake.devices ORDER BY ''device_'' || devsrno limit 2'
    'SELECT DISTINCT ''device_'' || devsrno FROM axispacs_snowflake.devices ORDER BY ''device_'' || devsrno'
-- ) AS ct (year float, "device_1" int, "device_2" int);
) AS ct (year float, "device_1" int, "device_2" int, "device_4" int, "device_5" int, "device_6" int, "device_7" int, "device_8" int, "device_9" int, "device_10" int, "device_12" int, "device_13" int, "device_14" int, "device_15" int, "device_16" int, "device_17" int, "device_18" int, "device_19" int, "device_20" int, "device_21" int, "device_22" int, "device_23" int, "device_24" int, "device_25" int, "device_26" int, "device_27" int, "device_28" int, "device_29" int, "device_30" int, "device_31" int, "device_32" int, "device_33" int, "device_34" int, "device_35" int, "device_36" int, "device_37" int, "device_38" int, "device_39" int, "device_40" int, "device_41" int, "device_42" int, "device_43" int, "device_44" int, "device_45" int, "device_46" int, "device_47" int, "device_48" int, "device_49" int, "device_50" int, "device_51" int, "device_52" int, "device_53" int, "device_54" int, "device_55" int, "device_58" int, "device_59" int, "device_60" int, "device_61" int, "device_62" int, "device_63" int, "device_64" int, "device_65" int, "device_66" int, "device_67" int, "device_68" int, "device_69" int, "device_70" int, "device_71" int, "device_72" int, "device_73" int, "device_74" int, "device_75" int, "device_76" int, "device_77" int, "device_78" int, "device_79" int, "device_80" int, "device_81" int);

-- Build columns
SELECT '"device_' || devsrno || '"' || ' int,'
FROM axispacs_snowflake.devices ORDER BY devsrno




--------------- Glaucoma --------------

-- Source Exam Data -- Glaucoma
select
DATE_PART('YEAR', sf_ex.exdatetime) AS year, d.devsrno, count(*)
from glaucoma.glaucoma_patients as g -- RIGHT JOIN: Glaucoma only
    left join axispacs_snowflake.patients as sf_pat
    on sf_pat.ptid = g.pat_mrn
    inner join axispacs_snowflake.exams as sf_ex
    on sf_ex.ptsrno = sf_pat.ptsrno
    inner join axispacs_snowflake.devices as d
    on sf_ex.exdevtype = d.devsrno
group by year, d.devsrno
order by year, d.devsrno
limit 100;


-- Exam counts by year and across device
SELECT *
FROM crosstab('select
               DATE_PART(''YEAR'', sf_ex.exdatetime) AS year, ''device_'' || d.devsrno, count(*)
               from glaucoma.glaucoma_patients as g -- RIGHT JOIN: Glaucoma only
                   left join axispacs_snowflake.patients as sf_pat
                   on sf_pat.ptid = g.pat_mrn
                   inner join axispacs_snowflake.exams as sf_ex
                   on sf_ex.ptsrno = sf_pat.ptsrno
                   inner join axispacs_snowflake.devices as d
                   on sf_ex.exdevtype = d.devsrno
               group by year, ''device_'' || d.devsrno
               order by year, ''device_'' || d.devsrno',
    -- 'SELECT DISTINCT ''device_'' || devsrno FROM axispacs_snowflake.devices ORDER BY ''device_'' || devsrno limit 2'
    'SELECT DISTINCT ''device_'' || devsrno FROM axispacs_snowflake.devices ORDER BY ''device_'' || devsrno'
-- ) AS ct (year float, "device_1" int, "device_2" int);
) AS ct (year float, "device_1" int, "device_2" int, "device_4" int, "device_5" int, "device_6" int, "device_7" int, "device_8" int, "device_9" int, "device_10" int, "device_12" int, "device_13" int, "device_14" int, "device_15" int, "device_16" int, "device_17" int, "device_18" int, "device_19" int, "device_20" int, "device_21" int, "device_22" int, "device_23" int, "device_24" int, "device_25" int, "device_26" int, "device_27" int, "device_28" int, "device_29" int, "device_30" int, "device_31" int, "device_32" int, "device_33" int, "device_34" int, "device_35" int, "device_36" int, "device_37" int, "device_38" int, "device_39" int, "device_40" int, "device_41" int, "device_42" int, "device_43" int, "device_44" int, "device_45" int, "device_46" int, "device_47" int, "device_48" int, "device_49" int, "device_50" int, "device_51" int, "device_52" int, "device_53" int, "device_54" int, "device_55" int, "device_58" int, "device_59" int, "device_60" int, "device_61" int, "device_62" int, "device_63" int, "device_64" int, "device_65" int, "device_66" int, "device_67" int, "device_68" int, "device_69" int, "device_70" int, "device_71" int, "device_72" int, "device_73" int, "device_74" int, "device_75" int, "device_76" int, "device_77" int, "device_78" int, "device_79" int, "device_80" int, "device_81" int);

-- Build columns
SELECT '"device_' || devsrno || '"' || ' int,'
FROM axispacs_snowflake.devices ORDER BY devsrno


-- Source File Data -- Glaucoma
select
DATE_PART('YEAR', sf_ex.exdatetime) AS year, 'device_' || sf_d.devsrno, count(*)
from glaucoma.glaucoma_patients as g -- RIGHT JOIN: Glaucoma only
    left join axispacs_snowflake.patients as sf_pat
    on sf_pat.ptid = g.pat_mrn
    inner join axispacs_snowflake.exams as sf_ex
    on sf_ex.ptsrno = sf_pat.ptsrno
    inner join axispacs_snowflake.devices as sf_d
    on sf_ex.exdevtype = sf_d.devsrno
    inner join axispacs_snowflake.files as sf_f
    on sf_ex.exsrno = sf_f.exsrno
group by year, 'device_' || sf_d.devsrno
order by year, 'device_' || sf_d.devsrno
limit 100;


SELECT *
FROM crosstab('select
               DATE_PART(''YEAR'', sf_ex.exdatetime) AS year, ''device_'' || sf_d.devsrno, count(*)
               from glaucoma.glaucoma_patients as g -- RIGHT JOIN: Glaucoma only
                   left join axispacs_snowflake.patients as sf_pat
                   on sf_pat.ptid = g.pat_mrn
                   inner join axispacs_snowflake.exams as sf_ex
                   on sf_ex.ptsrno = sf_pat.ptsrno
                   inner join axispacs_snowflake.devices as sf_d
                   on sf_ex.exdevtype = sf_d.devsrno
                   inner join axispacs_snowflake.files as sf_f
                   on sf_ex.exsrno = sf_f.exsrno
               group by year, ''device_'' || sf_d.devsrno
               order by year, ''device_'' || sf_d.devsrno',
    -- 'SELECT DISTINCT ''device_'' || devsrno FROM axispacs_snowflake.devices ORDER BY ''device_'' || devsrno limit 2'
    'SELECT DISTINCT ''device_'' || devsrno FROM axispacs_snowflake.devices ORDER BY ''device_'' || devsrno'
-- ) AS ct (year float, "device_1" int, "device_2" int);
) AS ct (year float, "device_1" int, "device_2" int, "device_4" int, "device_5" int, "device_6" int, "device_7" int, "device_8" int, "device_9" int, "device_10" int, "device_12" int, "device_13" int, "device_14" int, "device_15" int, "device_16" int, "device_17" int, "device_18" int, "device_19" int, "device_20" int, "device_21" int, "device_22" int, "device_23" int, "device_24" int, "device_25" int, "device_26" int, "device_27" int, "device_28" int, "device_29" int, "device_30" int, "device_31" int, "device_32" int, "device_33" int, "device_34" int, "device_35" int, "device_36" int, "device_37" int, "device_38" int, "device_39" int, "device_40" int, "device_41" int, "device_42" int, "device_43" int, "device_44" int, "device_45" int, "device_46" int, "device_47" int, "device_48" int, "device_49" int, "device_50" int, "device_51" int, "device_52" int, "device_53" int, "device_54" int, "device_55" int, "device_58" int, "device_59" int, "device_60" int, "device_61" int, "device_62" int, "device_63" int, "device_64" int, "device_65" int, "device_66" int, "device_67" int, "device_68" int, "device_69" int, "device_70" int, "device_71" int, "device_72" int, "device_73" int, "device_74" int, "device_75" int, "device_76" int, "device_77" int, "device_78" int, "device_79" int, "device_80" int, "device_81" int);

-- Build columns
SELECT '"device_' || devsrno || '"' || ' int,'
FROM axispacs_snowflake.devices ORDER BY devsrno


