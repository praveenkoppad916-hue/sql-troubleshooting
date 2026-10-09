-- Scenario 2: Potential duplicate requests, NOT confirmed double charges.
-- Same merchant, order reference, currency and amount is only a review signal.
SELECT m.merchant_name, p.external_reference, p.currency, p.amount_cents,
       COUNT(*) AS attempts, COUNT(DISTINCT p.payment_id) AS distinct_payments,
       GROUP_CONCAT(p.payment_id) AS payment_ids
FROM payments p JOIN merchants m ON m.merchant_id = p.merchant_id
GROUP BY p.merchant_id, m.merchant_name, p.external_reference,
         p.currency, p.amount_cents
HAVING COUNT(*) > 1
ORDER BY attempts DESC, p.external_reference;
