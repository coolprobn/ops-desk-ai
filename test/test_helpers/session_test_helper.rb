module SessionTestHelper
  def sign_in_as(user, organization: nil)
    membership = if organization
      user.memberships.find_by!(organization:)
    else
      user.memberships.order(:created_at, :id).first!
    end

    Current.session = user.sessions.create!

    ActionDispatch::TestRequest.create.cookie_jar.tap do |cookie_jar|
      cookie_jar.signed[:session_id] = Current.session.id
      cookies["session_id"] = cookie_jar[:session_id]
      cookie_jar.signed[:organization_id] = membership.organization_id
      cookies["organization_id"] = cookie_jar[:organization_id]
    end
  end

  def sign_out
    Current.session&.destroy!
    cookies.delete("session_id")
    cookies.delete("organization_id")
  end
end

ActiveSupport.on_load(:action_dispatch_integration_test) do
  include SessionTestHelper
end
