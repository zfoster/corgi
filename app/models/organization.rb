class Organization < ActiveRecord::Base
  has_many :events
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ActionController::Base.helpers.asset_path("ORG.jpg")
  has_many :org_administrations
  has_many :administrators, through: :org_administrations, source: :user

  validates :name, presence: true
  
end
