class RankUpdater < BaseWorker

  def perform(user_id, event_id)
    Rank.where(user_id: user_id, event_id: event_id).first_or_initialize.update_value
  end
end
