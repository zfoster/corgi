class Identity::Google < Identity::ApiBase

  def api_client
    @api_client ||= Google::APIClient.new application_name: 'Madi', application_version: '1.0.0'
    @api_client.authorization.access_token = @credentials['token']
    @api_client
  end

  def followee_ids
    plus = api_client.discovered_api('plus', 'v1')
    JSON.parse(api_client.execute!(plus.people.list, userId: 'me', collection: 'visible', fields: 'items/id').body)['items'].map { |friend| friend['id'] }
  end
end

