require 'spec_helper'

describe "A new user authorizes" do
  let(:uid) { '12345' }

  context 'with facebook' do
    let(:provider) { 'facebook' }
    let(:email) { 'bob@example.com' }

    it "shows my authorized accounts" do
      visit root_path
      click_link 'Connect with Facebook'
      expect(page).to have_content(email)
      expect(page).to have_content(provider)
      expect(page).to have_content(uid)
    end
  end

  context 'with twitter' do
    let(:provider) { 'twitter' }

    it "asks for email if needed" do
      visit root_path
      click_link 'Connect with Twitter'
      expect(page).to have_content('Please provide an email address')
    end

    let(:email) { 'wash@firefly.com' }
    
    it "does not ask for email if it already exists" do
      visit root_path
      click_link 'Connect with LinkedIn'
      visit root_path
      click_link 'Connect with Twitter'
      expect(page).to have_content(provider)
      expect(page).to have_content(uid)
      expect(page).to have_content(email)
    end
  end

  context 'with linkedin' do
    let(:provider) { 'linkedin' }
    let(:email) { 'wash@firefly.com' }

    it "shows my authorized accounts" do
      visit root_path
      click_link 'Connect with LinkedIn'
      expect(page).to have_content(provider)
      expect(page).to have_content(email)
      expect(page).to have_content(uid)
    end
  end

  context 'with googleplus' do
    let(:provider) { 'google_oauth2' }
    let(:email) { 'captain@firefly.com' }

    it "shows my authorized accounts" do
      visit root_path
      click_link 'Connect with Google+'
      expect(page).to have_content(provider)
      expect(page).to have_content(email)
      expect(page).to have_content(uid)
    end
  end

  context 'with multiple providers' do
    let(:providers) { ['facebook', 'twitter', 'linkedin'] }

    it "shows my authorized accounts" do
      visit root_path
      click_link 'Connect with Facebook'
      visit root_path
      click_link 'Connect with Twitter'
      visit root_path
      click_link 'Connect with LinkedIn'
      providers.each do |provider|
        expect(page).to have_content(provider)
      end
    end
  end

end