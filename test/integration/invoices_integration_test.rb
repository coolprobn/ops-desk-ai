require "test_helper"

class InvoicesIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
    @invoice = invoices(:acme_corp_business_issued)
  end

  test "visits invoices list" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get invoices_path

    assert_select "a", text: "Acme Corp"
  end

  test "visits an invoice" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get invoice_path(@invoice)

    assert_select "a", text: "Acme Corp"
    assert_includes response.body, I18n.l(@invoice.issued_at, format: :short)
  end
end
