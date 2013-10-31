class Meetup
  include HTTParty
  default_params key: ENV['MEETUP_API_KEY']

  class << self

    def event(id)
      resp = get("https://api.meetup.com//2/event/#{id}")
    end
  end

end