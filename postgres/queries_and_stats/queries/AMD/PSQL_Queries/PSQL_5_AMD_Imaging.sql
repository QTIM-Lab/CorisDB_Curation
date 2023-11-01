/* 10/19/2023 */

-- Breakdown of Epidemiology Cohort by 'Ferris Classification (Beckman)'
SELECT ferris, COUNT(*) AS Ferris_Classification
FROM amd.raw_mrns_from_csv	
GROUP BY ferris
ORDER BY Ferris_Classification DESC;


-- So how many unique patients have CFP, OCT, AF etc

/*

* Auto Fluorescences images nested within Spectralis OCT (Scans) and not it's own device type.
* There is no "Auto Fluorescence" devsrno.

*/

select devtype_AF, count(distinct ptid) from (
	select 'AF' as devtype_AF,* from axispacs_snowflake.file_paths_and_meta f
	inner join amd.raw_mrns_from_csv amd
	on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
	-- Tags Spectralis OCT (Scans) with filenote as "(######) Single" from axispacs_snowflake.file_paths_and_meta as Auto Fluorescenses
	where ferris like'%GA AMD%'and devsrno = 9 and filenote like '%Single%' -- This is AF
	-- where ferris like '%GA AMD%' and devsrno = 9 and filenote not like '%Single%'-- Ths is non AF
) as AF
group by devtype_AF
limit 100;

/*

* CFP (Fundus) images 
* There is no "CFP (Fundus)" devsrno.

*/

-- select distinct pat_mrn from amd.raw_mrns_from_csv

select f.devname, count(distinct f.ptid) from axispacs_snowflake.file_paths_and_meta f
inner join amd.raw_mrns_from_csv amd
on f.ptid = CAST(amd.pat_mrn as VARCHAR)
where ferris like '%GA AMD%' and f.devname in ('NonMyd', 'Photos', 'Nidek', 'Optos', 'Topcon', 'Eidon')
group by f.devname
limit 10;

select count(distinct amd.pat_mrn) from amd.raw_mrns_from_csv amd
where ferris like '%GA AMD%';


	select * from axispacs_snowflake.file_paths_and_meta f
	inner join amd.raw_mrns_from_csv amd
	on f.ptid = CAST(amd.pat_mrn as VARCHAR) -- AMD Patients only
	-- Tags Spectralis OCT (Scans) with filenote as "(######) Single" from axispacs_snowflake.file_paths_and_meta as Auto Fluorescenses
	where ferris like'%GA AMD%'and devsrno = 9 and filenote like '%Single%' -- This is AF
	-- where ferris like '%GA AMD%' and devsrno = 9 and filenote not like '%Single%'-- Ths is non AF

select * from axispacs_snowflake.file_paths_and_meta f
inner join amd.raw_mrns_from_csv amd
on f.ptid = CAST(amd.pat_mrn as VARCHAR)
where ferris like '%GA AMD%' and amd.can_use = 1 and f.devname in ('Eidon')
order by pat_mrn
limit 1000;

select * from axispacs_snowflake.file_paths_and_meta f
inner join amd.raw_mrns_from_csv amd
on f.ptid = CAST(amd.pat_mrn as VARCHAR)
where ferris like '%GA AMD%' and amd.can_use = 1 and f.devname in ('Topcon')
order by pat_mrn, exsrno
limit 200;



