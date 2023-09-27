-- Codes: https://www.icd10data.com/

/* MRNs from csv */
create table from amd.raw_mrns_from_csv
CREATE TABLE IF NOT EXISTS amd.raw_mrns_from_csv (
    pat_mrn VARCHAR(100)
)

\copy amd.raw_mrns_from_csv FROM '/projects/coris_db/postgres/queries_and_stats/queries/AMD/Indexed_Images/09_14_2023_mrn_to_reports_and_images/AMDDatabaseLogitudin_DATA_2023_08_17 MRNs.csv' DELIMITERS ',' NULL AS 'NULL' CSV QUOTE '''' HEADER;

-- AMD MRNs not in ehr
select pat_id, pat_mrn from ehr.ophthalmologypatients
where pat_mrn not in (select pat_mrn from amd.raw_mrns_from_csv)


-- AMD MRN duplicates
select pat_mrn, count(pat_mrn) from amd.raw_mrns_from_csv
group by pat_mrn
having count(pat_mrn) > 1
order by pat_mrn

-- AMD MRNs in ehr
DROP TABLE IF EXISTS amd.amd_patients;
CREATE TABLE amd.amd_patients AS
    select pat_id, pat_mrn
    from ehr.ophthalmologypatients
    where pat_mrn in (select pat_mrn from amd.raw_mrns_from_csv)




/* Quick Exploration for Steve*/
-- select distinct dx_id , dx_name, code, code_type
-- from ehr.ophthalmologydiagnosesdm
-- where code like '%H40%' -- H40 is glaucoma...need amd
-- /* Quick Exploration for Steve*/

-- DROP VIEW IF EXISTS amd.amd_diagnosis_dx_ids;
-- CREATE VIEW amd.amd_diagnosis_dx_ids AS
--     select distinct dx_id
--     -- select distinct dx_id , dx_name, code, code_type
--     from ehr.ophthalmologydiagnosesdm
--     where dx_name like '%amd%'
--     -- where dx_name like '%amd%' and (code like '%H40.11%' or code like '%365.11%')
--     order by dx_id; -- 1,579
-- -- select count(*)
-- -- from ehr.ophthalmologyencounterdiagnoses -- 
-- -- where dx_id in (select dx_id from amd.amd_diagnosis_dx_ids);
-- -- select dm_codes.dx_id, dm_codes.dx_name, dm_codes.code, dm_codes.code_type
-- -- from ehr.ophthalmologydiagnosesdm as dm_codes
-- -- right join amd.amd_diagnosis_dx_ids as amd_dx_ids
-- -- on dm_codes.dx_id = amd_dx_ids.dx_id
-- -- order by dm_codes.dx_id

-- DROP TABLE IF EXISTS amd.diagnosis_and_patient;
-- CREATE TABLE amd.diagnosis_and_patient AS
--     select
--     distinct
--     encounter_diagnoses.dx_id as dx_id,
--     pat_id,
--     pat_mrn
--     --count(pat_id) as pat_id,
--     -- count(distinct pat_id) as distinct_pat_id_counts
--     from ehr.ophthalmologyencounterdiagnoses as encounter_diagnoses
--     right join amd.amd_diagnosis_dx_ids as amd_dx_ids
--     on encounter_diagnoses.dx_id = amd_dx_ids.dx_id
--     where encounter_diagnoses.dx_id is not null
--     order by pat_id -- 
-- ;
-- select dx_id, count(pat_id) as distinct_pat_id_counts from amd.diagnosis_and_patient
-- group by dx_id -- 
-- order by dx_id
-- ;
-- select distinct pat_id, pat_mrn
--     from ehr.ophthalmologyencounterdiagnoses as oed
--     inner join amd.amd_diagnosis_dx_ids as pddi
--     on oed.dx_id = pddi.dx_id
-- ;

-- DROP TABLE IF EXISTS amd.amd_patients;
-- CREATE TABLE amd.amd_patients AS
--     select distinct pat_id, pat_mrn
--     from
--     (select distinct pat_id, pat_mrn
--     from ehr.ophthalmologyencounterdiagnoses as oed
--     inner join amd.amd_diagnosis_dx_ids as pddi
--     on oed.dx_id = pddi.dx_id -- 
--     UNION ALL
--     select distinct pat_id, pat_mrn
--     from ehr.ophthalmologypatientdiagnoses as opd
--     inner join amd.amd_diagnosis_dx_ids as pddi
--     on opd.dx_id = pddi.dx_id -- 
--     UNION ALL
--     select distinct pat_id, pat_mrn
--     from ehr.ophthalmologyencounterproblemlist as oepl
--     inner join amd.amd_diagnosis_dx_ids as pddi
--     on oepl.dx_id = pddi.dx_id -- 
--     -- UNION ALL 
--     -- select distinct pat_id, pat_mrn
--     -- from ehr.ophthalmologyencountervisit
--     -- where progress_note like '%amd%' -- 
--     -- UNION ALL
--     -- select distinct pat_id, pat_mrn
--     -- from ehr.ophthalmologylabs
--     -- where component_name like '%amd%'
--     -- or    result_flag like '%amd%'
--     -- or    line_comment like '%amd%'
--     -- or    results_comp_cmt like '%amd%'
--     -- or    results_cmt like '%amd%' -- 5
--     order by pat_id
--     ) as amd_pat_ids; -- 
