require 'spec_helper'

describe "A unregistered user can see a list of all events" do

  it "sees all of the events" do
    event = create(:event)
    visit events_path
    expect(page).to have_content('Your seeing a list of all events')
    expect(page).to have_content(event.title)
  end

end
