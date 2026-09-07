require "application_system_test_case"

class DashboardTest < ApplicationSystemTestCase
  test "visits dashboard" do
    sign_in_as(users(:alex))

    visit root_path

    assert_selector "h1", text: "Dashboard"
  end
end
