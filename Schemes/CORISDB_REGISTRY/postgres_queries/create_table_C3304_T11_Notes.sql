DROP TABLE IF EXISTS coris_registry.C3304_T11_Notes_20250923;
CREATE TABLE coris_registry.C3304_T11_Notes_20250923
(
  arb_person_id BIGINT,
  arb_encounter_id BIGINT,
  encounter_date TIMESTAMP,
  NoteEpicId TEXT,
  NoteType TEXT,
  NoteText TEXT,
  ProviderName TEXT
);

