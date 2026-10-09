
# SQL Troubleshooting & Production Support

## Overview

A hands-on SQL portfolio demonstrating database troubleshooting, data validation, and incident investigation techniques relevant to L2/L3 Production Support Engineering.

This project uses PostgreSQL and fictional banking transaction scenarios to demonstrate practical SQL troubleshooting skills.

## Technologies & Skills

- SQL and PostgreSQL
- Database Troubleshooting
- L2/L3 Production Support
- Transaction Monitoring and Analysis
- Root Cause Analysis (RCA)
- Data Validation and Incident Investigation

## Project Objectives

- Investigate failed transactions using SQL queries.
- Identify duplicate records and missing data.
- Analyse transaction failures and error patterns.
- Practise SQL JOINs, GROUP BY, HAVING, and subqueries.
- Develop structured troubleshooting approaches.

## Planned Project Structure

- `database/` — Sample database schemas and fictional data
- `queries/` — SQL troubleshooting examples
- `incidents/` — Simulated production incident investigations
- `docs/` — Troubleshooting guides and explanations

## Example: Identifying Failed Transactions

```sql
SELECT
    transaction_id,
    customer_id,
    amount,
    status,
    created_at
FROM transactions
WHERE status = 'FAILED'
ORDER BY created_at DESC;
```

### Explanation

This query retrieves failed transactions and sorts them by the most recent transaction time. It can help support engineers identify transaction-processing failures and investigate incident patterns.

The query requires a `transactions` table with the columns shown above. A fictional sample database will be added to make the example executable.

## Data Privacy & Security

All examples use fictional data and simulated scenarios. No confidential production data, customer records, credentials, or proprietary employer information is included.

## Future Enhancements

- Advanced SQL troubleshooting queries
- Transaction failure analysis
- Database performance investigation
- Sample RCA documentation
- Automated data validation scripts

## Project Purpose

This repository is being developed as a practical technical portfolio showcasing SQL troubleshooting, database investigation, and production support engineering skills.
