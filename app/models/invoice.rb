class Invoice < ApplicationRecord
  include OrganizationOwned

  belongs_to :customer
  belongs_to :subscription, optional: true

  enum :status,
       { draft: "draft", issued: "issued", paid: "paid", void: "void" },
       default: :issued,
       validate: true

  validates :amount_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :issued_at, presence: true
end
