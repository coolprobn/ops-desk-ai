# AI on Rails - Part 1: Generate a Rails SaaS app

Series: AI on Rails
Week: 1 of 13 (SaaS foundation, no LLM yet)

Daily log. Later this becomes a post. Notes, not a polished essay. One file for this week. A new `## YYYY-MM-DD` section each day until the Week 1 outcome is reached.

## What this series is

I already shipped a RAG chat app once. That was the whole AI story. This time I am going through a 13-week production plan on one Rails product so I can add AI to the next SaaS and know what I am doing.

The product is an AI customer operations desk. Organizations, customers, subscriptions, invoices, support cases, knowledge. The agent comes later. Week 1 is the boring foundation on purpose.

Plan: LLMs, tools, RAG again, then deterministic workflows vs agents, human approval, evals, observability, security, and MCP on the same tool registry.

## 2026-09-03

Generated the Rails SaaS and started tightening it.

Repo is `ops-desk-ai`. Rails 8, PostgreSQL, Minitest, esbuild. Multi-tenant membership: a user belongs to orgs through `Membership`. Role lives on the membership. Session is identity only. Current tenant is a signed `organization_id` cookie checked against a membership row. Action Policy scopes org-owned records. Default deny on the seven REST actions. HTML coverage is integration tests, not controller tests.

Seeded two orgs so isolation is real. Alex is Northwind admin and Globex operator. Sam is Globex admin. Acme Corp is Northwind. Acme Inc is Globex. Same company name, different tenant. That fixture is the first security lesson.

No `ruby_llm` yet. The rule is already written: when AI work starts, that gem is the only client.

### Tests

Agents hallucinate tests. They grep the Gemfile, assert `enum.keys`, read migrations, and call that coverage. I want outcomes. Actor, starting point, action, observable result. Validation errors, persisted rows, HTTP status, copied page text. One outcome per test so a failure names the broken fact.

Permission checks live in `*_access_integration_test.rb`. Display stays in the resource file. Seeing Acme Corp and not seeing Acme Inc are two tests.

I spent a lot of today on that, not on features.

### Rules for the next app

Every time I correct a generation mistake, I fix the instance and add a focused `.mdc` under `.cursor/rules/`. One concern per file. Product behavior gets Minitest. Agent process (how to write Rails) gets a Cursor rule. Those files are meant to copy into the SaaS template.

Today's pile includes: test outcomes, one outcome per test, fixtures `:all`, membership not org-on-user, no non-boolean DB defaults, enum for options, REST routes only, Action Policy default deny and `authorized_scope`, `current_user` not `Current.user` in views, esbuild not importmap, capture corrections, AI on Rails blog log (one file per week goal, `## YYYY-MM-DD` per day).

The point is not this repo. The point is the next greenfield Rails app starts less stupid.

### Still open

Week 1 is not done in my head. More tightening tomorrow. Then Week 2: structured case summarization on this data. I especially need to fix tests and define what and how to test current features because AI has added tests for implementation details instead of behavior.

Repo will go public. README and release notes as I go. Morning logs in `blog/`.
