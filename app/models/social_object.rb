class SocialObject < ActiveRecord::Base
  has_many :admin, class_name: 'User'
  has_many :members, class_name: 'User'
  has_many :sharers, class_name: 'User'
  has_many :shares

end
