require "test_helper"

class KnowledgeDocumentTest < ActiveSupport::TestCase
  test "record is valid" do
    assert knowledge_documents(:northwind_pricing).valid?
  end

  test "requires title" do
    document = organizations(:northwind).knowledge_documents.new

    refute document.valid?
    assert_includes document.errors[:title], "can't be blank"
  end

  test "requires body" do
    document = organizations(:northwind).knowledge_documents.new

    refute document.valid?
    assert_includes document.errors[:body], "can't be blank"
  end
end
