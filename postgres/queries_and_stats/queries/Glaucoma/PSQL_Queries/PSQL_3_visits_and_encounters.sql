/* Glaucoma Visits */
DROP TABLE IF EXISTS glaucoma.glaucoma_visits;
CREATE TABLE glaucoma.glaucoma_visits AS
    select
    pat_enc_csn_id, pat_id, pat_mrn, contact_date, progress_note
    from public.ophthalmologyencountervisit
    -- This filter is just glaucoma patients...but those patients could have non glaucoma encounters
    where pat_id in (select pat_id from glaucoma.glaucoma_patients) and (progress_note like '%glaucoma%' or progress_note like '%Glaucoma%'); -- 

DROP TABLE IF EXISTS glaucoma.glaucoma_encounters;
CREATE TABLE glaucoma.glaucoma_encounters AS
    select
    pat_enc_csn_id, pat_id, pat_mrn, pat_age_at_enc, contact_date, enc_close_time
    from public.ophthalmologyencounters
    -- This filter is just glaucoma patients...but those patients could have non glaucoma encounters
    where pat_id in (select pat_id from glaucoma.glaucoma_patients) and 
          pat_enc_csn_id in (select pat_enc_csn_id from glaucoma.glaucoma_visits); -- 

select count(*) from glaucoma.glaucoma_encounters; --
select count(distinct pat_enc_csn_id) from glaucoma.glaucoma_encounters; -- 

select count(*) from public.ophthalmologyencounters; -- 
select count(distinct pat_enc_csn_id) from public.ophthalmologyencounters; -- 
select * from public.ophthalmologyencounters order by pat_id, pat_age_at_enc limit 10; -- 

DROP VIEW IF EXISTS glaucoma.last_encounters;
CREATE VIEW glaucoma.last_encounters AS
    select 
    pat_id,
    pat_mrn,
    max(contact_date) as last_contact_date,
    max(pat_age_at_enc) as pat_age_at_enc
    from glaucoma.glaucoma_encounters
    group by pat_id, pat_mrn
    order by pat_id; -- 

DROP TABLE IF EXISTS glaucoma.glaucoma_encounter_visit_join;
CREATE TABLE glaucoma.glaucoma_encounter_visit_join AS
    select
    --*,
    ge.pat_enc_csn_id as ge_pat_enc_csn_id,
    gv.pat_enc_csn_id as gv_pat_enc_csn_id,
    ge.pat_id as ge_pat_id,
    gv.pat_id as gv_pat_id,
    gv.pat_mrn as gv_pat_mrn,
    ge.contact_date as ge_contact_date,
    gv.contact_date as gv_contact_date,
    gv.progress_note as gv_progress_note
    from glaucoma.glaucoma_encounters as ge
    inner join glaucoma.glaucoma_visits as gv -- IT'S AN INNER JOIN (overlap)
    on ge.pat_enc_csn_id = gv.pat_enc_csn_id and ge.pat_id = gv.pat_id
    order by ge.pat_enc_csn_id, ge.pat_id, ge.contact_date;
