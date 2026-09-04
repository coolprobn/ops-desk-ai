class CreateKnowledgeDocuments < ActiveRecord::Migration[8.1]
  def change
    create_table :knowledge_documents do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :title, null: false
      t.string :category, null: false
      t.text :body, null: false
      t.timestamps
    end
    add_index :knowledge_documents, [ :organization_id, :category ]
  end
end
