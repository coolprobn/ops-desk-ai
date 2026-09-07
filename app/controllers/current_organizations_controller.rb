class CurrentOrganizationsController < ApplicationController
  def update
    organization = Organization.find(params.require(:organization_id))

    authorize! organization, with: CurrentOrganizationPolicy

    remember_organization(organization)
    redirect_back fallback_location: root_path
  end
end
