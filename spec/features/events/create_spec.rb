require 'spec_helper'

describe "A new user creates and event" do

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