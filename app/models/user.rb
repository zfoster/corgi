class User < ActiveRecord::Base
  has_many :identities
  has_one :facebook_identity, -> { where provider: 'facebook' }, class_name: 'Identity'
  has_one :twitter_identity, -> { where provider: 'twitter' }, class_name: 'Identity'
  has_one :linkedin_identity, -> { where provider: 'linkedin' }, class_name: 'Identity'
  has_one :googleplus_identity, -> { where provider: 'googleplus' }, class_name: 'Identity'
end
