require "application_system_test_case"

class CustomersTest < ApplicationSystemTestCase
  test "visits customers list" do
    sign_in_as(users(:alex))

    visit customers_path

    assert_selector "h1", text: "Customers"
  end

  test "visits a customer" do
    sign_in_as(users(:alex))

    visit customer_path(customers(:acme_corp))

    assert_selector "h1", text: "Acme Corp"
  end
end
