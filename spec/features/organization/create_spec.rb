require 'spec_helper'

describe "An authenticated user creates an organization" do 

  it "creates the organization" do
    visit root_path
    click_link 'Connect with LinkedIn'
    click_on 'ADD ORGANIZATION'
    fill_in 'Name', with: 'Madison Study Hall'
    attach_file('Image', 'ORG.jpg')
    # post :change_avatar, :avatar => fixture_file_upload('ORG.jpg', 'image/jpg')
    # fixture_file_upload('ORG.jpg', 'image/jpg')

    click_on 'Save'
    expect(page).to have_content('Madison Study Hall')
    expect(page).to have_content('text.png')

    after_create do |image, proxy|  #prevents memory overrun from lack of garbage collection
      proxy.file.close
    end
  end
  
end