require "application_system_test_case"

class SubscriptionsTest < ApplicationSystemTestCase
  test "visits subscriptions list" do
    sign_in_as(users(:alex))

    visit subscriptions_path

    assert_selector "h1", text: "Subscriptions"
  end

  test "visits a subscription" do
    sign_in_as(users(:alex))

    visit subscription_path(subscriptions(:acme_corp_business))

    assert_selector "h1", text: "Business"
  end
end
