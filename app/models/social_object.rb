class SocialObject < ActiveRecord::Base
  has_many :admin, class_name: 'User'
  has_many :members, class_name: 'User'
  has_many :sharers, class_name: 'User'
  has_many :shares

  validates_presence_of :admin, :members

  before_create :instantiate_share

  def instantiate_share(user)
    share = Share.new(user: user)
    shares << share
  end

  def new_member(user)
    self.members << user
    share = Share.new(user: user)
  end
end
