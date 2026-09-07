require "test_helper"

class CustomerAccessIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
    @acme_inc = customers(:acme_inc)
  end

  test "guests cannot access customers list page" do
    get customers_path

    assert_redirected_to new_session_path
  end

  test "cannot access a customer from another organization" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get customers_path
    assert_select "a", text: "Acme Corp", count: 1
    assert_select "a", text: "Acme Inc", count: 0

    get customer_path(@acme_inc)
    assert_response :not_found
  end

  test "guests cannot access a customer detail page" do
    get customer_path(@acme_inc)

    assert_redirected_to new_session_path
  end
end
