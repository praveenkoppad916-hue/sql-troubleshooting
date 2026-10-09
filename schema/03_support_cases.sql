-- Synthetic incident tickets and SLA policy, not employer data.
CREATE TABLE IF NOT EXISTS support_cases (
 case_id INTEGER PRIMARY KEY, payment_id INTEGER REFERENCES payments(payment_id),
 priority TEXT NOT NULL CHECK(priority IN ('P1','P2','P3')),
 opened_at TEXT NOT NULL, first_response_at TEXT,
 resolved_at TEXT, state TEXT NOT NULL CHECK(state IN ('OPEN','RESOLVED')),
 summary TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS sla_targets (
 priority TEXT PRIMARY KEY, response_minutes INTEGER NOT NULL CHECK(response_minutes > 0)
);
CREATE INDEX IF NOT EXISTS idx_cases_priority_opened ON support_cases(priority, opened_at);
CREATE INDEX IF NOT EXISTS idx_cases_payment ON support_cases(payment_id);
