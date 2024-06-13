
/* Person Tables */
select count(primarymrn) -- 178,801
from coris_registry.c3304_gbq_t1_person_20240207 limit 10

select count(primarymrn) -- 177,089
from coris_registry.c3304_t1_person_20231222 limit 10

select count(pat_mrn) -- 330,383
from ehr.ophthalmologypatients limit 10

-- inner - "in common"
select count(*) -- cp.primarymrn, sp.pat_mrn -- 123,048
from coris_registry.c3304_gbq_t1_person_20240207 as cp
inner join ehr.ophthalmologypatients as sp
on cp.primarymrn = sp.pat_mrn
limit 10

select count(*) -- cp.primarymrn, sp.pat_mrn -- 122,892
from coris_registry.c3304_t1_person_20231222 as cp
inner join ehr.ophthalmologypatients as sp
on cp.primarymrn = sp.pat_mrn
limit 10

-- left - "in coris only"
select count(*) -- cp.primarymrn, sp.pat_mrn -- 55,753
from coris_registry.c3304_gbq_t1_person_20240207 as cp
left join ehr.ophthalmologypatients as sp
on cp.primarymrn = sp.pat_mrn
where sp.pat_mrn is null
limit 10

select count(*) -- cp.primarymrn, sp.pat_mrn -- 54,197
from coris_registry.c3304_t1_person_20231222 as cp
left join ehr.ophthalmologypatients as sp
on cp.primarymrn = sp.pat_mrn
where sp.pat_mrn is null
limit 10

-- right - "in source only"
select count(*) -- cp.primarymrn, sp.pat_mrn -- 207,335
from coris_registry.c3304_gbq_t1_person_20240207 as cp
right join ehr.ophthalmologypatients as sp
on cp.primarymrn = sp.pat_mrn
where cp.primarymrn is null
limit 10

select count(*) -- cp.primarymrn, sp.pat_mrn -- 207,491
from coris_registry.c3304_t1_person_20231222 as cp
right join ehr.ophthalmologypatients as sp
on cp.primarymrn = sp.pat_mrn
where cp.primarymrn is null
limit 10

/* Encounters Tables */
select count(arb_person_id) -- 178,801
from coris_registry.c3304_gbq_t2_encounter_20240207 limit 10

select count(primarymrn) -- 177,089
from coris_registry.c3304_t2_encounter_20231222 limit 10

select count(pat_enc_csn_id) -- 330,383
from ehr.ophthalmologyencounters limit 10






/* Notes Tables */
coris_registry.c3304_gbq_t11_notes_20240207

