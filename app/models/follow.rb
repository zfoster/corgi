class Follow < ActiveRecord::Base
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  scope :complete, -> { where('followee_id IS NOT NULL') }
  scope :incomplete, -> { where(followee_id: nil) }

  def complete
    user = Identity.where(provider: source, uid: source_id).first.try(:user)
    update_attributes(followee: user) if user
  end

end
