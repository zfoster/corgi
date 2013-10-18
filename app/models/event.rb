class Event < ActiveRecord::Base
  has_many :hostings
  has_many :registrations
  has_many :hosts, -> { distinct }, through: :hostings, source: :user
  has_many :attendees, -> { distinct }, through: :registrations, source: :user
  has_and_belongs_to_many :organizations
  belongs_to :creator, class_name: "User"

  scope :closed, -> { where(closed: true) }
  scope :open, -> { where(closed: false) }
  scope :starts_in_the_future, -> { where('start_at > ?', Time.now) }

  delegate :email, to: :creator, prefix: true

end