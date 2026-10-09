-- Scenario 5: First-response SLA by ticket priority.
-- Fixed timestamp for open/unanswered cases; thresholds are fictional.
-- ROUND avoids floating-point minute-boundary misclassification.
SELECT c.case_id, c.priority, c.state, t.response_minutes AS target_minutes,
       c.opened_at, c.first_response_at,
       ROUND((julianday(COALESCE(c.first_response_at, '2026-01-10 10:30:00'))
             - julianday(c.opened_at)) * 1440, 2) AS response_minutes,
       CASE WHEN ROUND((julianday(COALESCE(c.first_response_at, '2026-01-10 10:30:00'))
                    - julianday(c.opened_at)) * 1440, 2) > t.response_minutes
            THEN 'BREACHED' ELSE 'MET' END AS sla_result
FROM support_cases c JOIN sla_targets t ON t.priority = c.priority
ORDER BY c.case_id;
