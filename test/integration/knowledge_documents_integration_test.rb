require "test_helper"

class KnowledgeDocumentsIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
    @document = knowledge_documents(:northwind_cancellation)
  end

  test "visits knowledge documents list" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get knowledge_documents_path

    assert_select "p", text: @document.title
  end

  test "visits a knowledge document" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get knowledge_document_path(@document)

    assert_select "h1", text: @document.title
    assert_includes response.body, "Customers may cancel at any time"
  end
end
