require "application_system_test_case"

class SupportCasesTest < ApplicationSystemTestCase
  test "visits support cases list" do
    sign_in_as(users(:alex))

    visit support_cases_path

    assert_selector "h1", text: "Support cases"
  end

  test "visits a support case" do
    sign_in_as(users(:alex))

    visit support_case_path(support_cases(:acme_corp_bill_doubled))

    assert_selector "h1", text: "Bill doubled this month"
  end
end
