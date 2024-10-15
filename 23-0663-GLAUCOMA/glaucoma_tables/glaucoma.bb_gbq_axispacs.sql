
CREATE TEMPORARY TABLE glaucoma_encounters_with_mrn AS
SELECT 
g_encounter.arb_person_id,
g_person.primarymrn as mrn,
g_encounter.arb_encounter_id,
g_encounter."date",
EXTRACT(YEAR from g_encounter."date") as year ,
EXTRACT(MONTH from g_encounter."date") as month,
EXTRACT(DAY from g_encounter."date") as day
FROM glaucoma.bb_gbq_glaucoma_encounter_20240925 as g_encounter
inner join glaucoma.bb_gbq_glaucoma_person_20240925 as g_person
on g_encounter.arb_person_id = g_person.arb_person_id

select * from glaucoma_encounters_with_mrn
order by mrn
limit 1000;


-- General view
select * from axispacs_snowflake.file_paths_and_meta
where 
    ptid ~ '^[0-9]+$' and
    ptid > '7306'
order by cast(ptid as bigint)
limit 100;


-- ISILON:QTIM/23-0663/10_15_2024_finding_glaucoma/Stats/count_of_years_of_data_by_mrn.csv
select
ptid as mrn,
count(distinct year) num_years_of_imaging
from axispacs_snowflake.file_paths_and_meta
where 
    ptid ~ '^[0-9]+$' and
    ptid > '7306'
group by ptid
order by num_years_of_imaging desc--cast(ptid as bigint)
limit 100;


-- Choose a person and explore
select * from axispacs_snowflake.file_paths_and_meta
where 
-- ptid = ''
and file_path_coris like '%.dcm%'
order by year, month, day;