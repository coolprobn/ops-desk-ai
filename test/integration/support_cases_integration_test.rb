require "test_helper"

class SupportCasesIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
    @support_case = support_cases(:acme_corp_bill_doubled)
  end

  test "visits support cases list" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get support_cases_path

    assert_select "a", text: @support_case.subject
  end

  test "visits a support case" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get support_case_path(@support_case)

    assert_select "h1", text: @support_case.subject
    assert_select "a", text: "Acme Corp"
    assert_includes response.body, @support_case.description
  end
end
