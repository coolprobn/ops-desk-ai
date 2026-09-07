require "test_helper"

class CustomersIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
    @acme_inc = customers(:acme_inc)
  end

  test "visits customers list" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get customers_path

    assert_select "a", text: "Acme Corp"
  end

  test "visits a customer" do
    sign_in_as(@alex, organization: organizations(:globex))

    get customer_path(@acme_inc)

    assert_select "h1", text: "Acme Inc"
    assert_select "h2", text: "Subscriptions"
    assert_select "a", text: subscriptions(:acme_inc_enterprise).plan_name
    assert_select "h2", text: "Invoices"
    assert_select "a", text: I18n.l(invoices(:acme_inc_paid).issued_at, format: :short)
    assert_select "h2", text: "Support cases"
    assert_select "a", text: support_cases(:acme_inc_enterprise_addendum).subject
  end
end
