-- Filter and sort: most recent unsuccessful payments
SELECT payment_id, external_reference, status, failure_code, created_at
FROM payments WHERE status IN ('FAILED','PENDING') ORDER BY created_at DESC;
-- JOIN: merchant context for failed payments
SELECT p.payment_id, m.merchant_name, p.failure_code, p.amount_cents, p.currency
FROM payments p JOIN merchants m ON m.merchant_id=p.merchant_id WHERE p.status='FAILED';
-- GROUP BY / HAVING: merchants with at least two payments
SELECT m.merchant_name, COUNT(*) AS payment_count
FROM payments p JOIN merchants m ON m.merchant_id=p.merchant_id
GROUP BY m.merchant_id, m.merchant_name HAVING COUNT(*) >= 2 ORDER BY payment_count DESC;
-- CTE: failed payment count by failure code
WITH failures AS (SELECT failure_code FROM payments WHERE status='FAILED')
SELECT failure_code, COUNT(*) AS failures FROM failures GROUP BY failure_code ORDER BY failures DESC;
-- Window function: latest payment per merchant
SELECT * FROM (SELECT p.*, ROW_NUMBER() OVER (PARTITION BY merchant_id ORDER BY created_at DESC, payment_id DESC) AS rn FROM payments p) ranked WHERE rn=1;
