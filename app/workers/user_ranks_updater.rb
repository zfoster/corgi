class UserRanksUpdater < BaseWorker

  def perform(user_id)
    Event.find_each{ |event| RankUpdater.perform_async(user_id, event.id)}
  end
end
