class Event < ActiveRecord::Base
  has_one :venue
  has_many :organizations
  has_many :admins, class_name: 'User'
  has_many :members, class_name: 'User'
  has_many :sharers, class_name: 'User'
  has_many :shares
  has_one :owner, class_name: 'User'

  after_create :inform_owner_of_created_event

  def inform_owner_of_new_event
    EventMailer.event_created(self).deliver
  end
end
