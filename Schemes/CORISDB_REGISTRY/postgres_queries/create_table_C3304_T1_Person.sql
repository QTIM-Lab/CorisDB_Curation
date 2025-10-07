DROP TABLE IF EXISTS coris_registry.C3304_T1_Person_20250923;
CREATE TABLE coris_registry.C3304_T1_Person_20250923
(
  Arb_Person_Id BIGINT,
  PrimaryMrn TEXT,
  BirthDate DATE,
  Name TEXT,
  Sex TEXT,
  Race TEXT,
  Ethnicity TEXT,
  PrimaryLanguage TEXT,
  NeedInterpreter TEXT,
  PayorFinancialClass TEXT,
  ZipCode TEXT,
  DeceasedYN TEXT,
  CDPHE_DOD DATE,
  DateOfDeathEMR DATE,
  CauseOfDeath TEXT
);

