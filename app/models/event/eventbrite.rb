class Event::Eventbrite < Event::Importer
  default_params app_key: ENV['EVENTBRITE_APP_KEY']

  def self.scrape_id(url)
    response = HTTParty.get(url)
    html = Nokogiri::HTML(response.body)
    url = html.css('a.contact_organizer_link').first['href']
    id = CGI.parse(URI.parse(url).query)['eid'].first
  end

  def self.event_get(id)
    resp = get("https://www.eventbrite.com/json/event_get", query: { id: id })
  end

  def import
    @id = self.class.scrape_id(@url)
    @event = Event.where(source: 'eventbrite', source_id: @id).first_or_initialize
    unless @event.persisted?
      @data = self.class.event_get(@id)['event']
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
      organization_name: @data['organizer']['name'],
      address: @data['venue']['address'],
    }
  end

end