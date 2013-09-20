require 'spec_helper'

describe "A new user authorizes" do
  let(:uid) { '12345' }

  context 'with facebook' do
    let(:provider) { 'facebook' }
    let(:email) { 'bob@example.com' }

    it "shows my authorized accounts" do
      visit root_path
      click_link 'Sign up with Facebook'
      expect(page).to have_content(email)
      expect(page).to have_content(provider)
      expect(page).to have_content(uid)
    end
  end

  context 'with twitter' do
    let(:provider) { 'twitter' }

    it "shows my authorized accounts" do
      visit root_path
      click_link 'Sign up with Twitter'
      expect(page).to have_content(provider)
      expect(page).to have_content(uid)
    end
  end

  context 'with linkedin' do
    let(:provider) { 'linkedin' }
    let(:email) { 'wash@firefly.com' }

    it "shows my authorized accounts" do
      visit root_path
      click_link 'Sign up with LinkedIn'
      expect(page).to have_content(provider)
      expect(page).to have_content(email)
      expect(page).to have_content(uid)
    end
  end

  context 'with googleplus' do
    let(:provider) { 'google_oauth2' }

    it "shows my authorized accounts" do
      visit root_path
      click_link 'Sign up with Google Plus'
      expect(page).to have_content(provider)
    end
  end

  context 'with multiple providers' do
    let(:providers) { ['facebook', 'twitter', 'linkedin'] }

    it "shows my authorized accounts" do
      visit root_path
      click_link 'Sign up with Facebook'
      visit root_path
      click_link 'Sign up with Twitter'
      visit root_path
      click_link 'Sign up with LinkedIn'
      providers.each do |provider|
        expect(page).to have_content(provider)
      end
    end
  end

end