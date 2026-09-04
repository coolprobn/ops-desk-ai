class Membership < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  enum :role,
       { operator: "operator", admin: "admin" },
       default: :operator,
       validate: true

  validates :user_id, uniqueness: { scope: :organization_id }
end
