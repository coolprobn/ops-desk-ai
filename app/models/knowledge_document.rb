class KnowledgeDocument < ApplicationRecord
  include OrganizationOwned

  enum :category,
       {
         pricing: "pricing",
         refunds: "refunds",
         cancellation: "cancellation",
         billing: "billing",
         sla: "sla",
         product: "product"
       },
       validate: true

  validates :title, :body, presence: true
end
