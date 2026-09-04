class CreateSubscriptions < ActiveRecord::Migration[8.1]
  def change
    create_table :subscriptions do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.string :plan_name, null: false
      t.string :status, null: false
      t.integer :monthly_price_cents, null: false
      t.datetime :started_at, null: false
      t.datetime :renewal_at, null: false
      t.datetime :canceled_at
      t.timestamps
    end
    add_index :subscriptions, [ :organization_id, :customer_id ]
  end
end
