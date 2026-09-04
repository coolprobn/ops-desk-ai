module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
    helper_method :authenticated?, :current_user
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private

  def authenticated?
    resume_session
  end

  def current_user
      return @current_user if defined?(@current_user)

      @current_user = Current.user
  end

  def require_authentication
    resume_session || request_authentication
    return unless Current.session

    bind_current_tenant
  end

  def membership_from_db
    return @membership_from_db if defined?(@membership_from_db)

    @membership_from_db = current_user.memberships.find_by(organization_id: cookies.signed[:organization_id]).presence || current_user.memberships.order(:created_at, :id).first
  end

  def bind_current_tenant
    unless membership_from_db
      terminate_session
      request_authentication
      return
    end

    remember_organization(membership_from_db.organization)
    Current.membership = membership_from_db
    Current.organization = membership_from_db.organization
  end

  def resume_session
    Current.session ||= find_session_by_cookie
  end

  def find_session_by_cookie
    if cookies.signed[:session_id]
      Session.find_by(id: cookies.signed[:session_id])
    end
  end

  def request_authentication
    session[:return_to_after_authenticating] = request.url
    redirect_to new_session_path
  end

  def after_authentication_url
    session.delete(:return_to_after_authenticating) || root_url
  end

  def start_new_session_for(user, organization: nil)
    membership =
      if organization
        user.memberships.find_by!(organization:)
      else
        user.memberships.order(:created_at, :id).first!
      end

    user
      .sessions
      .create!(user_agent: request.user_agent, ip_address: request.remote_ip)
      .tap do |record|
        Current.session = record
        Current.membership = membership
        Current.organization = membership.organization
        cookies.signed.permanent[:session_id] = {
          value: record.id,
          httponly: true,
          same_site: :lax
        }
        remember_organization(membership.organization)
      end
  end

  def remember_organization(organization)
    cookies.signed.permanent[:organization_id] = {
      value: organization.id,
      httponly: true,
      same_site: :lax
    }
  end

  def terminate_session
    Current.session.destroy
    cookies.delete(:session_id)
    cookies.delete(:organization_id)
  end
end
