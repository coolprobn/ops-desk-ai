class KnowledgeDocumentsController < ApplicationController
  def index
    @knowledge_documents = authorized_scope(KnowledgeDocument.all).order(:category, :title)
  end

  def show
    @knowledge_document = authorized_scope(KnowledgeDocument.all).find(params[:id])
  end
end
