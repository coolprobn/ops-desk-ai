require "test_helper"

class PasswordsTest < ActionDispatch::IntegrationTest
  setup { @user = User.take }

  test "new" do
    get new_password_path
    assert_response :success
  end

  test "create enqueues a reset email" do
    post passwords_path, params: { email_address: @user.email_address }

    assert_enqueued_email_with PasswordsMailer, :reset, args: [ @user ]
  end

  test "create redirects to sign in" do
    post passwords_path, params: { email_address: @user.email_address }

    assert_redirected_to new_session_path
  end

  test "create shows reset instructions sent" do
    post passwords_path, params: { email_address: @user.email_address }
    follow_redirect!

    assert_notice "reset instructions sent"
  end

  test "create for an unknown user sends no mail" do
    post passwords_path, params: { email_address: "missing-user@example.com" }

    assert_enqueued_emails 0
  end

  test "create for an unknown user redirects to sign in" do
    post passwords_path, params: { email_address: "missing-user@example.com" }

    assert_redirected_to new_session_path
  end

  test "create for an unknown user still shows reset instructions sent" do
    post passwords_path, params: { email_address: "missing-user@example.com" }
    follow_redirect!

    assert_notice "reset instructions sent"
  end

  test "edit" do
    get edit_password_path(@user.password_reset_token)
    assert_response :success
  end

  test "edit with invalid token redirects to new password" do
    get edit_password_path("invalid token")

    assert_redirected_to new_password_path
  end

  test "edit with invalid token shows reset link is invalid" do
    get edit_password_path("invalid token")
    follow_redirect!

    assert_notice "reset link is invalid"
  end

  test "update changes the password digest" do
    assert_changes -> { @user.reload.password_digest } do
      put password_path(@user.password_reset_token), params: { password: "new", password_confirmation: "new" }
    end
  end

  test "update redirects to sign in" do
    put password_path(@user.password_reset_token), params: { password: "new", password_confirmation: "new" }

    assert_redirected_to new_session_path
  end

  test "update shows password has been reset" do
    put password_path(@user.password_reset_token), params: { password: "new", password_confirmation: "new" }
    follow_redirect!

    assert_notice "Password has been reset"
  end

  test "update with non matching passwords does not change the digest" do
    token = @user.password_reset_token

    assert_no_changes -> { @user.reload.password_digest } do
      put password_path(token), params: { password: "no", password_confirmation: "match" }
    end
  end

  test "update with non matching passwords redirects to edit" do
    token = @user.password_reset_token

    put password_path(token), params: { password: "no", password_confirmation: "match" }

    assert_redirected_to edit_password_path(token)
  end

  test "update with non matching passwords shows they did not match" do
    token = @user.password_reset_token

    put password_path(token), params: { password: "no", password_confirmation: "match" }
    follow_redirect!

    assert_notice "Passwords did not match"
  end

  private
    def assert_notice(text)
      assert_select "div", /#{text}/
    end
end
