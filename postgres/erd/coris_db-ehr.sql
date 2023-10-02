--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Ubuntu 15.3-1.pgdg22.04+1)
-- Dumped by pg_dump version 15.3 (Ubuntu 15.3-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ehr; Type: SCHEMA; Schema: -; Owner: ophuser
--

CREATE SCHEMA ehr;


ALTER SCHEMA ehr OWNER TO ophuser;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ophthalmologycurrentmedications; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologycurrentmedications (
    pat_mrn character varying(100),
    pat_id character varying(100),
    pat_enc_csn_id integer,
    medication_id integer,
    order_med_id integer,
    line integer,
    name character varying(500),
    generic character varying(100),
    therapeutic_class character varying(100),
    pharmaceutical_class character varying(100),
    strength character varying(100),
    ordering_dttm timestamp with time zone,
    update_dttm timestamp with time zone,
    add_to_list_tm timestamp with time zone,
    frequency character varying(100),
    contact_date timestamp with time zone
);


ALTER TABLE ehr.ophthalmologycurrentmedications OWNER TO ophuser;

--
-- Name: ophthalmologydiagnosesdm; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologydiagnosesdm (
    dx_id integer,
    dx_name character varying(500),
    line integer,
    code character varying(100),
    code_type character varying(100),
    dx_group character varying(100),
    dx_group_id integer
);


ALTER TABLE ehr.ophthalmologydiagnosesdm OWNER TO ophuser;

--
-- Name: ophthalmologyencountercharge; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologyencountercharge (
    ucl_id character varying(100),
    pat_enc_csn_id integer,
    pat_id character varying(100),
    pat_mrn character varying(100),
    proc_code character varying(100),
    proc_description character varying(100),
    service_date_dt timestamp with time zone,
    service_provider character varying(100),
    modifier character varying(500),
    quantity numeric(18,6),
    bill_area character varying(100),
    cost_center_name character varying(100),
    procedure_id integer,
    service_provider_id character varying(100),
    billing_provider_id character varying(100),
    hospital_account_id integer,
    transactionsubtype character varying(100)
);


ALTER TABLE ehr.ophthalmologyencountercharge OWNER TO ophuser;

--
-- Name: ophthalmologyencounterdiagnoses; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologyencounterdiagnoses (
    pat_enc_csn_id integer,
    pat_mrn character varying(100),
    pat_id character varying(100),
    contact_date timestamp with time zone,
    line integer,
    dx_id integer,
    dx_name character varying(500),
    primary_dx_yn character varying(100),
    annotation integer,
    comments integer,
    dx_link_prob_id integer
);


ALTER TABLE ehr.ophthalmologyencounterdiagnoses OWNER TO ophuser;

--
-- Name: ophthalmologyencounterexam; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologyencounterexam (
    concept_id character varying(100),
    concept_name character varying(500),
    pat_mrn character varying(100),
    pat_id character varying(100),
    pat_enc_csn_id integer,
    cur_value_datetime timestamp with time zone,
    element_value_id integer,
    line integer,
    smrtdta_elem_value character varying(500),
    contact_date timestamp with time zone
);


ALTER TABLE ehr.ophthalmologyencounterexam OWNER TO ophuser;

--
-- Name: ophthalmologyencounterproblemlist; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologyencounterproblemlist (
    problem_list_id integer,
    pat_enc_csn_id integer,
    pat_mrn character varying(100),
    pat_id character varying(100),
    dx_id integer,
    dx_name character varying(500),
    noted_date timestamp with time zone,
    resolved_date timestamp with time zone,
    date_of_entry timestamp with time zone,
    problem_cmt character varying(100),
    principal_pl_yn character varying(100)
);


ALTER TABLE ehr.ophthalmologyencounterproblemlist OWNER TO ophuser;

--
-- Name: ophthalmologyencounters; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologyencounters (
    pat_enc_csn_id integer,
    pat_id character varying(100),
    pat_mrn character varying(100),
    hsp_account_id integer,
    pat_age_at_enc integer,
    pat_class character varying(100),
    enc_type character varying(100),
    department_name character varying(100),
    primary_location character varying(100),
    los_prime_proc_code character varying(100),
    los_prime_proc_name character varying(100),
    los_prime_cat character varying(100),
    visit_provider character varying(100),
    pcp_provider character varying(100),
    referral_name character varying(100),
    specialty character varying(100),
    admission_type character varying(100),
    visit_type character varying(100),
    appt_status character varying(100),
    reason_for_visit character varying(500),
    obgyn_status character varying(100),
    tobacco_use character varying(100),
    alcohol_use character varying(100),
    ill_drug_use character varying(100),
    tobacco_used_years character varying(100),
    smoking_start_date timestamp with time zone,
    smoking_quit_date timestamp with time zone,
    entry_time timestamp with time zone,
    appt_made_date timestamp with time zone,
    contact_date timestamp with time zone,
    appt_time timestamp with time zone,
    begin_checkin_dttm timestamp with time zone,
    checkin_time timestamp with time zone,
    checkout_time timestamp with time zone,
    enc_close_time timestamp with time zone,
    update_date timestamp with time zone,
    effective_date_dttm timestamp with time zone,
    pat_vis_wait integer,
    pat_vis_tm_w_nurse integer,
    pat_tm_w_for_phys integer,
    pat_vis_tm_w_phys integer,
    appt_length integer,
    bp_systolic integer,
    bp_diastolic integer,
    temperature numeric(18,6),
    pulse integer,
    weight numeric(18,6),
    height character varying(100),
    bmi numeric(18,6),
    bsa numeric(18,6),
    enc_closed_yn character varying(100),
    referral_req_yn character varying(100),
    noncvred_service_yn character varying(100),
    pre_vis_chart_amt integer,
    post_vis_chart_amt integer,
    sequential_appt_yn character varying(100),
    dx_unique_counter character varying(100),
    cnct_archived_yn character varying(100),
    appt_resch_yn character varying(100),
    appt_serial_no integer,
    inpatient_data_id character varying(100),
    charge_slip_number character varying(100),
    pat_class_c integer,
    hx_pat_enc_csn_id integer,
    enc_closed_user_id character varying(100),
    los_prime_proc_id integer,
    pcp_prov_id character varying(100),
    visit_prov_id character varying(100),
    department_id integer,
    appt_prc_id character varying(100),
    appt_entry_user_id character varying(100),
    checkin_user_id character varying(100),
    referral_id integer,
    account_id integer,
    coverage_id integer,
    primary_loc_id integer,
    visit_epm_id character varying(100),
    visit_epp_id bigint,
    serv_area_id integer,
    ip_episode_id integer,
    referral_source_id character varying(100),
    enc_bill_area_id integer,
    chkout_user_id character varying(100)
);


ALTER TABLE ehr.ophthalmologyencounters OWNER TO ophuser;

--
-- Name: ophthalmologyencountervisit; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologyencountervisit (
    pat_enc_csn_id integer,
    pat_id character varying(100),
    pat_mrn character varying(100),
    contact_date timestamp with time zone,
    progress_note text
);


ALTER TABLE ehr.ophthalmologyencountervisit OWNER TO ophuser;

--
-- Name: ophthalmologyfamilyhistory; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologyfamilyhistory (
    pat_mrn character varying(100),
    pat_id character varying(100),
    recent_pat_enc_csn_id integer,
    recent_contact_date timestamp with time zone,
    medical_hx character varying(100),
    relation character varying(100),
    history_source character varying(100),
    comments character varying(100),
    fam_stat_name character varying(100),
    fam_status character varying(100),
    age_of_onset integer,
    fam_stat_id integer
);


ALTER TABLE ehr.ophthalmologyfamilyhistory OWNER TO ophuser;

--
-- Name: ophthalmologyimplant; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologyimplant (
    pat_mrn character varying(100),
    pat_id character varying(100),
    log_id character varying(100),
    case_id character varying(100),
    or_proc_name character varying(500),
    implant_name character varying(100),
    implant_type character varying(100),
    laterality character varying(100),
    implant_area character varying(100),
    or_proc_id character varying(100),
    implant_id integer
);


ALTER TABLE ehr.ophthalmologyimplant OWNER TO ophuser;

--
-- Name: ophthalmologyimplantdm; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologyimplantdm (
    implant_id character varying(100),
    implant_name character varying(100),
    implant_type character varying(100),
    manufacturer character varying(100)
);


ALTER TABLE ehr.ophthalmologyimplantdm OWNER TO ophuser;

--
-- Name: ophthalmologylaborder; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologylaborder (
    pat_mrn character varying(100),
    pat_id character varying(100),
    pat_enc_csn_id integer,
    order_id integer,
    accession_num bigint,
    proc_code character varying(100),
    display_name character varying(100),
    external_ord_id character varying(100),
    abnormal_yn character varying(100),
    ordering_date timestamp with time zone,
    specimen_type character varying(100),
    specimen_taken_time timestamp with time zone,
    specimen_recv_time timestamp with time zone,
    specimen_comments character varying(100),
    order_type character varying(100),
    order_status character varying(100),
    lab_status character varying(100),
    order_class character varying(100),
    order_priority character varying(100),
    ordering_prov_name character varying(100),
    authrzing_prov_name character varying(100),
    ordering_prov_id character varying(100),
    authrzing_prov_id character varying(100),
    lab_status_c integer
);


ALTER TABLE ehr.ophthalmologylaborder OWNER TO ophuser;

--
-- Name: ophthalmologylabs; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologylabs (
    pat_mrn character varying(100),
    pat_id character varying(100),
    order_id integer,
    component_id integer,
    result_date timestamp with time zone,
    result_line integer,
    component_name character varying(100),
    ord_value numeric(18,6),
    result_flag character varying(100),
    ref_normal_vals character varying(500),
    reference_low character varying(500),
    reference_high character varying(500),
    reference_unit character varying(100),
    line_comment text,
    result_flag_c integer,
    results_comp_cmt text,
    results_cmt text
);


ALTER TABLE ehr.ophthalmologylabs OWNER TO ophuser;

--
-- Name: ophthalmologymedicationdm; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologymedicationdm (
    med_cat character varying(100),
    med_subcat character varying(100),
    therapeutic_class character varying(100),
    pharmaceutical_class character varying(100),
    medication_id integer,
    name character varying(100),
    generic_name character varying(100)
);


ALTER TABLE ehr.ophthalmologymedicationdm OWNER TO ophuser;

--
-- Name: ophthalmologymedications; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologymedications (
    order_med_id integer,
    pat_mrn character varying(100),
    pat_id character varying(100),
    pat_enc_csn_id integer,
    order_status character varying(100),
    med_presc_prov_name character varying(100),
    ordering_dttm timestamp with time zone,
    order_start_date timestamp with time zone,
    order_end_date timestamp with time zone,
    discontinue_datetime timestamp with time zone,
    name character varying(500),
    generic character varying(100),
    therapeutic_class character varying(100),
    pharmaceutical_class character varying(100),
    strength character varying(100),
    med_dose_unit character varying(100),
    admin_dose_unit character varying(100),
    med_route character varying(100),
    hv_discrete_dose character varying(100),
    quantity character varying(100),
    med_dis_disp_qty numeric(18,6),
    total_doses integer,
    total_remaining_doses integer,
    refills character varying(100),
    instruction integer,
    frequency character varying(100),
    pat_enc_date_real numeric(18,6),
    medication_id integer,
    med_presc_prov_id character varying(100),
    gpi character varying(100),
    med_route_c character varying(100),
    hv_dose_unit_c integer,
    max_dose_unit_c integer,
    order_status_c integer,
    hv_discr_freq_id character varying(100),
    pharmacy_id integer,
    disp_as_written_yn character varying(100),
    rsn_for_discon character varying(100),
    ext_formulary_id character varying(100),
    ext_coverage_id character varying(100),
    ext_copay_id character varying(100),
    ext_pharmacy_type character varying(100),
    ext_formulary_stat character varying(100),
    cost character varying(100)
);


ALTER TABLE ehr.ophthalmologymedications OWNER TO ophuser;

--
-- Name: ophthalmologyorders; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologyorders (
    order_id integer,
    pat_enc_csn_id integer,
    pat_mrn character varying(100),
    pat_id character varying(100),
    pat_age_at_order integer,
    acession_num integer,
    proc_code character varying(100),
    proc_name character varying(100),
    proc_cat_name character varying(100),
    modifier1 character varying(100),
    modifier2 character varying(100),
    modifier3 character varying(100),
    modifier4 character varying(100),
    order_type character varying(100),
    order_status character varying(100),
    order_class character varying(100),
    order_priority character varying(100),
    ordering_prov_name character varying(100),
    authrizing_prov_name character varying(100),
    billing_prov_name character varying(100),
    referring_prov_name character varying(100),
    finalizing_prov_name character varying(100),
    technologist_name character varying(100),
    pat_dep character varying(100),
    lab_status character varying(100),
    order_source character varying(100),
    ordering_dttm timestamp with time zone,
    proc_start_time timestamp with time zone,
    proc_end_time timestamp with time zone,
    finalizing_dttm timestamp with time zone,
    result_instant_tm timestamp with time zone,
    result_time timestamp with time zone,
    summ_update_time timestamp with time zone,
    chrg_dropped_time timestamp with time zone,
    update_date timestamp with time zone,
    ordering_csn_id integer,
    result_note_csn integer,
    max_ord_date_real integer,
    proc_cat_id integer,
    ordering_contact_dep_id character varying(100),
    pat_loc_id character varying(100),
    ordering_prov_id integer,
    proc_id integer,
    authrzing_prov_id integer,
    billing_prov_id character varying(100),
    ord_creatr_user_id character varying(100),
    quantity numeric(18,6),
    referring_prov_id character varying(100),
    technologist_id character varying(100),
    hv_hospitalist_yn character varying(100),
    abnormal_yn character varying(100),
    session_key integer,
    order_comment character varying(100),
    narrative character varying(100)
);


ALTER TABLE ehr.ophthalmologyorders OWNER TO ophuser;

--
-- Name: ophthalmologypatientdiagnoses; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologypatientdiagnoses (
    pat_mrn character varying(100),
    pat_id character varying(100),
    dx_id integer,
    dx_source_id integer,
    dx_source_date timestamp with time zone,
    dx_source character varying(100),
    line integer
);


ALTER TABLE ehr.ophthalmologypatientdiagnoses OWNER TO ophuser;

--
-- Name: ophthalmologypatients; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologypatients (
    pat_id character varying(100),
    pat_mrn character varying(100),
    pat_sex character varying(100),
    birth_date timestamp with time zone,
    ethnic character varying(100),
    race character varying(100),
    marital character varying(100),
    religion character varying(100),
    language character varying(100),
    living_status character varying(100),
    address_line character varying(500),
    city character varying(100),
    state character varying(100),
    county character varying(100),
    country character varying(100),
    zip character varying(100),
    reg_status character varying(100),
    cur_pcp_prov_name character varying(100),
    cur_prim_loc_name character varying(100),
    employ_status character varying(100),
    comp_appts_count integer,
    noshow_appts_count integer,
    no_show_rate numeric(18,6),
    prim_financial_class character varying(100),
    first_appt_department character varying(100),
    tobacco_use character varying(100),
    alcohol_use character varying(100),
    ill_drug_use character varying(100),
    smoking_start_date timestamp with time zone,
    smoking_end_date timestamp with time zone,
    tobacco_used_years character varying(100),
    reg_date timestamp with time zone,
    rec_create_date timestamp with time zone,
    death_date timestamp with time zone,
    alrgy_upd_date timestamp with time zone,
    meds_last_rev_tm timestamp with time zone,
    update_date timestamp with time zone,
    ept_log_date timestamp with time zone,
    alrgy_upd_inst timestamp with time zone,
    first_contact_date timestamp with time zone,
    last_contact_date timestamp with time zone,
    epiccare_pat_yn character varying(100),
    medicare_num character varying(100),
    medicaid_num character varying(100),
    adv_directive_yn character varying(100),
    intrptr_needed_yn character varying(100),
    txp_pat_yn character varying(100),
    alrgy_rev_ept_csn integer,
    meds_last_rev_csn integer,
    allergy_review_status character varying(100),
    cur_pcp_prov_id character varying(100),
    cur_prim_loc_id integer,
    prim_cvg_id integer,
    prim_epm_id character varying(100),
    prim_epp_id bigint,
    alrgy_upd_user_id character varying(100),
    meds_lst_rev_usr_id character varying(100),
    first_appt_dept_id integer,
    hx_pat_enc_csn_id integer,
    mgi_yn character varying(100),
    mgi_date timestamp with time zone,
    adi_natrank integer,
    ruca character varying(100),
    ppv_yn character varying(100),
    dvs_yn character varying(100),
    dci_distress_score numeric(18,6)
);


ALTER TABLE ehr.ophthalmologypatients OWNER TO ophuser;

--
-- Name: ophthalmologyproviderall; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologyproviderall (
    prov_id character varying(100),
    prov_name character varying(100),
    prov_type character varying(100),
    upin character varying(100),
    active_status character varying(100),
    clinician_title character varying(100),
    sex character varying(100),
    referral_source_type character varying(100),
    record_type integer,
    doctors_degree character varying(100),
    user_id character varying(100),
    oph_yn character varying(100),
    um_num character varying(100),
    license character varying(100),
    npi character varying(100),
    specialty character varying(100),
    system_login character varying(100),
    department_name character varying(100),
    loc_name character varying(100),
    center character varying(100),
    def_division character varying(100),
    first_enc_date timestamp with time zone,
    last_enc_date timestamp with time zone,
    total_enc integer
);


ALTER TABLE ehr.ophthalmologyproviderall OWNER TO ophuser;

--
-- Name: ophthalmologyproviderdm; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologyproviderdm (
    prov_id character varying(100),
    prov_name character varying(100),
    department_id text,
    department_name character varying(100),
    dept_abbreviation character varying(100)
);


ALTER TABLE ehr.ophthalmologyproviderdm OWNER TO ophuser;

--
-- Name: ophthalmologyradiology; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologyradiology (
    pat_mrn character varying(100),
    acession_num bigint,
    modality character varying(100),
    begin_exam_dttm timestamp with time zone,
    end_exam_dttm timestamp with time zone,
    finalizing_dttm timestamp with time zone,
    perform_proc_code character varying(100),
    perform_proc_name character varying(100),
    authorizing_prov_name character varying(100),
    ordering_prov_name character varying(100),
    appt_note character varying(100),
    ordering_dep character varying(100),
    ordering_prov_id character varying(100),
    authorizing_prov_id character varying(100),
    text character varying(100)
);


ALTER TABLE ehr.ophthalmologyradiology OWNER TO ophuser;

--
-- Name: ophthalmologysupply; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologysupply (
    pat_mrn character varying(100),
    pat_id character varying(100),
    log_id character varying(100),
    case_id character varying(100),
    or_proc_name character varying(500),
    or_proc_id character varying(100),
    or_supply_cat character varying(100),
    sz character varying(100),
    supply_id character varying(100),
    supply_name character varying(500),
    quantity integer
);


ALTER TABLE ehr.ophthalmologysupply OWNER TO ophuser;

--
-- Name: ophthalmologysupplydm; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologysupplydm (
    or_supply_cat integer,
    line integer,
    supply_id character varying(100),
    sz integer,
    supply_name character varying(500)
);


ALTER TABLE ehr.ophthalmologysupplydm OWNER TO ophuser;

--
-- Name: ophthalmologysurgery; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologysurgery (
    pat_mrn character varying(100),
    pat_id character varying(100),
    surgery_csn_id integer,
    pat_enc_csn_id integer,
    case_id character varying(100),
    log_id character varying(100),
    or_case_type character varying(100),
    or_case_class character varying(100),
    proc_level character varying(100),
    num_of_panels integer,
    pre_op_diag character varying(100),
    or_postop_dest character varying(100),
    hsp_account_id integer,
    patient_class character varying(100),
    patient_type_cd character varying(100),
    or_service character varying(100),
    location character varying(100),
    room character varying(100),
    or_status character varying(100),
    or_anesth_type character varying(100),
    or_laterality character varying(100),
    site character varying(100),
    incision_closure character varying(100),
    or_wound_class character varying(100),
    primary_physican character varying(100),
    anesthesiologist character varying(100),
    pnl_ character varying(500),
    all_proc_as_ordered character varying(500),
    total_time_needed integer,
    sched_start_time timestamp with time zone,
    preop_present_datetime timestamp with time zone,
    rn_assess_complete_datetime timestamp with time zone,
    room_ready_datetime timestamp with time zone,
    pat_in_or_datetime timestamp with time zone,
    incision_start_datetime timestamp with time zone,
    dressing_end_datetime timestamp with time zone,
    out_or_datetime timestamp with time zone,
    complete_datetime timestamp with time zone,
    inpatient_data_id character varying(100),
    service_c character varying(100),
    pnl_1_prim_proc_ext_id character varying(100),
    pnl_1_prim_surg_proc_id character varying(100),
    primary_phys_id character varying(100),
    anes_prov_id character varying(100),
    cpt1 character varying(100),
    cpt2 character varying(100),
    cpt3 character varying(100),
    cpt4 character varying(100),
    cpt5 character varying(100),
    mod1 character varying(500),
    mod2 character varying(500),
    mod3 character varying(500),
    mod4 character varying(500),
    mod5 character varying(500),
    argusimplant character varying(100),
    bcl character varying(100),
    conformer character varying(100),
    corneal_punch character varying(100),
    diathermy_probe character varying(100),
    fragmatome character varying(100),
    gas character varying(100),
    iol character varying(100),
    iris_hook character varying(100),
    i_track character varying(100),
    kahook_dual character varying(100),
    laser_probe character varying(100),
    mal_ring character varying(100),
    perfluoron character varying(100),
    sealant_evicel character varying(100),
    sealant_resure character varying(100),
    sil_oil character varying(100),
    suture_cg character varying(100),
    suture_ethilon character varying(100),
    suture_gt character varying(100),
    suture_mersilene character varying(100),
    suture_monocryl character varying(100),
    suture_nylon character varying(100),
    suture_pds character varying(100),
    suture_pg character varying(100),
    suture_pp character varying(100),
    suture_prolene character varying(100),
    suture_silk character varying(100),
    suture_vicryl character varying(100),
    tkp character varying(100),
    visco_360 character varying(100),
    visc_duovisc character varying(100),
    visc_healon character varying(100),
    visc_ocucoat character varying(100),
    visc_provisc character varying(100),
    visc_viscoat character varying(100),
    vitrectomy_pack character varying(100),
    vit_accurus character varying(100),
    vit_constellation character varying(100),
    vit_infinity character varying(100),
    vit_occutome character varying(100),
    vit_other character varying(100),
    ct_tissue_for_surgery character varying(100),
    ct_kpro character varying(100),
    gdd_type character varying(100),
    gdd_migs character varying(100),
    gdd_patch_graft character varying(100),
    gdd_other character varying(100),
    cat_anterior_posterior character varying(100),
    cat_type character varying(100),
    cat_company character varying(100),
    cat_model character varying(100),
    cat_power character varying(100),
    cat_ctr character varying(100),
    ret_sb character varying(100),
    ret_argus character varying(100),
    ret_retisert character varying(100),
    op_note character varying(100),
    brief_op_note character varying(100)
);


ALTER TABLE ehr.ophthalmologysurgery OWNER TO ophuser;

--
-- Name: ophthalmologysurgeryall; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologysurgeryall (
    pat_mrn character varying(100),
    pat_id character varying(100),
    surgery_csn_id integer,
    pat_enc_csn_id integer,
    case_id character varying(100),
    log_id character varying(100),
    or_case_type character varying(100),
    or_case_class character varying(100),
    proc_level character varying(100),
    num_of_panels integer,
    pre_op_diag character varying(100),
    or_postop_dest character varying(100),
    hsp_account_id integer,
    patient_class character varying(100),
    patient_type_cd character varying(100),
    or_service character varying(100),
    location character varying(100),
    room character varying(100),
    or_status character varying(100),
    or_anesth_type character varying(100),
    or_laterality character varying(100),
    site character varying(100),
    incision_closure character varying(100),
    or_wound_class character varying(100),
    primary_physican character varying(100),
    anesthsiologist character varying(100),
    pnl_1_prim_proc_nm character varying(500),
    all_proc_as_ordered character varying(500),
    total_time_needed integer,
    sched_start_time timestamp with time zone,
    preop_present_datetime timestamp with time zone,
    rn_assess_complete_datetime timestamp with time zone,
    room_ready_datetime timestamp with time zone,
    pat_in_or_datetime timestamp with time zone,
    inscision_start_datetime timestamp with time zone,
    dressing_end_datetime timestamp with time zone,
    out_or_datetime timestamp with time zone,
    complete_datetime timestamp with time zone,
    inpatient_data_id character varying(100),
    service_c character varying(100),
    pnl_1_prim_proc_ext_id character varying(100),
    pnl_1_prim_surg_proc_id character varying(100),
    primary_phys_id character varying(100),
    anes_prov_id character varying(100),
    cpt1 character varying(100),
    cpt2 character varying(100),
    cpt3 character varying(100),
    cpt4 character varying(100),
    cpt5 character varying(100),
    mod1 character varying(500),
    mod2 character varying(500),
    mod3 character varying(500),
    mod4 character varying(500),
    mod5 character varying(500)
);


ALTER TABLE ehr.ophthalmologysurgeryall OWNER TO ophuser;

--
-- Name: ophthalmologysurgerybill; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologysurgerybill (
    log_id character varying(100),
    ucl_id character varying(100),
    yearservicedate character varying(100),
    quantity numeric(18,6),
    procedure_id integer,
    service_provider_id character varying(100),
    billing_provider_id character varying(100),
    cpt_code character varying(100),
    proc_description character varying(100),
    cost_center_name character varying(100),
    bill_area character varying(100),
    specialty character varying(100),
    loc_name character varying(100),
    hospital_account_id integer,
    modifiers character varying(500),
    code_type_c integer
);


ALTER TABLE ehr.ophthalmologysurgerybill OWNER TO ophuser;

--
-- Name: ophthalmologysurgerydm; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologysurgerydm (
    or_cat character varying(100),
    or_cat_id character varying(100),
    or_proc_id character varying(100),
    or_proc_name character varying(100)
);


ALTER TABLE ehr.ophthalmologysurgerydm OWNER TO ophuser;

--
-- Name: ophthalmologysurgerymedication; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologysurgerymedication (
    log_id character varying(100),
    case_id character varying(100),
    pat_mrn character varying(100),
    pat_in_or_datetime timestamp with time zone,
    pat_id character varying(100),
    order_med_id integer,
    mar_enc_csn integer,
    med_cat character varying(100),
    med_subcat character varying(100),
    admin_dose character varying(100),
    unit character varying(100),
    route character varying(100),
    therapeutic_class character varying(100),
    pharmaceutical_calss character varying(100),
    order_place_datetime timestamp with time zone,
    order_start_time timestamp with time zone,
    order_end_time timestamp with time zone,
    discontinue_dattime timestamp with time zone,
    taken_time timestamp with time zone,
    ordering_mode character varying(100),
    medication_id integer,
    name character varying(100),
    line integer,
    generic_name character varying(100),
    order_status character varying(100),
    admin_action character varying(100),
    med_presc_prov_name character varying(100),
    med_presc_prov_id character varying(100)
);


ALTER TABLE ehr.ophthalmologysurgerymedication OWNER TO ophuser;

--
-- Name: ophthalmologysurgeryprocedure; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologysurgeryprocedure (
    case_id character varying(100),
    log_id character varying(100),
    pat_mrn character varying(100),
    pat_id character varying(100),
    line integer,
    or_anesth_type character varying(100),
    or_laterality character varying(100),
    all_proc_panel integer,
    comments character varying(100),
    proc_display_name character varying(500),
    or_proc_id character varying(100)
);


ALTER TABLE ehr.ophthalmologysurgeryprocedure OWNER TO ophuser;

--
-- Name: ophthalmologysurgerysurgeon; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologysurgerysurgeon (
    case_id character varying(100),
    log_id character varying(100),
    pat_mrn character varying(100),
    pat_id character varying(100),
    line integer,
    surgeon_name character varying(100),
    role character varying(100),
    or_service character varying(100),
    start_time timestamp with time zone,
    end_time timestamp with time zone,
    total_length integer,
    panel integer,
    surg_id character varying(100),
    role_c integer,
    service_c character varying(100)
);


ALTER TABLE ehr.ophthalmologysurgerysurgeon OWNER TO ophuser;

--
-- Name: ophthalmologyvisitsummary; Type: TABLE; Schema: ehr; Owner: ophuser
--

CREATE TABLE ehr.ophthalmologyvisitsummary (
    pat_enc_csn_id integer,
    pat_mrn character varying(100),
    pat_id character varying(100),
    title character varying(100),
    followup_number integer,
    followup_unit character varying(100),
    followup_info character varying(100),
    prn_text character varying(100),
    hpi character varying(100),
    tech_comment character varying(100),
    pat_ocular_history character varying(100)
);


ALTER TABLE ehr.ophthalmologyvisitsummary OWNER TO ophuser;

--
-- PostgreSQL database dump complete
--

