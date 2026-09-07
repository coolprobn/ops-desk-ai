require "test_helper"

class SupportCaseAccessIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
    @foreign_case = support_cases(:acme_inc_enterprise_addendum)
  end

  test "guests cannot access support cases list page" do
    get support_cases_path

    assert_redirected_to new_session_path
  end

  test "guests cannot access a support case detail page" do
    get support_case_path(@foreign_case)

    assert_redirected_to new_session_path
  end

  test "cannot access a support case from another organization" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get support_cases_path
    assert_select "a", text: @foreign_case.subject, count: 0

    get support_case_path(@foreign_case)
    assert_response :not_found
  end
end
