DROP TABLE IF EXISTS coris_registry.C3304_GBQ_T11_Notes;
CREATE TABLE coris_registry.C3304_GBQ_T11_Notes
(
  Arb_Person_Id BIGINT,
  arb_encounter_id BIGINT,
  NoteEpicId TEXT,
  NoteType TEXT,
  NoteText TEXT,
  ProviderName TEXT,
  DateOfNote DATE,
  TimeOfNote TIME
);

