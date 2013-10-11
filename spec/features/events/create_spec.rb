require 'spec_helper'

describe "A new user creates an event" do

  it "creates the event" do
    visit root_path
    click_link 'Connect with LinkedIn'
    click_on 'EVENTS'
    fill_in 'Title', with: 'CityCamp'
    fill_in 'Description', with: 'The best city camp event ever'
    click_on 'Save'
    expect(page.find('#flash_notice')).to have_content("Event was successfully created.")
    expect(page.find('.hosts')).to have_content("wash@firefly.com")
    expect(page.find('.attendees')).to have_content("wash@firefly.com")
    expect(page).to have_link("Edit")
  end

end

describe "An anonymous user registers to attend event" do

  let(:event) { Factory.create :event }

  it "chooses an event to attend" do
    visit root_path
    click_link 'EVENTS'
    expect(page).to have_content #list of events
    click 'Attend'
    click_link 'Connect with Facebook'
    expect(page).to have_content #list of events
    expect(page).to have_content 'Attending'
    expect(page).to have_link("Cancel")
    #test for email?
    click_on #event page
    expect(page).to have_content #users name
  end

end