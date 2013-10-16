require 'spec_helper'

describe "An authenticated user registers to attend event" do

  let!(:event) { create(:event) }

  it "chooses an event to attend from a list of events" do
    visit root_path
    click_link 'Connect with Facebook'
    click_link 'EVENTS'
    click_on 'Attend'
    expect(page).to have_content event.title
    expect(page).to have_content 'Attending'
    expect(page).to_not have_link 'Attend'
    expect(page).to have_link("Cancel")
    expect(unread_emails_for("bob@example.com").size).to eq(1)
  end
end