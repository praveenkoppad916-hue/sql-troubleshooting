# SQL Troubleshooting Knowledge Base

**Practical SQL investigations for payment operations, application support and production incident response.**

![SQLite](https://img.shields.io/badge/SQL-SQLite-0b7285) ![Focus](https://img.shields.io/badge/Focus-Production%20Support-24486c) ![Data](https://img.shields.io/badge/Data-100%25%20Synthetic-26734d)

A hands-on learning and demonstration repository by **Praveen Koppad**, Technical Support & Implementation Engineer. Explore realistic, **fictional** payment records to investigate failed transactions, pending payments, suspected duplicates and performance concerns using reproducible SQL.

> **Scope:** This is an independent educational lab. It does not contain employer source code, customer records, proprietary system diagrams or claims about specific real-world incidents.

## What you can explore
| Area | Techniques | Example question |
|---|---|---|
| Payment failures | JOIN, WHERE, GROUP BY | Which failure codes recur? |
| Possible duplicates | Composite grouping, HAVING | Which order references appear more than once? |
| Stale pending payments | Timestamp arithmetic | Which payments have remained pending beyond a threshold? |
| Event correlation | LEFT JOIN, ORDER BY | What happened before a payment timeout? |
| Merchant health | Conditional aggregation | Which merchants show elevated failure rates in the sample? |
| Query tuning | Indexes, EXPLAIN QUERY PLAN | Is the database using an appropriate index? |

## Architecture at a glance
```mermaid
flowchart LR
  A[Merchant] --> B[Payment service]
  B --> C[(Payments)]
  B --> D[(Incident events)]
  C --> E[SQL diagnostics]
  D --> E
  E --> F[Incident triage and RCA]
```

For the full conceptual architecture and data model, see [Architecture](docs/ARCHITECTURE.md).

## Run locally (Python 3; no extra packages)
From the repository root:

```bash
python scripts/run_demo.py
```

The script creates an **in-memory SQLite database**, loads the schema and fictional data, and executes the example query files. It does not connect to a live database.

Run verification tests:

```bash
python -m unittest discover -s tests -v
```

## Repository map
```text
sql-troubleshooting/
├── README.md
├── schema/
│   ├── 01_schema.sql
│   └── 02_seed.sql
├── queries/
│   ├── 01_foundations.sql
│   ├── 02_incident_investigations.sql
│   └── 03_performance.sql
├── docs/
│   ├── ARCHITECTURE.md
│   ├── INCIDENT_RUNBOOK.md
│   └── LEARNING_PATH.md
├── scripts/run_demo.py
├── tests/test_queries.py
├── .gitignore
└── LICENSE
```

## Investigation notes
- Duplicate external references are **candidates for review**, not proof of double settlement.
- A gateway timeout does **not** establish whether funds moved.
- Financial values are stored in **minor currency units** (`amount_cents`); avoid summing unlike currencies.
- Timestamps here are illustrative strings. Production systems need explicit time-zone handling.
- Query syntax targets **SQLite**; PostgreSQL, MySQL and SQL Server may require changes.

## Author
**Praveen Koppad** · [Professional portfolio](https://praveenkoppad916-hue.github.io/) · [GitHub](https://github.com/praveenkoppad916-hue)

**Suggested next steps:** Expand this lab with idempotency, refund ledgers, reconciliation reports, and a synthetic REST API.
