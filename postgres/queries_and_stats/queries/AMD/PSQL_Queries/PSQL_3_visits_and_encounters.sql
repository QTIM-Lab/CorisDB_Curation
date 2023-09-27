/* amd Visits */
DROP TABLE IF EXISTS amd.amd_encountervisit;
CREATE TABLE amd.amd_encountervisit AS
    select
    pat_enc_csn_id, pat_id, pat_mrn, contact_date, progress_note
    from ehr.ophthalmologyencountervisit
    where pat_id in (select pat_id from amd.amd_patients) 
          -- and (progress_note like '%amd%' or progress_note like '%amd%'); -- right now we have a list of mrns so we will just trust that

DROP TABLE IF EXISTS amd.amd_encounters;
CREATE TABLE amd.amd_encounters AS
    select
    e.pat_enc_csn_id,
    e.pat_id,
    e.pat_mrn,
    e.pat_age_at_enc,
    e.contact_date,
    EXTRACT(YEAR from e.contact_date) as year,
    EXTRACT(MONTH from e.contact_date) as month,
    EXTRACT(DAY from e.contact_date) as day,
    e.enc_close_time,
    ev.progress_note
    from ehr.ophthalmologyencounters as e
    inner join amd.amd_encountervisit as ev
    on e.pat_mrn = ev.pat_mrn and e.pat_enc_csn_id = ev.pat_enc_csn_id

select count(*) from amd.amd_encounters; --
select count(distinct pat_enc_csn_id) from amd.amd_encounters; -- 

select count(*) from ehr.ophthalmologyencounters; -- 
select count(distinct pat_enc_csn_id) from ehr.ophthalmologyencounters; -- 
select * from ehr.ophthalmologyencounters order by pat_id, pat_age_at_enc limit 10; -- 


DROP VIEW IF EXISTS amd.last_encounters;
CREATE VIEW amd.last_encounters AS
    select 
    pat_id,
    pat_mrn,
    max(contact_date) as last_contact_date,
    max(pat_age_at_enc) as pat_age_at_enc
    from amd.amd_encounters
    group by pat_id, pat_mrn
    order by pat_id; -- 

/* 09/19/2023 */
-- Spot check with Steve a case from each year. Did I set this up correctly?
-- Want csv with biomarkers and filepaths:
  -- * Biomarkers csv: /projects/coris_db/postgres/queries_and_stats/queries/AMD/Indexed_Images/AMDDatabaseLogitudin_DATA_2023_08_17 for JK.csv
select pat_mrn, count(pat_enc_csn_id) from amd.amd_encounters
GROUP BY pat_mrn

select pat_mrn, count(pat_enc_csn_id) from amd.amd_encountervisit
GROUP BY pat_mrn

select count (pat_mrn) from amd.amd_patients
select count (pat_mrn) from amd.raw_mrns_from_csv

select devname, devsrno, count(distinct file_path_coris) from amd.files
group by devname, devsrno
order by count(distinct file_path_coris) desc