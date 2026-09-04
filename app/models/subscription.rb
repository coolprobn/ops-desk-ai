class Subscription < ApplicationRecord
  include OrganizationOwned

  belongs_to :customer
  has_many :invoices, dependent: :nullify

  enum :status,
       {
         trialing: "trialing",
         active: "active",
         past_due: "past_due",
         paused: "paused",
         canceled: "canceled"
       },
       default: :active,
       validate: true

  validates :plan_name, presence: true
  validates :monthly_price_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :started_at, :renewal_at, presence: true

  def cancel!(at: Time.current)
    update!(status: :canceled, canceled_at: at)
  end
end
