# Greenfield Rails guardrails

Cursor rules captured from corrections while building this app. Copy `.cursor/rules/*.mdc` into another Rails app.

| Rule | Mistake it blocks |
|---|---|
| `capture-corrections.mdc` | Fixing a mistake without writing a rule |
| `test-outcomes.mdc` | Minitest that greps source or asserts implementation |
| `one-table-per-migration.mdc` | Several `create_table` calls in one migration |
| `saas-multi-tenant-membership.mdc` | Org or role on `users` or `sessions` instead of Membership |
| `no-non-boolean-db-defaults.mdc` | String or enum `default:` in a migration |
| `enum-for-options.mdc` | Frozen `%w` plus `inclusion` instead of `enum` |
| `use-ruby-llm.mdc` | Hand-rolled LLM client instead of `ruby_llm` |
| `current-user-helper.mdc` | `Current.user` in a controller or view |
| `esbuild-not-importmap.mdc` | importmap-rails or javascript_importmap_tags instead of jsbundling + esbuild |
| `fixtures-all.mdc` | Fixture name lists instead of `fixtures :all` |
| `rest-routes.mdc` | Non-REST verb helpers or custom actions without an allowlist entry |
| `action-policy-scoping.mdc` | Tenant queries via `current_organization.*` instead of `authorized_scope` |
| `search-rails-api-before-helpers.mdc` | Custom helpers (e.g. `format_money`) when Rails already has the API |
| `integration-tests-not-controllers.mdc` | HTML tests under `test/controllers/` instead of `test/integration/` |
| `one-outcome-per-test.mdc` | Several edge cases in one test, or one case split into many named tests |
| `action-policy-default-deny.mdc` | Open-by-omission policy actions or `manage?` catch-alls |
| `access-integration-tests.mdc` | Happy-path in access, a duplicate of an existing action test, or `user` in deny names |
| `authorize-the-record.mdc` | Association find treated as authz; Unauthorized mixed with tenant 404 |
| `ai-on-rails-blog-log.mdc` | A new `blog/` file per calendar day, or a date in the filename |
| `minitest-rails.mdc` | Missing controller HTTP/system coverage, verb-named tests, enum tests, or policy unit tests |

These rules are agent process guardrails per `test-outcomes.mdc`. Product behavior stays in outcome Minitest.
