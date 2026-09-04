class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  authorize :user, through: :current_user
  authorize :organization, through: :current_organization

  helper_method :current_organization

  private

  def current_organization
    Current.organization
  end
end
