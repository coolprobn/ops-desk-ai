require "test_helper"

class SupportCaseTest < ActiveSupport::TestCase
  test "record is valid" do
    assert support_cases(:acme_corp_bill_doubled).valid?
  end

  test "requires subject" do
    support_case = organizations(:northwind).support_cases.new

    refute support_case.valid?
    assert_includes support_case.errors[:subject], "can't be blank"
  end

  test "requires description" do
    support_case = organizations(:northwind).support_cases.new

    refute support_case.valid?
    assert_includes support_case.errors[:description], "can't be blank"
  end

  test "requires opened_at" do
    support_case = organizations(:northwind).support_cases.new

    refute support_case.valid?
    assert_includes support_case.errors[:opened_at], "can't be blank"
  end
end
