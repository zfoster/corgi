class Identity::Twitter < Identity::ApiBase

  def api_client
    @api_client ||= Twitter::Client.new oauth_token: @credentials['token'], oauth_token_secret: @credentials['secret']
  end

  def followee_ids  
    api_client.friend_ids
  end
end

