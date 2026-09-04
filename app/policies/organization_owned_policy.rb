class OrganizationOwnedPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.organization_id == organization.id
  end

  relation_scope do |relation|
    relation.in_org(organization)
  end
end
