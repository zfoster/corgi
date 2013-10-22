require 'spec_helper'

describe "An authenticated user registers to attend event" do

  let!(:event) { create(:event) }
  let!(:paid_event) { create(:paid_event) }

  context 'chooses an event' do

    it "attends from a list of events" do
      visit root_path
      click_link 'Connect with Facebook'
      click_on 'EVENTS'
      first(:link, 'Attend').click
      expect(page).to have_content event.title
      expect(page).to have_content 'Attending'
      expect(page).to have_link("Cancel")
      expect(unread_emails_for("bob@example.com").size).to eq(1)
    end

    it 'attends a paid event' do
      visit root_path
      click_link 'Connect with Facebook'
      click_on 'EVENTS'
      click_on 'PaidCityCamp'
      click_on 'Attend'
      fill_in 'Card number', with: '1'
      fill_in 'Card Verification Value (CVV)', with: '123'
      fill_in 'Address line 1', with: '123 N Park St.'
      fill_in 'City', with: 'Madison'
      fill_in 'State', with: 'WI'
      fill_in 'Zip code', with: '11111'
      click_on 'Save'
      expect(page).to have_content event.title
      expect(page).to have_content 'Attending'
    end
  end
end
