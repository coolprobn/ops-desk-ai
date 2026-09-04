require "test_helper"

class OrganizationIsolationTest < ActiveSupport::TestCase
  setup do
    @northwind = organizations(:northwind)
    @globex = organizations(:globex)
    @acme_corp = customers(:acme_corp)
    @acme_inc = customers(:acme_inc)
  end

  test "northwind customers include acme corp" do
    assert_includes @northwind.customers.pluck(:company), "Acme Corp"
  end

  test "northwind customers do not include acme inc" do
    refute_includes @northwind.customers.pluck(:company), "Acme Inc"
  end

  test "globex customers include acme inc" do
    assert_includes @globex.customers.pluck(:company), "Acme Inc"
  end

  test "globex customers do not include acme corp" do
    refute_includes @globex.customers.pluck(:company), "Acme Corp"
  end

  test "in_org for northwind includes acme corp" do
    assert_includes Customer.in_org(@northwind).pluck(:id), @acme_corp.id
  end

  test "in_org for northwind excludes acme inc" do
    refute_includes Customer.in_org(@northwind).pluck(:id), @acme_inc.id
  end

  test "in_org for globex includes acme inc" do
    assert_includes Customer.in_org(@globex).pluck(:id), @acme_inc.id
  end

  test "in_org for globex excludes acme corp" do
    refute_includes Customer.in_org(@globex).pluck(:id), @acme_corp.id
  end
end
