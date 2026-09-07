require "test_helper"

class SubscriptionsIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
    @subscription = subscriptions(:acme_corp_business)
  end

  test "visits subscriptions list" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get subscriptions_path

    assert_select "a", text: "Acme Corp"
  end

  test "visits a subscription" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get subscription_path(@subscription)

    assert_select "h1", text: @subscription.plan_name
    assert_select "a", text: "Acme Corp"
    assert_includes response.body, I18n.l(@subscription.started_at, format: :short)
    assert_includes response.body, I18n.l(@subscription.renewal_at, format: :short)
  end
end
