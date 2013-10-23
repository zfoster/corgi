class Organization < ActiveRecord::Base
  has_many :events
  attr_accessible :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/ORG.jpg", :path => 'dev/corgi/app/assets/images/paperclip/:filename'
  
end
