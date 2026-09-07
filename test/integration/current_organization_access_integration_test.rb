require "test_helper"

class CurrentOrganizationAccessIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @sam = users(:sam)
  end

  test "guests cannot switch current organization" do
    patch current_organization_path, params: { organization_id: organizations(:northwind).id }

    assert_redirected_to new_session_path
  end

  test "cannot switch to organization they are not a member of" do
    sign_in_as(@sam)

    patch current_organization_path, params: { organization_id: organizations(:northwind).id }

    assert_redirected_to root_path
    follow_redirect!
    assert_select "#alert", text: "Not authorized"
    assert_select "aside p", text: "Globex"
  end
end
