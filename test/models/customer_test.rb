require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  test "record is valid" do
    assert customers(:acme_corp).valid?
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
