class Identity::Twitter < Identity::ApiBase

  def api_client
    @api_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = @credentials['token']
      config.access_token_secret = @credentials['secret']
    end
  end

  def followee_ids
    api_client.friend_ids
  end
end

