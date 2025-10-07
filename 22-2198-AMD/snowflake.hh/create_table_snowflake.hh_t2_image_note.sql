-- Active: 1742840235060@@127.0.0.1@5432@coris_db@coris_registry
DROP TABLE IF EXISTS hh_t2_image_note_20250519;
CREATE TABLE hh_t2_image_note_20250519
(
        ptid BIGINT
        ,devproc TEXT
        ,date_key BIGINT
        ,images TEXT
        ,notes TEXT
);

