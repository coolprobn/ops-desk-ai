require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  test "signs in" do
    visit new_session_path
    assert_selector "h1", text: "Sign in"

    fill_in "Email", with: users(:alex).email_address
    fill_in "Password", with: "password"

    assert_difference "Session.count", 1 do
      click_button "Sign in"
      assert_selector "h1", text: "Dashboard"
    end
  end

  test "signs out" do
    sign_in_as(users(:alex))

    click_button "Sign out"
    assert_selector "h1", text: "Sign in"

    assert_equal 0, users(:alex).sessions.count
  end
end
