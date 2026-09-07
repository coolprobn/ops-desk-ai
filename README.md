# Ops Desk

A Rails SaaS used to learn production AI integration on one product.

The app is a customer operations desk. Organizations have customers, subscriptions, invoices, support cases, and knowledge documents. Operators investigate billing and support questions. Later weeks add an LLM, tools, a deterministic workflow, an agent, human approval, evals, and MCP on the same tools.

## Setup

You need Ruby 4.0, Node 24, and PostgreSQL 16.

```bash
bin/setup
bin/rails db:seed
bin/dev
```

`bin/setup` runs `bundle install` and `npm install`. Demo data lives in `test/fixtures`. `bin/rails db:seed` and `bin/rails db:fixtures:load` load the same rows.

Open http://localhost:3000 and sign in.

| Account | Password | Role |
|---|---|---|
| `alex@northwind.test` | `password` | Northwind admin, also Globex operator |
| `sam@globex.test` | `password` | Globex admin |

Alex belongs to both orgs. The sidebar switches the current tenant. Acme Corp is Northwind. Acme Inc is Globex.

```bash
bin/rails test
```

## Curriculum

Thirteen weeks. One Rails app. Each week adds one production AI concern on the same domain.

| Week | Topic |
|---:|---|
| 1 | Multi-tenant Rails SaaS (membership, customers, billing data, knowledge). No LLM yet. |
| 2 | LLM integration with structured output (case summarization). |
| 3 | Tools. Hand-roll the tool loop once, then `ruby_llm`. |
| 4 | RAG over org knowledge, with citations and refusal when evidence is missing. |
| 5 | Deterministic AI workflow. Rails owns money and dates. The model explains. |
| 6 | Agent. The model chooses tools. Same billing question as week 5, different architecture. |
| 7 | Write and dangerous actions with human approval and an audit trail. |
| 8 | Reliability. Jobs, retries, truncation, fail-closed, cancel, idempotency. |
| 9 | Evals from error analysis, not a giant scenario bank on day one. |
| 10 | Observability UI on persisted traces (cost, latency, tool calls). |
| 11 | Security. Prompt injection, tenant isolation, untrusted model output. |
| 12 | MCP. Same tools, Cursor as the client, tenant and approval still apply. |
| 13 | Polish. Demo the Acme bill-doubled case on the workflow and the agent. |

From week 2, each week will have a pull request. Use those PRs to see what that week added.

## Current status

Week 1 is done. The SaaS foundation is in place. LLM work has not started. The week 1 write-up is [A multi-tenant Rails SaaS in 15 minutes](blog/ai-on-rails-generate-rails-saas-app.md). The series intro is [AI on Rails](blog/ai-on-rails.md).
