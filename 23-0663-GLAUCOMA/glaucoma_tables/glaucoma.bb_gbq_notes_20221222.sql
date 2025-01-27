-- | arb_person_id | arb_encounter_id | noteepicid | notetype | notetext | noteprovider | dateofnote | timeofnote |

drop table if exists glaucoma.bb_gbq_notes_20231222;
create table glaucoma.bb_gbq_notes_20231222 as  
SELECT distinct
arb_person_id,
arb_encounter_id,
noteepicid,
notetype,
notetext,
noteprovider,
dateofnote,
EXTRACT(YEAR from dateofnote) as year,
EXTRACT(MONTH from dateofnote) as month,
EXTRACT(DAY from dateofnote) as day,
timeofnote
from coris_registry.c3304_t11_notes_20231222 as n
where arb_encounter_id in (
    select distinct arb_encounter_id from glaucoma.bb_gbq_encounter_diagnosis_20240925
);