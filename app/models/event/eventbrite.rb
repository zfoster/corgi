class Event::Eventbrite < Event::Importer

  def import
    @id = Eventbrite.scrape_id(url)
    @event = where(source: 'eventbrite', source_id: id).first_or_initialize
    unless @event.persisted?
      @data = Eventbrite.event_get(id)['event']
      @event.update_attributes(attributes)
    end
    @event
  end

  private

  def attributes
    { start_time: @data['start_date'],
      end_time: @data['end_date'],
      title: @data['title'],
      description: Nokogiri::HTML(@data['description']).text,
      organization_name: @data['organizer']['name']
      address: @data['venue']['address']
    }
  end

end