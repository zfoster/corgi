require 'spec_helper'

describe "A new user creates an event" do

let!(:organization) { create(:organization) }

  it "creates the event" do
    visit root_path
    click_link 'Connect with LinkedIn'
    click_on 'CREATE EVENT'
    fill_in 'Title', with: 'CityCamp'
    fill_in 'Description', with: 'The best city camp event ever'
    check 'enable_fee'
    fill_in 'event_url', with: 'http://www.citycampmadison.org'
    fill_in 'event[start_time]', with: '10/24/2013 16:45'
    fill_in 'event[end_time]', with: '10/24/2013 18:45'
    fill_in 'event[price]', with: '10'
    click_on 'Save'
    expect(page.find('#flash_notice')).to have_content("Event was successfully created.")
    expect(page.find('.hosts')).to have_content("Bob Loblaw")
    expect(page.find('.attendees')).to have_content("Bob Loblaw")
    expect(page).to have_link("Edit")
    expect(page).to have_content('CityCamp')
    expect(page).to have_content('http://www.citycampmadison.org')
    expect(page).to have_content('The best city camp event ever')
    expect(page).to have_content('$10')
    expect(page).to have_content('Madisonium')
    expect(unread_emails_for("bob@example.com").size).to eq(1)
  end

end
