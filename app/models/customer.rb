class Customer < ApplicationRecord
  include OrganizationOwned

  has_many :subscriptions, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :support_cases, dependent: :destroy

  enum :status,
       { active: "active", paused: "paused", churned: "churned" },
       default: :active,
       validate: true

  validates :name, :email, :company, presence: true

  def current_subscription
    subscriptions
      .where(status: %w[trialing active past_due])
      .order(started_at: :desc)
      .first
  end

  def plan
    current_subscription&.plan_name
  end
end
