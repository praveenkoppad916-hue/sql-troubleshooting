-- Scenario 3: P1/P2 ticket timeline and correlated payment status.
-- Analysis timestamp is fixed for reproducibility; not a live incident feed.
SELECT c.case_id, c.priority, c.state, c.summary, p.payment_id,
       p.status AS payment_status, p.failure_code,
       c.opened_at, c.first_response_at, c.resolved_at,
       ROUND((julianday(COALESCE(c.resolved_at, '2026-01-10 10:30:00'))
             - julianday(c.opened_at)) * 1440, 1) AS elapsed_minutes
FROM support_cases c LEFT JOIN payments p ON p.payment_id = c.payment_id
WHERE c.priority IN ('P1','P2')
ORDER BY CASE c.priority WHEN 'P1' THEN 1 ELSE 2 END, c.opened_at;
