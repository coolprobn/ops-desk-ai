require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "record is valid" do
    assert users(:alex).valid?
  end

  test "requires name" do
    user = User.new

    refute user.valid?
    assert_includes user.errors[:name], "can't be blank"
  end

  test "requires email_address" do
    user = User.new

    refute user.valid?
    assert_includes user.errors[:email_address], "can't be blank"
  end

  test "duplicate email_address is invalid" do
    user = User.new(
      name: "Other",
      email_address: users(:alex).email_address,
      password: "password"
    )

    refute user.valid?
    assert_includes user.errors[:email_address], "has already been taken"
  end

  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")

    assert_equal "downcased@example.com", user.email_address
  end
end
