/* Recreate encounters table for glaucoma scheme */

-- | arb_person_id | arb_encounter_id | department | departmentspecialty | encountertype | patientclass | "date" | admissiondate | dischargedate | losdays | loshours | iculosdays | providername | primaryspecialty | payorfinancialclass | payorname |

drop table if exists glaucoma.bb_gbq_glaucoma_encounter_20240925;
create table glaucoma.bb_gbq_glaucoma_encounter_20240925 as 
    SELECT
    -- count(distinct arb_encounter_id)
    arb_person_id,
    arb_encounter_id,
    department,
    departmentspecialty,
    encountertype,
    patientclass,
    "date",
    EXTRACT(YEAR from "date") as year ,
    EXTRACT(MONTH from "date") as month,
    EXTRACT(DAY from "date") as day,
    admissiondate,
    dischargedate,
    losdays,
    loshours,
    iculosdays,
    providername,
    primaryspecialty,
    payorfinancialclass,
    payorname
    FROM coris_registry.c3304_gbq_t2_encounter_20240207
    where arb_encounter_id in (
        select distinct arb_encounter_id from glaucoma.bb_gbq_glaucoma_encounter_diagnosis_20240925
    );
