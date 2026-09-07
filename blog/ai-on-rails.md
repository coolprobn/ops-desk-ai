# AI on Rails: a beginner's guide to integrating AI features in a Rails app

This series teaches you how to add AI to a Rails SaaS the way a production app has to live with it. One product. Thirteen weeks. The model comes after the tenancy, the tests, and the data.

A chat demo is not a production feature. An operator who asks "why did Acme's bill double?" needs customer records, invoices, subscriptions, knowledge, and a hard wall between organizations. If those are missing, the model will sound confident on the wrong tenant's data.

## What you build

The app is a customer operations desk named Ops Desk. An organization has customers, subscriptions, invoices, support cases, and knowledge documents. Operators sign in, pick a tenant, and look up billing and support facts.

Week 1 ships that SaaS with no LLM. Later weeks add AI on the same domain:

- structured case summarization
- tools
- RAG over org knowledge, with citations and a refusal when evidence is missing
- a deterministic workflow versus an agent, on the same billing question
- human approval and an audit trail for writes
- evals, traces, security, then MCP on the same tools

The curriculum table lives in the [README](../README.md).

## Who this is for

You can follow a Rails app. You have not yet shipped an AI feature that other people depend on. You want the product shape, not a notebook.

The series assumes PostgreSQL, Minitest, and HTML controllers. It does not assume you have used an LLM API.

## How to read it

Start with [week 1](ai-on-rails-generate-rails-saas-app.md). That post is about generation speed, the missing authorization layer, and the tests and Cursor rules that turned a scaffold into a tenant-safe SaaS.

From week 2, each week lands as a pull request on this repo. Read the post, then the PR. The app is the lesson.

The repo is [ops-desk-ai](https://github.com/coolprobn/ops-desk-ai). The README has setup and the two demo accounts. Acme Corp is Northwind. Acme Inc is Globex. They must never share a page.
