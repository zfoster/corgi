class Follow < ActiveRecord::Base
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  scope :complete, -> { where('followee_id IS NOT NULL') }
  scope :incomplete, -> { where(followee_id: nil) }

end
