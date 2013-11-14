class Event::Meetup < Event::Importer
  default_params key: ENV['MEETUP_API_KEY']


  def self.event(id)
    resp = get("https://api.meetup.com//2/event/#{id}")
  end

  def import
    @id = @url.match(/\/events\/([0-9]+)/)[1]
    @event = Event.where(source: 'meetup', source_id: @id).first_or_initialize
    unless @event.persisted?
      @data = self.class.event(@id)
      @event.update_attributes(attributes)
    end
    @event
  end

  private

  def attributes
    { start_time: Time.at(@data['time']/1000),
      end_time: Time.at(@data['time']/1000) + (@data['duration']/1000).seconds,
      title: @data['name'],
      description: Nokogiri::HTML(@data['description']).text,
      organization_name: @data['group']['name'],
      address: @data['venue']['address_1'],
    }
  end

end