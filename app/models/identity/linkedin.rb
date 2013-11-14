class Identity::Linkedin < Identity::ApiBase

  def api_client
    @api_client ||= LinkedIn::Client.new ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
    @api_client.authorize_from_access @credentials['token'], @credentials['secret']
    @api_client
  end

  def followee_ids
    api_client.connections(fields: ['id'])['all'].map(&:id).select{ |el| el != 'private' }
  end
end

