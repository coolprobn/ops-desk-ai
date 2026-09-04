class SupportCase < ApplicationRecord
  include OrganizationOwned

  belongs_to :customer

  enum :status,
       {
         open: "open",
         pending: "pending",
         resolved: "resolved",
         closed: "closed"
       },
       default: :open,
       validate: true
  enum :priority,
       { low: "low", normal: "normal", high: "high", urgent: "urgent" },
       default: :normal,
       validate: true

  validates :subject, :description, :opened_at, presence: true
end
