require "test_helper"

class SessionsIntegrationTest < ActionDispatch::IntegrationTest
  setup { @user = User.take }

  test "signs in" do
    get new_session_path
    assert_response :success
    assert_select "h1", text: "Sign in"

    post session_path, params: { email_address: @user.email_address, password: "password" }

    assert_redirected_to root_path
    assert cookies[:session_id]
  end

  test "rejects invalid credentials" do
    post session_path, params: { email_address: @user.email_address, password: "wrong" }

    assert_redirected_to new_session_path
    assert_nil cookies[:session_id]
  end

  test "rejects user without active membership" do
    @user.memberships.destroy_all

    post session_path, params: { email_address: @user.email_address, password: "password" }

    assert_redirected_to new_session_path
    assert_nil cookies[:session_id]
  end

  test "logs out the user" do
    sign_in_as(User.take)

    delete session_path

    assert_redirected_to new_session_path
    assert_empty cookies[:session_id]
  end
end
