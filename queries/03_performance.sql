-- Inspect the planner's chosen access path (SQLite).
EXPLAIN QUERY PLAN SELECT payment_id, created_at FROM payments WHERE status='FAILED' AND created_at >= '2026-01-10';
-- Index is declared in schema/01_schema.sql. Compare query plans before/after in a disposable DB.
-- Avoid SELECT * in production-facing investigations; limit columns and time ranges.
SELECT payment_id, external_reference, failure_code FROM payments
WHERE status='FAILED' AND created_at BETWEEN '2026-01-10 09:00:00' AND '2026-01-10 10:00:00'
ORDER BY created_at DESC LIMIT 50;
