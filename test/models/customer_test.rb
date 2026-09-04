require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  test "plan comes from the current subscription" do
    assert_equal "Business", customers(:acme_corp).plan
  end

  test "current subscription is the active business plan" do
    assert_equal subscriptions(:acme_corp_business), customers(:acme_corp).current_subscription
  end

  test "canceled subscription is not the current plan" do
    assert_nil customers(:orbit).plan
  end

  test "canceled subscription is not current" do
    assert_nil customers(:orbit).current_subscription
  end

  test "requires name" do
    customer = organizations(:northwind).customers.new

    refute customer.valid?
    assert_includes customer.errors[:name], "can't be blank"
  end

  test "requires email" do
    customer = organizations(:northwind).customers.new

    refute customer.valid?
    assert_includes customer.errors[:email], "can't be blank"
  end

  test "requires company" do
    customer = organizations(:northwind).customers.new

    refute customer.valid?
    assert_includes customer.errors[:company], "can't be blank"
  end
end
