class Event::Meetup < Event::Importer

  def import
    @id = @url.match(/\/events\/([0-9]+)/)[1]
    @event = where(source: 'meetup', source_id: id).first_or_initialize
    unless event.persisted?
      @data = Meetup.event(id)
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
      organization_name: @data['group']['name']
      address: @data['venue']['address_1']
    }
  end

end