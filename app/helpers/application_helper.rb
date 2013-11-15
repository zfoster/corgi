module ApplicationHelper

  def facebook_auth_path
    '/auth/facebook'
  end

  def twitter_auth_path
    '/auth/twitter'
  end

  def linkedin_auth_path
    '/auth/linkedin'
  end

  def google_auth_path
    '/auth/google'
  end

  def webcal_url(url)
    url.gsub('http', 'webcal')
  end
end
