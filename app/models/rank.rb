class Rank < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  has_many :amps, through: :event
  has_many :registrations, through: :event
  has_many :hostings, through: :event

  validates :user_id, uniqueness: { scope: :event_id }

  def calculate_value
    amped_follows.count +
    registered_follows.count*2 +
    hosting_follows.count*4
  end

  def update_value
    self.value = calculate_value
    save
  end

  def associated_follows
    [amped_follows, registered_follows, hosting_follows].flatten.map(&:user).uniq
  end

  def amped_follows
    @amped_follows ||= amps.where(user_id: followed_user_ids)
  end

  def registered_follows
    @registered_follows ||= registrations.where(user_id: followed_user_ids)
  end

  def hosting_follows
    @hosting_follows ||= hostings.where(user_id: followed_user_ids)
  end

  def followed_user_ids
    @followed_user_ids ||= user.followed_user_ids
  end
end
