pg_dump \
  -h localhost \
  -U ophuser \
  -d coris_db \
  --schema=ehr \
  -s \
  -f /projects/coris_db/postgres/erd/coris_db-ehr.sql

pg_dump \
  -h localhost \
  -U ophuser \
  -d coris_db \
  --schema=ehr \
  -s \
  -f /projects/coris_db/postgres/erd/coris_db-axispacs_snowflake.sql

pg_dump \
  -h localhost \
  -U ophuser \
  -d coris_db \
  --schema=ehr \
  -s \
  -f /projects/coris_db/postgres/erd/coris_db-axispacs_snowflake.sql


pg_dump \
  -h localhost \
  -U ophuser \
  -d coris_db \
  --schema=ehr \
  -s \
  -f /projects/coris_db/postgres/erd/coris_db-axispacs_snowflake.sql
