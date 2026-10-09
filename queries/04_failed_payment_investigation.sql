-- Scenario 1: Correlate failed payments to merchants and event history.
-- A timeout is not proof that funds did or did not move; reconcile externally.
SELECT p.payment_id, m.merchant_name, p.external_reference, p.currency,
       p.amount_cents, p.failure_code, p.created_at,
       COALESCE(GROUP_CONCAT(e.event_type, ' -> '), 'NO_EVENT') AS event_types
FROM payments p
JOIN merchants m ON m.merchant_id = p.merchant_id
LEFT JOIN incident_events e ON e.payment_id = p.payment_id
WHERE p.status = 'FAILED'
GROUP BY p.payment_id, m.merchant_name, p.external_reference,
         p.currency, p.amount_cents, p.failure_code, p.created_at
ORDER BY p.created_at;
