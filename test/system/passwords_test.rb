require "application_system_test_case"

class PasswordsTest < ApplicationSystemTestCase
  test "emails reset instructions" do
    visit new_password_path
    assert_selector "h1", text: "Forgot password?"

    fill_in "Email", with: users(:alex).email_address
    click_button "Email reset instructions"

    assert_text "Password reset instructions sent"
  end

  test "updates password" do
    user = users(:alex)

    visit edit_password_path(user.password_reset_token)
    assert_selector "h1", text: "Update your password"

    fill_in "New password", with: "newpass"
    fill_in "Confirm password", with: "newpass"
    click_button "Save"
    assert_selector "h1", text: "Sign in"

    assert user.reload.authenticate("newpass")
  end
end
