require "test_helper"

class MembershipTest < ActiveSupport::TestCase
  test "record is valid" do
    assert memberships(:alex_northwind).valid?
  end

  test "duplicate membership is invalid" do
    membership = Membership.new(
      user: users(:alex),
      organization: organizations(:northwind),
      role: :operator
    )

    refute membership.valid?
    assert_includes membership.errors[:user_id], "has already been taken"
  end
end
