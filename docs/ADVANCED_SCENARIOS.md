# Five reproducible production-support scenarios

**Environment:** SQLite in-memory, Python 3 standard library, synthetic payments and support tickets. No live payment system, personal information or employer-specific logs are used.

| # | Scenario | SQL file | Expected result | Next investigation action |
|---|---|---|---|---|
| 1 | Failed payments | `queries/04_failed_payment_investigation.sql` | 3 failed payments: 1002, 1006, 1009 | Correlate gateway traces; verify external settlement state before retries |
| 2 | Suspected duplicates | `queries/05_duplicate_detection.sql` | 1 candidate group: ORD-103, 2 attempts | Review idempotency key, acquirer response and ledger before claiming double charge |
| 3 | P1/P2 incidents | `queries/06_p1_p2_incident_analysis.sql` | 4 tickets, including 2 P1 cases | Establish timeline, scope, mitigation, communication and RCA |
| 4 | Query optimization | `queries/07_query_optimization.sql` | Query plan and 3 failed-payment rows | Compare query plans and indexes on representative workloads |
| 5 | SLA breaches | `queries/08_sla_breach_analysis.sql` | Breached cases 502 and 504 | Validate policy calendar, response timestamps and escalation records |

## How to reproduce

```bash
python scripts/run_demo.py
python -m unittest discover -s tests -v
```

## Triage method
1. Record the incident reference, detection time, impact and priority.
2. Establish the exact query window and currency/merchant scope.
3. Correlate payment IDs and event timelines; distinguish observation from hypothesis.
4. Avoid state-changing SQL in production without approval.
5. Confirm external bank/acquirer or settlement truth before retrying payments.
6. Record mitigation, owner, follow-up action and evidence for RCA.

## Important limitations
- `payment.status` is a simplified educational state, **not** a complete accounting ledger.
- Duplicate matching is heuristic and can produce false positives.
- SLA targets and support cases are invented; a real SLA may use business hours and exclusions.
- Times are fixed text timestamps to make the lab deterministic; production systems require time-zone-aware timestamps.
- Small synthetic tables do not establish real performance gains; EXPLAIN is a learning aid, not a benchmark.
