require "test_helper"

class DashboardIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
  end

  test "visits dashboard" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get root_path

    assert_select "h1", text: "Dashboard"
    assert_select "p", text: "Northwind"
    assert_select "p", text: "Acme Corp"
    assert_select "p", text: support_cases(:acme_corp_bill_doubled).subject
  end
end
