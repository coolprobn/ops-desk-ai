# Ops Desk

Week 1 SaaS foundation for a customer operations desk. Organizations, memberships, users, customers, subscriptions, invoices, support cases, and knowledge documents. No LLM, tools, or agent loop yet. A user belongs to organizations through membership. Role is per membership.

## Setup

Ruby 4.0, Node 24 (nvm is fine), and PostgreSQL 16. `bin/setup` runs `bundle install` and `npm install`.

```bash
bin/setup
bin/rails db:seed
bin/dev
```

Demo data lives in `test/fixtures`. `bin/rails db:seed` and `bin/rails db:fixtures:load` load the same rows.

Open http://localhost:3000 and sign in.

Northwind admin (also Globex operator): `alex@northwind.test` / `password`

Globex admin: `sam@globex.test` / `password`

Alex belongs to both orgs. The sidebar switches the current tenant. Acme Corp lives on Northwind. Acme Inc lives on Globex.

## Tests

```bash
bin/rails test
```

## What this is not

This is not the AI ops agent. Week 2 starts structured case summarization on top of this data.
