class Follow < ActiveRecord::Base
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  scope :complete, -> { where('followee_id IS NOT NULL') }

  def link_followee
    identity = Identity.where(provider: source, uid: source_id).first
    update_attributes(followee: identity.user) if identity
  end

end
