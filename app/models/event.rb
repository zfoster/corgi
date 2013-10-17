class Event < ActiveRecord::Base
  has_many :hostings
  has_many :registrations
  has_many :hosts, -> { distinct }, through: :hostings, source: :user
  has_many :attendees, -> { distinct }, through: :registrations, source: :user
  belongs_to :creator, class_name: "User"

  scope :closed, -> { where(closed: true) }
  scope :open, -> { where(closed: false) }
  scope :starts_in_the_future, -> { where('start_at > ?', Time.now) }

  delegate :email, to: :creator, prefix: true

  def attendees_csv
    CSV.generate do |csv|
      csv << ['Name', 'Email']
      self.attendees.each do |attendee|
        csv << ["#{attendee.first_name}", "#{attendee.email}"]
      end
    end
  end

end
