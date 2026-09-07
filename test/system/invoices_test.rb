require "application_system_test_case"

class InvoicesTest < ApplicationSystemTestCase
  test "visits invoices list" do
    sign_in_as(users(:alex))

    visit invoices_path

    assert_selector "h1", text: "Invoices"
  end

  test "visits an invoice" do
    sign_in_as(users(:alex))

    visit invoice_path(invoices(:acme_corp_business_issued))

    assert_text "Acme Corp"
  end
end
