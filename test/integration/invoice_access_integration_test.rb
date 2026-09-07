require "test_helper"

class InvoiceAccessIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
    @foreign_invoice = invoices(:acme_inc_paid)
  end

  test "guests cannot access invoices list page" do
    get invoices_path

    assert_redirected_to new_session_path
  end

  test "guests cannot access an invoice detail page" do
    get invoice_path(@foreign_invoice)

    assert_redirected_to new_session_path
  end

  test "cannot access an invoice from another organization" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get invoices_path
    assert_select "a", text: "Acme Inc", count: 0

    get invoice_path(@foreign_invoice)
    assert_response :not_found
  end
end
