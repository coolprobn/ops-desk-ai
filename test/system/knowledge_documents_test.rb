require "application_system_test_case"

class KnowledgeDocumentsTest < ApplicationSystemTestCase
  test "visits knowledge documents list" do
    sign_in_as(users(:alex))

    visit knowledge_documents_path

    assert_selector "h1", text: "Knowledge"
  end

  test "visits a knowledge document" do
    sign_in_as(users(:alex))

    visit knowledge_document_path(knowledge_documents(:northwind_cancellation))

    assert_selector "h1", text: "Cancellation policy"
  end
end
