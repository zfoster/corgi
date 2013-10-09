namespace :admin do
  desc 'Send daily attendee list'
  task :send_attendee_lists do
    Event.where('start_time > ?', Time.now.end_of_day) do |e|
      EventMailer.send_attendee_list(e)
    end
  end
end
