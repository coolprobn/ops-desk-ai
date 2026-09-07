require "application_system_test_case"

class CurrentOrganizationTest < ApplicationSystemTestCase
  test "switches current organization" do
    sign_in_as(users(:alex))

    visit root_path
    select "Globex", from: "organization_id"

    assert_selector "select#organization_id option[selected]", text: "Globex"
  end
end
