require "test_helper"

class PasswordsIntegrationTest < ActionDispatch::IntegrationTest
  setup { @user = User.take }

  test "emails reset instructions" do
    get new_password_path
    assert_response :success
    assert_select "h1", text: "Forgot password?"

    post passwords_path, params: { email_address: @user.email_address }

    assert_enqueued_email_with PasswordsMailer, :reset, args: [ @user ]
    assert_redirected_to new_session_path
    follow_redirect!
    assert_select "#notice", text: /reset instructions sent/
  end

  test "unknown email still shows reset instructions sent" do
    post passwords_path, params: { email_address: "missing-user@example.com" }

    assert_enqueued_emails 0
    assert_redirected_to new_session_path
    follow_redirect!
    assert_select "#notice", text: /reset instructions sent/
  end

  test "updates password" do
    get edit_password_path(@user.password_reset_token)
    assert_response :success
    assert_select "h1", text: "Update your password"

    assert_changes -> { @user.reload.password_digest } do
      put password_path(@user.password_reset_token), params: { password: "new", password_confirmation: "new" }
    end

    assert_redirected_to new_session_path
    follow_redirect!
    assert_select "#notice", text: /Password has been reset/
  end

  test "invalid reset link" do
    get edit_password_path("invalid token")

    assert_redirected_to new_password_path
    follow_redirect!
    assert_select "#alert", text: /reset link is invalid/
  end

  test "non matching passwords" do
    token = @user.password_reset_token

    assert_no_changes -> { @user.reload.password_digest } do
      put password_path(token), params: { password: "no", password_confirmation: "match" }
    end

    assert_redirected_to edit_password_path(token)
    follow_redirect!
    assert_select "#alert", text: /Passwords did not match/
  end
end
