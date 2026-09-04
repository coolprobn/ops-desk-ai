require "test_helper"

class MembershipTest < ActiveSupport::TestCase
  test "alex belongs to northwind" do
    assert_includes users(:alex).organizations, organizations(:northwind)
  end

  test "alex belongs to globex" do
    assert_includes users(:alex).organizations, organizations(:globex)
  end

  test "alex is admin on northwind" do
    assert_equal "admin", users(:alex).membership_for(organizations(:northwind)).role
  end

  test "alex is operator on globex" do
    assert_equal "operator", users(:alex).membership_for(organizations(:globex)).role
  end

  test "duplicate membership is invalid" do
    membership = Membership.new(
      user: users(:alex),
      organization: organizations(:northwind),
      role: :operator
    )

    assert_not membership.valid?
    assert_includes membership.errors[:user_id], "has already been taken"
  end
end
