class Event < ActiveRecord::Base
  has_one :venue
  has_many :organizations
  has_many :admins, class_name: 'User'
  has_many :members, class_name: 'User'
  has_many :sharers, class_name: 'User'
  has_many :shares

end
