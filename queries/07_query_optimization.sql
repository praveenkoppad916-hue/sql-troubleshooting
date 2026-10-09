-- Scenario 4: Observe index selection for status + created_at.
-- The EXPLAIN output depends on SQLite version and statistics.
EXPLAIN QUERY PLAN
SELECT payment_id, external_reference, failure_code
FROM payments
WHERE status = 'FAILED' AND created_at >= '2026-01-10 09:00:00'
ORDER BY created_at;
-- Compare the corresponding indexed query result.
SELECT payment_id, external_reference, failure_code
FROM payments
WHERE status = 'FAILED' AND created_at >= '2026-01-10 09:00:00'
ORDER BY created_at;
