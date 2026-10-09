# Synthetic payment troubleshooting architecture

```mermaid
flowchart LR
  A[Merchant request] --> B[Payment service]
  B --> C[(Payments table)]
  B --> D[Gateway or bank simulation]
  D --> E[Status and event updates]
  E --> C
  E --> F[(Incident events)]
  C --> G[Support SQL investigations]
  F --> G
  G --> H[Evidence-based incident RCA]
```

This is a **conceptual teaching model**, not an internal company architecture or a production integration. All records are fictional. The project runs on SQLite for zero-dependency local practice. SQL dialects and production payment semantics vary.

## Data model

```mermaid
erDiagram
  MERCHANTS ||--o{ PAYMENTS : owns
  PAYMENTS ||--o{ INCIDENT_EVENTS : records
  MERCHANTS { int merchant_id PK string merchant_name string region }
  PAYMENTS { int payment_id PK int merchant_id FK string external_reference int amount_cents string currency string status string failure_code string created_at string updated_at }
  INCIDENT_EVENTS { int event_id PK int payment_id FK string event_type string details string event_at }
```
