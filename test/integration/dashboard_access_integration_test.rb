require "test_helper"

class DashboardAccessIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
  end

  test "guests cannot access dashboard" do
    get root_path

    assert_redirected_to new_session_path
  end

  test "cannot see records from another organization" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get root_path

    assert_select "p", text: "Acme Corp"
    assert_select "p", text: "Acme Inc", count: 0
    assert_select "p", text: support_cases(:acme_inc_enterprise_addendum).subject, count: 0
  end
end
