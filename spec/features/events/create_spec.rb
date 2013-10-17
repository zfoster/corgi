require 'spec_helper'

describe "A new user creates an event" do

  it "creates the event" do
    visit root_path
    click_link 'Connect with LinkedIn'
    click_on 'CREATE EVENT'
    fill_in 'Title', with: 'CityCamp'
    fill_in 'Description', with: 'The best city camp event ever'
    choose 'Has a fee'
    select '2013', from: 'event[start_time(1i)]'
    select 'December', from: 'event[start_time(2i)]'
    select '10', from: 'event[start_time(3i)]'
    select '06 PM', from: 'event[start_time(4i)]'
    select '30', from: 'event[start_time(5i)]'
    select '2013', from: 'event[end_time(1i)]'
    select 'December', from: 'event[end_time(2i)]'
    select '10', from: 'event[end_time(3i)]'
    select '07 PM', from: 'event[end_time(4i)]'
    select '30', from: 'event[end_time(5i)]'

    fill_in 'event[price]', with: '10'

    click_on 'Save'
    expect(page.find('#flash_notice')).to have_content("Event was successfully created.")
    expect(page.find('.hosts')).to have_content("Bob Loblaw")
    expect(page.find('.attendees')).to have_content("Bob Loblaw")
    expect(page).to have_link("Edit")
    expect(page).to have_content('CityCamp')
    expect(page).to have_content('The best city camp event ever')
    expect(page).to have_content('$10')
    expect(unread_emails_for("bob@example.com").size).to eq(1)
  end

end
