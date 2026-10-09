# Production-support investigation runbook (practice)

## Scenario 1 — Payment failed with BANK_TIMEOUT
1. Capture a **sanitized** payment reference, time window, merchant and reported symptom.
2. Query `payments` for the exact reference and confirm status and failure code.
3. Query `incident_events` in chronological order to correlate the upstream timeout.
4. Check gateway callback / settlement confirmation in the *real* system before suggesting a retry. A timeout does not prove a charge failed.
5. Record impact, timeline, evidence, next owner and follow-up; escalate if reconciliation is needed.

## Scenario 2 — Possible duplicate payment
1. Group by merchant, external reference, amount and currency to find candidate repeats.
2. Inspect payment IDs, event history and idempotency behavior.
3. Verify gateway captures and settlement records before calling a duplicate charge confirmed.
4. Escalate any refund/reversal to authorized operations; do not manually modify financial records.

## Scenario 3 — Pending payment
1. Calculate elapsed pending time against an explicitly chosen analysis timestamp.
2. Review latest event, callbacks and any queue/backlog telemetry.
3. Check the defined SLA and payment method's settlement behavior.
4. Escalate stale transactions; never change a status solely to clear an alert.

## RCA template
**Incident:** | **Impact:** | **Detection:** | **Timeline (UTC/local explicit):** | **Evidence:** | **Root cause (confirmed vs hypothesis):** | **Mitigation:** | **Preventive action:** | **Owner:**

**Security:** All examples use synthetic data. Do not publish customer identifiers, tokens, production logs or proprietary queries.
