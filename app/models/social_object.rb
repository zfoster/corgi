class SocialObject < ActiveRecord::Base
  has_many :admin, class_name: 'User'
  has_many :attendees, class_name: 'User'
  has_many :sharers, class_name: 'User'
  has_many :shares

end
