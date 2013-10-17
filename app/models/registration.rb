class Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  delegate :email, to: :user, prefix: true

  def attendees_csv
    csv = @event.attendees_csv
    respond_to do |format|
      format.html
      format.csv { render csv: csv, filename: 'attendee_list' }
    end
  end

end
