class Rank < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates :user_id, uniqueness: { scope: :event_id }

  def calculate_value
    event.amps.where(user_id: followed_user_ids).count +
    event.registrations.where(user_id: followed_user_ids).count*2 +
    event.hostings.where(user_id: followed_user_ids).count*4
  end

  def update_value
    self.value = calculate_value
    save
  end

  def followed_user_ids
    @followed_user_ids ||= user.followed_user_ids
  end
end
