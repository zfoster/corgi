class Event < ActiveRecord::Base
  has_many :hostings
  has_many :registrations
  has_many :hosts, -> { distinct }, through: :hostings, source: :user
  has_many :attendees, -> { distinct }, through: :registrations, source: :user
end
