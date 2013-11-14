class Identity::Facebook < Identity::ApiBase

  def api_client
    @api_client ||= Koala::Facebook::API.new(@credentials['token'])
  end

  def followee_ids
    api_client.get_connections("me", "friends", fields: ['id']).map { |friend| friend['id'] }
  end
end

