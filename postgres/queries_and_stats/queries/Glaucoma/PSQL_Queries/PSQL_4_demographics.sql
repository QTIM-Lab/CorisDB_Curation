/* Demographics */
DROP VIEW IF EXISTS glaucoma.glaucoma_demographics;
CREATE VIEW glaucoma.glaucoma_demographics AS
    select
    op.pat_id,
    op.pat_mrn,
    -- le.pat_age_at_enc,
    DATE_PART('year', -- grab year from AGE funtion that takes two dates
              AGE(
              case when op.last_contact_date is null 
                   then '2023-05-30' -- if there is no last_contact_date calc current age
                   else op.last_contact_date 
                   end::date, op.birth_date::date
              )
             ) AS calc_age_years,
    op.birth_date,
      -- le.last_contact_date, -- bad idea
    op.last_contact_date, -- bad idea
    op.ethnic,
    op.race,
    case
        -- Name change
        when op.race = 'White or Caucasian' then 'White'
        when op.race = 'Black or African American' then 'Black'
        when op.race = 'American Indian or Alaska Native' then 'American Indian or Alaska Native'
        when op.race = 'Asian Indian' 
          or op.race = 'Other Asian'
          or op.race = 'Vietnamese' 
          or op.race = 'Japanese' 
          or op.race = 'Chinese' 
          or op.race = 'Filipino' 
          or op.race = 'Korean' 
          then 'Asian'
        when op.race = 'Native Hawaiian and Other Pacific Islander'
          or op.race = 'Native Hawaiian' 
          or op.race = 'Other Pacific Islander' 
          then 'Native Hawaiian and Other Pacific Islander'
        when op.race = 'More Than One Race' then 'More Than One Race'
        -- Other bin
        when op.race is null then 'Other'
        when op.race = 'Patient Declined' then 'Other'
        when op.race = 'Unknown' then 'Other'
        when op.race = 'Other' then 'Other'
        else 'Missing Category' -- White, Black or African American
    end as race_binned,
    op.pat_sex
    -- ,*
    -- count(*)
    from public.ophthalmologypatients as op
    inner join glaucoma.glaucoma_patients as gp
    on op.pat_id = gp.pat_id
                    /* I think this is a bad idea
                        -- inner join glaucoma.last_encounters as le
                        -- on op.pat_id = le.pat_id
                    */
    -- where op.last_contact_date is null
    order by op.pat_id;

DROP TABLE IF EXISTS glaucoma.glaucoma_summary_stats;
CREATE TABLE glaucoma.glaucoma_summary_stats AS
    -- between is inclusive so <lower bound> <= x <= <upper bound> equates to true.
    select 'Total_Patients_In_Coris_DB' as age_and_other_bins, count(distinct pat_id) as patient_counts from public.ophthalmologypatients
    union (
        select 'glaucoma_Patients' as age_and_other_bins, count(*) from glaucoma.glaucoma_demographics)
    union (
    select 'Males' as age_and_other_bins, count(pat_sex) as patient_counts from glaucoma.glaucoma_demographics
        where pat_sex = 'Male')
    union (
    select 'Females' as age_and_other_bins, count(pat_sex) as patient_counts from glaucoma.glaucoma_demographics
        where pat_sex = 'Female')
    union (
    select '0-18' as age_and_other_bins, count(calc_age_years) as patient_counts from glaucoma.glaucoma_demographics
        where calc_age_years between 0 and 18)
    union (
    select '19-49' as age_and_other_bins, count(calc_age_years) as patient_counts from glaucoma.glaucoma_demographics
        where calc_age_years between 19 and 49)
    union (
    select '50-59' as age_and_other_bins,count(calc_age_years) as patient_counts from glaucoma.glaucoma_demographics
        where calc_age_years between 50 and 59)
    union (
    select '60-69' as age_and_other_bins,count(calc_age_years) as patient_counts from glaucoma.glaucoma_demographics
        where calc_age_years between 60 and 69)
    union (
    select '70-79' as age_and_other_bins,count(calc_age_years) as patient_counts from glaucoma.glaucoma_demographics
        where calc_age_years between 70 and 79)
    union (
    select '80-89' as age_and_other_bins,count(calc_age_years) as patient_counts from glaucoma.glaucoma_demographics
        where calc_age_years between 80 and 89)
    union (
    select '90+' as age_and_other_bins, count(calc_age_years) as patient_counts from glaucoma.glaucoma_demographics
                where calc_age_years >= 90)
    order by age_and_other_bins;
