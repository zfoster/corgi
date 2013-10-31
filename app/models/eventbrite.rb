class Eventbrite
  include HTTParty
  default_params app_key: ENV['EVENTBRITE_APP_KEY']

  class << self
    def scrape_id(url)
      response = HTTParty.get(url)
      html = Nokogiri::HTML(response.body)
      url = html.css('a.contact_organizer_link').first['href']
      id = CGI.parse(URI.parse(url).query)['eid'].first
    end

    def event_get(id)
      resp = get("https://www.eventbrite.com/json/event_get", query: { id: id })
    end
  end

end