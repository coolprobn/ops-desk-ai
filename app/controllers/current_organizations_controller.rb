class CurrentOrganizationsController < ApplicationController
  def update
    organization = current_user.organizations.find(params.require(:organization_id))
    remember_organization(organization)
    redirect_back fallback_location: root_path
  end
end
