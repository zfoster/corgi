require 'spec_helper'

describe "A new user creates and event" do

    it "creates the event" do
      visit root_path
      click_link 'Connect with LinkedIn'
      click_on 'EVENTS'
      fill_in 'Title', with: 'CityCamp'
      fill_in 'Description', with: 'The best city camp event ever'
      fill_in 'Website', with: 'http://citycampmadison.com'
      choose 'Has a fee'
      select '2013', from: 'Start time'
      select 'December', from: 'Start time'
      select '10', from: 'Start time'
      select '12 PM', from: 'Start time'
      select '06 PM', from: 'Start time'
      select '01', from: 'Start time'
      fill_in 'input[id="event_price"]', with: '10'

      click_on 'Save'
      expect(page.find('#flash_notice')).to have_content("Event was successfully created.")
      expect(page.find('.hosts')).to have_content("wash@firefly.com")
      expect(page.find('.attendees')).to have_content("wash@firefly.com")
      expect(page).to have_link("Edit")
      expect(page).to have_content('CityCamp')
      expect(page).to have_content('The best city camp event ever')
      expect(page).to have_content('citycampmadison.com')
      expect(page).to have_content('$10')
    end

end
