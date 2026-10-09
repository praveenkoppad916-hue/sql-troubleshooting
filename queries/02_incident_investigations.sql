-- Case A: repeated merchant references are investigation candidates, NOT proof of duplicate charges.
SELECT merchant_id, external_reference, currency, amount_cents, COUNT(*) AS occurrences,
GROUP_CONCAT(payment_id) AS payment_ids
FROM payments GROUP BY merchant_id, external_reference, currency, amount_cents HAVING COUNT(*)>1;
-- Case B: timeout frequency by failure code
SELECT failure_code, COUNT(*) AS failure_count FROM payments
WHERE status='FAILED' GROUP BY failure_code ORDER BY failure_count DESC;
-- Case C: pending transactions as of a fixed synthetic analysis time (portable SQLite).
SELECT payment_id, external_reference, created_at,
CAST((julianday('2026-01-10 10:00:00')-julianday(created_at))*24*60 AS INTEGER) AS pending_minutes
FROM payments WHERE status='PENDING' AND created_at < '2026-01-10 09:45:00';
-- Case D: reconstruct event timeline for one incident
SELECT p.payment_id, p.status, e.event_type, e.details, e.event_at
FROM payments p LEFT JOIN incident_events e ON e.payment_id=p.payment_id
WHERE p.payment_id=1002 ORDER BY e.event_at;
-- Case E: merchant and currency-level payment health
SELECT m.merchant_name, p.currency, COUNT(*) AS total,
SUM(CASE WHEN p.status='SUCCESS' THEN 1 ELSE 0 END) AS successful,
SUM(CASE WHEN p.status='FAILED' THEN 1 ELSE 0 END) AS failed,
ROUND(100.0*SUM(CASE WHEN p.status='FAILED' THEN 1 ELSE 0 END)/COUNT(*),1) AS failed_pct
FROM payments p JOIN merchants m ON m.merchant_id=p.merchant_id
GROUP BY m.merchant_id,m.merchant_name,p.currency ORDER BY failed_pct DESC;
-- Case F: successful amounts only; refund accounting needs separate ledger semantics.
SELECT currency, SUM(amount_cents) AS successful_amount_cents FROM payments
WHERE status='SUCCESS' GROUP BY currency;
