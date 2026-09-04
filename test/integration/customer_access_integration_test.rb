require "test_helper"

class CustomerAccessIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
    @sam = users(:sam)
    @acme_corp = customers(:acme_corp)
    @acme_inc = customers(:acme_inc)
  end

  test "signed out guests are redirected to sign in" do
    get customers_path

    assert_redirected_to new_session_path
  end

  test "alex on northwind sees acme corp" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get customers_path

    assert_select "a", text: "Acme Corp"
  end

  test "alex on northwind does not see acme inc" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get customers_path

    assert_select "a", text: "Acme Inc", count: 0
  end

  test "alex on northwind cannot show a globex customer" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get customer_path(@acme_inc)

    assert_response :not_found
  end

  test "alex on globex can show a globex customer" do
    sign_in_as(@alex, organization: organizations(:globex))

    get customer_path(@acme_inc)

    assert_select "h1", text: "Acme Inc"
  end

  test "sam sees acme inc" do
    sign_in_as(@sam)

    get customers_path

    assert_select "a", text: "Acme Inc"
  end

  test "sam does not see acme corp" do
    sign_in_as(@sam)

    get customers_path

    assert_select "a", text: "Acme Corp", count: 0
  end
end
