module AuthHelper
  def sign_in(opts = {})
    get_via_redirect('/auth/facebook')
    User.last.update_attribute(:admin, true) if opts[:admin]
  end
end