require "test_helper"

class CurrentOrganizationIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
  end

  test "switches current organization" do
    sign_in_as(@alex, organization: organizations(:northwind))

    patch current_organization_path, params: { organization_id: organizations(:globex).id }

    assert_redirected_to root_path
    follow_redirect!
    assert_select "select#organization_id option[selected]", text: "Globex"
  end
end
