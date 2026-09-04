require "test_helper"

class SessionsTest < ActionDispatch::IntegrationTest
  setup { @user = User.take }

  test "new" do
    get new_session_path
    assert_response :success
  end

  test "create with valid credentials redirects to root" do
    post session_path, params: { email_address: @user.email_address, password: "password" }

    assert_redirected_to root_path
  end

  test "create with valid credentials sets a session cookie" do
    post session_path, params: { email_address: @user.email_address, password: "password" }

    assert cookies[:session_id]
  end

  test "create with invalid credentials redirects to sign in" do
    post session_path, params: { email_address: @user.email_address, password: "wrong" }

    assert_redirected_to new_session_path
  end

  test "create with invalid credentials does not set a session cookie" do
    post session_path, params: { email_address: @user.email_address, password: "wrong" }

    assert_nil cookies[:session_id]
  end

  test "destroy redirects to sign in" do
    sign_in_as(User.take)

    delete session_path

    assert_redirected_to new_session_path
  end

  test "destroy clears the session cookie" do
    sign_in_as(User.take)

    delete session_path

    assert_empty cookies[:session_id]
  end
end
