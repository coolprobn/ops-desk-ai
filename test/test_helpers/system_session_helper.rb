module SystemSessionHelper
  def sign_in_as(user)
    Current.session = user.sessions.create!

    ActionDispatch::TestRequest.create.cookie_jar.tap do |cookie_jar|
      cookie_jar.signed[:session_id] = Current.session.id

      visit new_session_url

      page.driver.browser.manage.add_cookie(
        name: :session_id,
        value: cookie_jar[:session_id],
        sameSite: :Lax,
        httpOnly: true
      )
    end

    visit root_path
  end
end
