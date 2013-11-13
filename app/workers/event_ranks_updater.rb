class EventRanksUpdater < BaseWorker

  def perform(event_id)
    User.find_each do |user|
      RankUpdater.perform_async(user.id, event_id)
    end
  end
end