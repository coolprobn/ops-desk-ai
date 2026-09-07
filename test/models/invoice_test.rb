require "test_helper"

class InvoiceTest < ActiveSupport::TestCase
  test "record is valid" do
    assert invoices(:acme_corp_business_paid).valid?
  end

  test "rejects a negative amount" do
    invoice = organizations(:northwind).invoices.new(amount_cents: -1)

    refute invoice.valid?
    assert_includes invoice.errors[:amount_cents], "must be greater than or equal to 0"
  end

  test "requires issued_at" do
    invoice = organizations(:northwind).invoices.new

    refute invoice.valid?
    assert_includes invoice.errors[:issued_at], "can't be blank"
  end
end
