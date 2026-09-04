class CreateInvoices < ActiveRecord::Migration[8.1]
  def change
    create_table :invoices do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :subscription, foreign_key: true
      t.integer :amount_cents, null: false
      t.string :status, null: false
      t.datetime :issued_at, null: false
      t.datetime :paid_at
      t.timestamps
    end
    add_index :invoices, [ :organization_id, :customer_id, :issued_at ]
  end
end
