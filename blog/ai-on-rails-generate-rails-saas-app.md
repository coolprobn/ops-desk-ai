# AI on Rails - Part 1: Generate a Rails SaaS app

This is week 1 of 13 in [AI on Rails](ai-on-rails.md). No LLM in the app yet.

An agent can scaffold a multi-tenant Rails SaaS in about 15 minutes. Rails 8, PostgreSQL, Minitest, esbuild, membership, seeded orgs, HTML for customers, invoices, subscriptions, cases, and knowledge. That part is real. Screens load. You can sign in.

Fifteen minutes does not give you a production-grade SaaS. The agent left authorization out. That is a security hole, not a follow-up ticket. This week is the work after the scaffold. The goal is a customer operations desk that could hold an LLM later without leaking one org into another.

## What the agent got right

The domain is an ops desk. An organization has customers, subscriptions, invoices, support cases, and knowledge documents. Two tenants exist from day one. Northwind has Acme Corp. Globex has Acme Inc. Same company name, different org. That fixture is the first security lesson.

Tenancy is membership, not `users.organization_id`. A user belongs to many orgs. Role lives on `Membership`. `Session` is identity only. The current tenant is a signed `organization_id` cookie checked against a membership row. Destroying an org destroys memberships, not users.

Routes stay REST. Front-end JS is esbuild, not importmap. Money is integer cents. The view divides by `100.0` and calls `number_to_currency`.

`ruby_llm` is not installed. The rule is already in the repo. When AI work starts, that gem is the only client.

## What it left out

The generate pass had no authorization. Membership and a tenant cookie are identity and context. They do not decide whether this actor may switch org, or load this record. Without a policy check on the record, a signed-in user is one guessed id away from data they should not see. That would have been a production incident, not a polish item.

We added Action Policy after generate, on instruction. Then we tightened it.

The first tests grepped the Gemfile, asserted `enum.keys`, and read migrations. That is not coverage. A test has to name an actor, a starting point, an action, and an observable. Validation errors, persisted rows, HTTP status, copied page text. If the test can pass while the page is wrong, delete it.

Several HTML controllers had no HTTP tests at all. Dashboard, cases, invoices, subscriptions, and knowledge were missing. Guests could be untested on index while show was covered, or the reverse. Those are two entry points.

System tests logged in through the sign-in form on every visit. Slow, and it retested authentication. The session system test is the one place that submits Email and Password. Other system tests plant a signed `session_id` cookie.

Knowledge isolation looked covered and was not. Globex docs used the same titles as Northwind, `Refund policy` and `Pricing policy`. The access test asserted Northwind titles and a globex show 404. A leaked index would still have passed. Foreign copied-text on a list has to be unique across tenants, then `count: 0`.

The agent also wrote currency format tests, visit-only `new` and `edit` tests next to the submit tests, and a guest sign-out test that duplicated logout. Those went away.

## What we changed

The SaaS shape stayed. Authorization became a real layer instead of an assumed one.

`ApplicationPolicy` closes index, show, new, create, edit, update, and destroy. Resource policies open only what they need. Org-owned lists and finds go through `authorized_scope`, not `current_organization.customers`. `authorize :user` in ApplicationController is context wiring, not a resource check. Controllers that mutate call `authorize!` on the record. Association find through `current_user.organizations` is not authorization. Org switch authorizes the `Organization` row with `CurrentOrganizationPolicy`, then remembers the tenant. Policy denial redirects to root with flash `Not authorized`. Tenant isolation through `authorized_scope.find` stays 404. Those failures are different. Do not unify them. Views and controllers call `current_user`, not `Current.user`. `current_organization` stays for the sidebar name and the org switcher.

Every HTML controller now has three files when the rule asks for them. `{resource}_integration_test.rb` is the authorized visit. `{resource}_access_integration_test.rb` is cannot only. `test/system/{resource}_test.rb` uses the Rails generator name. Passwords are public, so they have no access file. Session destroy is `logs out the user`, so there is no session access file. `/up` has integration only.

Index and show stay visit-only. Create and update visit the form and submit in the same test. Show asserts the record and the associated records the page renders. Guest deny is one test per action. Isolation names omit `user`. Unauthenticated actors are `guests`.

CI installs Chrome for system tests.

## Rules that came out of the corrections

Every time a generation mistake got corrected, the instance was fixed and a focused Cursor rule landed under `.cursor/rules/`. One concern per file. Product behavior gets Minitest. Agent process gets an `.mdc` with a failing example and the required shape. The folder is meant to copy into the next greenfield Rails app.

The testing lessons now live in one growing file, `minitest-rails.mdc`. Do not add another test-pattern rule. Access, one edge case, and outcomes still have their own files. Those files must not contradict `minitest-rails.mdc`.

The mistakes that kept coming back:

- generate with no `authorize!` on the record
- tests that grep source or assert implementation
- one assertion per test instead of one edge case
- HTML tests under `test/controllers/`
- happy path inside an access file
- association find treated as authz
- org or role on `User` or `Session`
- `manage?` as a catch-all
- non-boolean database defaults
- frozen `%w` plus `inclusion` instead of `enum`
- shared titles used to prove tenant exclusion

The catalog is in [`.cursor/rules/README.md`](../.cursor/rules/README.md).

## What you should take to the next app

Generate the SaaS. Then look for `authorize!` before you look at styling. A membership cookie is not a policy.

Seed two orgs and two customers whose names collide on purpose. Write an access test that fails if the list leaks. If the copied text is the same in both tenants, the test is lying.

Do not install an LLM client until the pages, the membership cookie, and the 404 versus `Not authorized` split are boring.

## Next

Week 2 adds structured case summarization on this data. Same tenants. Same cases. Now a model is allowed in the app.
