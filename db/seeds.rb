require "active_record/fixtures"

fixtures_dir = Rails.root.join("test/fixtures")
fixture_files =
  Dir[fixtures_dir.join("*.yml")].map { |path| File.basename(path, ".yml") }

ActiveRecord::FixtureSet.create_fixtures(fixtures_dir, fixture_files)

puts "Seeded #{Organization.count} orgs, #{User.count} users, #{Membership.count} memberships, #{Customer.count} customers, #{Subscription.count} subscriptions, #{Invoice.count} invoices, #{SupportCase.count} cases, #{KnowledgeDocument.count} docs."
