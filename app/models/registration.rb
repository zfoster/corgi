class Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  delegate :email, to: :user, prefix: true

  def self.event_attendees_csv(registrations)
    CSV.generate do |csv|
      csv << ['Name', 'Email']
      registrations.each do |registration|
        csv << ["#{registration.user.first_name}", "#{registration.user.email}"]
      end
    end
  end

end
