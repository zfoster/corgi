require 'spec_helper'

describe "An authenticated user creates an organization" do 

  it "creates the organization" do
    visit root_path
    click_link 'Connect with LinkedIn'
    click_on 'ADD ORGANIZATION'
    fill_in 'Name', with: 'Madison Study Hall'

    click_on 'Save'
    expect(page).to have_content('Madison Study Hall')
  end
  
end