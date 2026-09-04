require "test_helper"

class CustomersTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
    @acme_corp = customers(:acme_corp)
  end

  test "customer show formats business plan as currency" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get customer_path(@acme_corp)

    assert_select "td", text: "$199.00"
  end

  test "customer show formats canceled plan as currency" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get customer_path(@acme_corp)

    assert_select "td", text: "$99.00"
  end
end
