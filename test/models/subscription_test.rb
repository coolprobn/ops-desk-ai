require "test_helper"

class SubscriptionTest < ActiveSupport::TestCase
  test "record is valid" do
    assert subscriptions(:acme_corp_business).valid?
  end

  test "requires plan_name" do
    subscription = organizations(:northwind).subscriptions.new

    refute subscription.valid?
    assert_includes subscription.errors[:plan_name], "can't be blank"
  end

  test "rejects a negative monthly price" do
    subscription = organizations(:northwind).subscriptions.new(monthly_price_cents: -1)

    refute subscription.valid?
    assert_includes subscription.errors[:monthly_price_cents], "must be greater than or equal to 0"
  end

  test "requires started_at" do
    subscription = organizations(:northwind).subscriptions.new

    refute subscription.valid?
    assert_includes subscription.errors[:started_at], "can't be blank"
  end

  test "requires renewal_at" do
    subscription = organizations(:northwind).subscriptions.new

    refute subscription.valid?
    assert_includes subscription.errors[:renewal_at], "can't be blank"
  end
end
