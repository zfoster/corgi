class AdminConstraint
  def matches?(request)
    return false unless request.session['user_id'].present?
    user = User.find_by_id(request.session['user_id'])
    user && user.admin?
  end
end