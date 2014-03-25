class Event::Meetup < Event::Importer
  default_params key: ENV['MEETUP_API_KEY']

  def event_data
    @response ||= self.class.get("https://api.meetup.com//2/event/#{source_id}")
  end

  def source_id
    @source_id ||= @url.match(/\/events\/([0-9]+)/)[1]
  end

  def source
    'meetup'
  end

  private

  def attributes
    { start_time: Time.at(event_data['time']/1000),
      title: event_data['name'],
      description: Nokogiri::HTML(event_data['description']).text,
      organization_name: event_data['group']['name'],
      address: event_data['venue']['address_1'],
    }
  end

end
