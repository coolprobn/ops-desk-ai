require "test_helper"

class SubscriptionAccessIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
    @foreign_subscription = subscriptions(:acme_inc_enterprise)
  end

  test "guests cannot access subscriptions list page" do
    get subscriptions_path

    assert_redirected_to new_session_path
  end

  test "guests cannot access a subscription detail page" do
    get subscription_path(@foreign_subscription)

    assert_redirected_to new_session_path
  end

  test "cannot access a subscription from another organization" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get subscriptions_path
    assert_select "a", text: "Acme Inc", count: 0
    assert_select "a", text: @foreign_subscription.plan_name, count: 0

    get subscription_path(@foreign_subscription)
    assert_response :not_found
  end
end
