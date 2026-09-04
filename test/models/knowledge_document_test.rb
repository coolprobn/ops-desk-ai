require "test_helper"

class KnowledgeDocumentTest < ActiveSupport::TestCase
  test "rejects an unknown category" do
    document = organizations(:northwind).knowledge_documents.new(
      title: "Mystery",
      body: "Nope",
      category: "handbook"
    )

    refute document.valid?
    assert_includes document.errors[:category], "is not included in the list"
  end
end
