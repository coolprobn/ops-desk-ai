require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  test "record is valid" do
    assert organizations(:northwind).valid?
  end

  test "requires name" do
    organization = Organization.new

    refute organization.valid?
    assert_includes organization.errors[:name], "can't be blank"
  end

  test "requires slug" do
    organization = Organization.new

    refute organization.valid?
    assert_includes organization.errors[:slug], "can't be blank"
  end

  test "duplicate slug is invalid" do
    organization = Organization.new(name: "Other", slug: organizations(:northwind).slug)

    refute organization.valid?
    assert_includes organization.errors[:slug], "has already been taken"
  end
end
