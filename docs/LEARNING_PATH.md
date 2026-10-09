# Suggested study sequence
1. **Foundations:** Run joins, aggregates, CTEs and window functions from `queries/01_foundations.sql`.
2. **Incident investigation:** Run `queries/02_incident_investigations.sql`; explain why correlation is not proof of causation.
3. **Performance:** Inspect `EXPLAIN QUERY PLAN` and indexes in `queries/03_performance.sql`.
4. **RCA:** Use `docs/INCIDENT_RUNBOOK.md` to draft an evidence-based incident report.
5. **Extension:** Add tests, synthetic refund events, idempotency keys and reconciliation ledger tables.

## Interview discussion prompts
- How would you distinguish an upstream timeout from a confirmed failed debit?
- What is the difference between a duplicate order reference and duplicate capture?
- Why do `WHERE` and `HAVING` solve different filtering problems?
- When can an index make reads faster but writes more expensive?
- How would you protect sensitive fields in troubleshooting logs?
