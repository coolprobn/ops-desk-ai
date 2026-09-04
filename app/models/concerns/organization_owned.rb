module OrganizationOwned
  extend ActiveSupport::Concern

  included do
    belongs_to :organization
  end

  class_methods do
    def in_org(organization)
      where(organization_id: organization.id)
    end
  end
end
