require "test_helper"

class KnowledgeDocumentAccessIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @alex = users(:alex)
    @foreign_document = knowledge_documents(:globex_refunds)
  end

  test "guests cannot access knowledge documents list page" do
    get knowledge_documents_path

    assert_redirected_to new_session_path
  end

  test "guests cannot access a knowledge document detail page" do
    get knowledge_document_path(@foreign_document)

    assert_redirected_to new_session_path
  end

  test "cannot access a knowledge document from another organization" do
    sign_in_as(@alex, organization: organizations(:northwind))

    get knowledge_documents_path
    assert_select "p", text: "Cancellation policy"
    assert_select "p", text: @foreign_document.title, count: 0

    get knowledge_document_path(@foreign_document)
    assert_response :not_found
  end
end
