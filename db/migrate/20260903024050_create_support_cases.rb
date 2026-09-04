class CreateSupportCases < ActiveRecord::Migration[8.1]
  def change
    create_table :support_cases do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.string :subject, null: false
      t.text :description, null: false
      t.string :status, null: false
      t.string :priority, null: false
      t.datetime :opened_at, null: false
      t.datetime :resolved_at
      t.timestamps
    end
    add_index :support_cases, [ :organization_id, :customer_id, :status ]
  end
end
