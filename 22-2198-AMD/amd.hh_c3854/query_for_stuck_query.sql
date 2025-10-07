SELECT
    pid,
    usename AS user,
    datname AS database,
    state,
    query_start,
    now() - query_start AS duration,
    query
FROM
    pg_stat_activity
WHERE
    state != 'idle'
    AND now() - query_start > interval '1 minutes'
ORDER BY
    duration DESC;



-- ex

-- SELECT pg_terminate_backend(188543);