/* Encounters */
select * from ehr.ophthalmologyencounters order by pat_enc_csn_id, contact_date limit 10;
select * from ehr.ophthalmologyencountervisit order by pat_enc_csn_id, contact_date limit 10;
select * from ehr.ophthalmologyencounterproblemlist order by pat_enc_csn_id limit 10;
select * from ehr.ophthalmologyencountercharge order by pat_enc_csn_id limit 10;
select * from ehr.ophthalmologyencounterdiagnoses order by pat_enc_csn_id limit 1000;
select * from ehr.ophthalmologyencounterexam order by pat_enc_csn_id limit 1000;

select * from ehr.ophthalmologyencounters order by pat_enc_csn_id, contact_date limit 1000;
select * from ehr.ophthalmologyencounterexam order by pat_enc_csn_id, contact_date limit 1000;
select distinct line from ehr.ophthalmologyencounterexam
select * from ehr.ophthalmologyencounterdiagnoses order by pat_enc_csn_id, pat_mrn, dx_id limit 100

-- select count(*) from ehr.ophthalmologyencounters where pat_enc_csn_id not in (select pat_enc_csn_id from ehr.ophthalmologyencounterdiagnoses)

/* Medications */

-- medication_id is not the same as order_med_id
-- medication_id is the same as medication_id
-- order_med_id is the same as order_med_id
-- order_id from orders is not the same as order_med_id in other tables
-- select order_id, ordering_csn_id,* from ehr.ophthalmologyorders order by order_id limit 1000;

select contact_date, * from ehr.ophthalmologyencounters where pat_enc_csn_id = ;

select count(*) from ehr.ophthalmologymedicationdm -- 3706
select count(*) from ehr.ophthalmologymedications -- 6,062,868
select count(*) from ehr.ophthalmologycurrentmedications -- 24,732,468

select medication_id,* from ehr.ophthalmologymedicationdm order by medication_id;

select order_med_id, medication_id, * from ehr.ophthalmologymedications order by order_med_id, medication_id limit 1000;
select * from ehr.ophthalmologymedications where pat_mrn = '' limit 1000;
select order_med_id, medication_id, * from ehr.ophthalmologycurrentmedications  order by order_med_id, medication_id limit 1000;
select * from ehr.ophthalmologycurrentmedications where pat_mrn = ''  limit 1000;


select pat_mrn, contact_date, * from ehr.ophthalmologyencounters where pat_mrn = '' limit 1000;

select * from ehr.ophthalmologyencounterexam
where smrtdta_elem_value is not null
limit 1000;

select count(*) from ehr.ophthalmologyencounterexam
where smrtdta_elem_value is not null
limit 1000;