DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T1_Person;
CREATE TABLE coris_registry.C3304_GBQ_T1_Person(
    arb_person_id bigint,
    primarymrn bigint,
    birthdate timestamp without time zone, -- birthdate varchar(100)
    name varchar(100),
    sex varchar(100),
    race varchar(100),
    ethnicity varchar(100),
    primarylanguage varchar(100),
    needinterpreter varchar(100),
    payorfinancialclass varchar(100),
    zipcode varchar(100),
    deceasedyn varchar(100),
    cdphe_dod timestamp without time zone, -- varchar(100),
    dateofdeathemr timestamp without time zone, -- varchar(100),
    causeofdeath varchar(1000)
);