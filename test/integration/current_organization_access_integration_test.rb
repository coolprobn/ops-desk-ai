require "test_helper"

class CurrentOrganizationAccessIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
    @sam = users(:sam)
  end

  test "alex on globex sees acme inc" do
    sign_in_as(@alex, organization: organizations(:globex))

    get customers_path

    assert_select "a", text: "Acme Inc"
  end

  test "alex on globex does not see acme corp" do
    sign_in_as(@alex, organization: organizations(:globex))

    get customers_path

    assert_select "a", text: "Acme Corp", count: 0
  end

  test "switching organization redirects to root" do
    sign_in_as(@alex, organization: organizations(:northwind))

    patch current_organization_path, params: { organization_id: organizations(:globex).id }

    assert_redirected_to root_path
  end

  test "after switch alex sees acme inc" do
    sign_in_as(@alex, organization: organizations(:northwind))
    patch current_organization_path, params: { organization_id: organizations(:globex).id }
    follow_redirect!

    get customers_path

    assert_select "a", text: "Acme Inc"
  end

  test "after switch alex does not see acme corp" do
    sign_in_as(@alex, organization: organizations(:northwind))
    patch current_organization_path, params: { organization_id: organizations(:globex).id }
    follow_redirect!

    get customers_path

    assert_select "a", text: "Acme Corp", count: 0
  end

  test "sam cannot switch to northwind" do
    sign_in_as(@sam)

    patch current_organization_path, params: { organization_id: organizations(:northwind).id }

    assert_response :not_found
  end
end
