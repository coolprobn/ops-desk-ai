class CurrentOrganizationPolicy < ApplicationPolicy
  def update?
    user.memberships.exists?(organization_id: record.id)
  end
end
