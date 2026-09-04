class CreateCustomers < ActiveRecord::Migration[8.1]
  def change
    create_table :customers do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name, null: false
      t.string :email, null: false
      t.string :company, null: false
      t.string :status, null: false
      t.timestamps
    end
    add_index :customers, [ :organization_id, :email ], unique: true
    add_index :customers, [ :organization_id, :company ]
  end
end
