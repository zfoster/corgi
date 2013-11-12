class RankUpdater
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(user_id, event_id)
    Rank.where(user_id: user_id, event: event_id).first_or_initialize.update_value
  end
end